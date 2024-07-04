import 'package:flutter/material.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';
import 'package:qr_material_batch/utils/upper_case_text_formatter.dart';

class AddBarcodeItemPage extends StatefulWidget {
  final BarcodeItemType type;
  final void Function(BarcodeItem) onAddBarcodeItem;

  const AddBarcodeItemPage({
    super.key,
    required this.type,
    required this.onAddBarcodeItem,
  });

  @override
  State<AddBarcodeItemPage> createState() => _AddBarcodeItemPageState();
}

class _AddBarcodeItemPageState extends State<AddBarcodeItemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _dataText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type.title,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  gapPadding: 4,
                ),
              ),
              maxLines: 1,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              validator: (value) {
                return (value ?? '').trim().isNotEmpty ? null : 'Required';
              },
              onSaved: (newValue) {
                _dataText = newValue?.trim() ?? '';
              },
            ),
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

      widget.onAddBarcodeItem.call(
        BarcodeItem(
          type: widget.type,
          data: _dataText,
        ),
      );
    }
  }
}
