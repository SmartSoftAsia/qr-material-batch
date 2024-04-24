import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Material Batch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey();

  String materialCodeText = '';
  String batchNumberText = '';
  String quantityText = '';

  String qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: _body(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            validator: (value) {
              return (value ?? '').trim().length == 15
                  ? null
                  : 'Required 15 Characters';
            },
            onSaved: (newValue) {
              materialCodeText = newValue?.trim() ?? '';
            },
            onChanged: (value) {
              onChanged();
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
            validator: (value) {
              return (value ?? '').trim().length == 10
                  ? null
                  : 'Required 10 Characters';
            },
            onSaved: (newValue) {
              batchNumberText = newValue?.trim() ?? '';
            },
            onChanged: (value) {
              onChanged();
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
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
            ],
            validator: (value) {
              return (value ?? '').trim().isNotEmpty ? null : 'Required';
            },
            onSaved: (newValue) {
              quantityText = newValue?.trim() ?? '';
            },
            onChanged: (value) {
              onChanged();
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: qrData.isNotEmpty,
            child: _qrData(),
          ),
        ],
      ),
    );
  }

  Widget _qrData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: QrImageView(
            data: qrData,
            size: 240,
          ),
        ),
        const SizedBox(height: 24),
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
                    qrData,
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    (qrData.isNotEmpty) ? () => _onTapCopy(qrData) : null,
                icon: const Icon(
                  Icons.copy,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          [qrData.length.toString(), 'Characters'].join(' '),
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  void onChanged() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // ignore: unused_local_variable
      final quantity = (double.tryParse(quantityText) ?? 0.0)
          .toStringAsFixed(3)
          .padLeft(20, '0');

      qrData = [
        materialCodeText,
        batchNumberText,
        quantity,
      ].join().toUpperCase();
    } else {
      qrData = '';
    }
    setState(() {});
  }

  void _onTapCopy(
    String data,
  ) async {
    await Clipboard.setData(
      ClipboardData(text: data),
    );
    HapticFeedback.lightImpact();
    _showCopied();
  }

  void _showCopied() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle),
            SizedBox(width: 8),
            Text('Copied!'),
          ],
        ),
      ),
    );
  }
}
