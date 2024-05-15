import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_material_batch/models/material_batch_item_model.dart';

class MaterialBatchItemTile extends StatelessWidget {
  final MaterialBatchItem item;
  final VoidCallback onTapDelete;

  const MaterialBatchItemTile({
    super.key,
    required this.item,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: QrImageView(
                    data: item.qrData(),
                    size: 120,
                  ),
                ),
                Center(
                  child: BarcodeWidget(
                    barcode: Barcode.code39(),
                    data: item.barcodeData(),
                    height: 32,
                    drawText: false,
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
                            item.qrData(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _onTapCopy(context, item.qrData());
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
                    item.qrData().length.toString(),
                    'Characters',
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
