import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';
import 'package:qr_material_batch/modules/add_barcode/add_barcode_item_page.dart';
import 'package:qr_material_batch/modules/add_barcode/add_material_batch_page.dart';

class AddBarcode {
  static void show(
    BuildContext context, {
    required void Function(BarcodeItem) onAddBarcodeItem,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.hardEdge,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 480,
              maxHeight: 384,
            ),
            child: Stack(
              children: [
                MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                    ),
                    useMaterial3: true,
                  ),
                  routerConfig: GoRouter(
                    initialLocation: '/',
                    routes: [
                      /// '/'
                      GoRoute(
                        path: '/',
                        builder: (context, state) => const AddBarcodePage(),
                        routes: [
                          /// '/material-batch'
                          GoRoute(
                            path: 'material-batch',
                            builder: (context, state) {
                              return AddMaterialBatchPage(
                                onAddBarcodeItem: onAddBarcodeItem,
                              );
                            },
                          ),

                          /// '/barcode'
                          GoRoute(
                            path: 'barcode',
                            builder: (context, state) {
                              return AddBarcodeItemPage(
                                type: BarcodeItemType.barcode,
                                onAddBarcodeItem: onAddBarcodeItem,
                              );
                            },
                          ),

                          /// '/qr'
                          GoRoute(
                            path: 'qr',
                            builder: (context, state) {
                              return AddBarcodeItemPage(
                                type: BarcodeItemType.qr,
                                onAddBarcodeItem: onAddBarcodeItem,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () {
                      dialogContext.pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddBarcodePage extends StatefulWidget {
  const AddBarcodePage({
    super.key,
  });

  @override
  State<AddBarcodePage> createState() => _AddBarcodePageState();
}

class _AddBarcodePageState extends State<AddBarcodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _button(
                iconData: CupertinoIcons.barcode,
                title: 'Material Batch',
                onPressed: () {
                  context.push('/material-batch');
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _button(
                iconData: CupertinoIcons.barcode,
                title: 'Barcode',
                onPressed: () {
                  context.push('/barcode');
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _button(
                iconData: CupertinoIcons.qrcode,
                title: 'QR Code',
                onPressed: () {
                  context.push('/qr');
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required IconData iconData,
    required String title,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
          ),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    );
  }
}
