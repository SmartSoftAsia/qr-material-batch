import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barcode_item_model.g.dart';

enum BarcodeItemType {
  barcode,
  qr,
  ;

  bool get isBarcode => this == BarcodeItemType.barcode;

  String get title {
    switch (this) {
      case BarcodeItemType.barcode:
        return 'Barcode';
      case BarcodeItemType.qr:
        return 'QR Code';
    }
  }

  IconData get iconData {
    switch (this) {
      case BarcodeItemType.barcode:
        return CupertinoIcons.barcode;
      case BarcodeItemType.qr:
        return CupertinoIcons.qrcode;
    }
  }
}

@JsonSerializable()
class BarcodeItem extends Equatable {
  final BarcodeItemType? type;
  final String? data;

  const BarcodeItem({
    required this.type,
    required this.data,
  });

  factory BarcodeItem.fromJson(Map<String, dynamic> json) =>
      _$BarcodeItemFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeItemToJson(this);

  @override
  List<Object?> get props => [
        type,
        data?.toLowerCase(),
      ];
}
