import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';

class HomePageBarcodeTile extends StatelessWidget {
  final BarcodeItem item;
  final VoidCallback onTapDelete;

  const HomePageBarcodeTile({
    super.key,
    required this.item,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final data = item.data ?? '';
    Widget barcode;
    switch (item.type) {
      case null:
        barcode = Container();
        break;
      case BarcodeItemType.barcode:
        barcode = LayoutBuilder(
          builder: (context, constraints) {
            return BarcodeWidget(
              barcode: Barcode.code39(),
              data: data,
              height: 32,
              width: constraints.maxWidth * 0.8,
              drawText: false,
            );
          },
        );
        break;
      case BarcodeItemType.qr:
        barcode = QrImageView(
          data: data,
          version: QrVersions.auto,
        );
        break;
    }
    return Card(
      color: Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: barcode,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SelectableText(
                            item.data ?? '',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _onTapCopy(
                            context,
                            item.data ?? '',
                          );
                        },
                        icon: const Icon(
                          Icons.copy,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  [
                    (item.data ?? '').length.toString(),
                    ((item.data ?? '').length == 1)
                        ? 'Character'
                        : 'Characters',
                  ].join(' '),
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: onTapDelete,
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapCopy(
    BuildContext context,
    String data,
  ) {
    Clipboard.setData(
      ClipboardData(text: data),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text('Copied!'),
          ],
        ),
      ),
    );
  }
}
