import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';
import 'package:qr_material_batch/utils/upper_case_text_formatter.dart';

class AddMaterialBatchPage extends StatefulWidget {
  final void Function(BarcodeItem) onAddBarcodeItem;

  const AddMaterialBatchPage({
    super.key,
    required this.onAddBarcodeItem,
  });

  @override
  State<AddMaterialBatchPage> createState() => _AddMaterialBatchPageState();
}

class _AddMaterialBatchPageState extends State<AddMaterialBatchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _materialCodeText = '';
  String _batchNumberText = '';
  String _quantityText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Material Batch',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Material Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 4,
                  ),
                ),
                maxLines: 1,
                maxLength: 15,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  return (value ?? '').trim().length == 15
                      ? null
                      : 'Required 15 Characters';
                },
                onSaved: (newValue) {
                  _materialCodeText = newValue?.trim() ?? '';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Batch No.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 4,
                  ),
                ),
                maxLines: 1,
                maxLength: 10,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  return (value ?? '').trim().length == 10
                      ? null
                      : 'Required 10 Characters';
                },
                onSaved: (newValue) {
                  _batchNumberText = newValue?.trim() ?? '';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: '0.000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 4,
                  ),
                ),
                maxLines: 1,
                maxLength: 16,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,3}'),
                  ),
                ],
                validator: (value) {
                  return (value ?? '').trim().isNotEmpty ? null : 'Required';
                },
                onSaved: (newValue) {
                  _quantityText = newValue?.trim() ?? '';
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          height: 40,
          child: Center(
            child: FilledButton(
              onPressed: _onTapAdd,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromWidth(200),
              ),
              child: const Text('Add'),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final quantity = (double.tryParse(_quantityText) ?? 0.0);

      final data = [
        _materialCodeText,
        _batchNumberText,
        quantity.toStringAsFixed(3).padLeft(20, '0'),
      ].whereType<String>().join().toUpperCase();

      widget.onAddBarcodeItem.call(
        BarcodeItem(
          type: BarcodeItemType.barcode,
          data: data,
        ),
      );
    }
  }
}
