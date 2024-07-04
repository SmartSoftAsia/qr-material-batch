// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeItem _$BarcodeItemFromJson(Map<String, dynamic> json) => BarcodeItem(
      type: $enumDecodeNullable(_$BarcodeItemTypeEnumMap, json['type']),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$BarcodeItemToJson(BarcodeItem instance) =>
    <String, dynamic>{
      'type': _$BarcodeItemTypeEnumMap[instance.type],
      'data': instance.data,
    };

const _$BarcodeItemTypeEnumMap = {
  BarcodeItemType.barcode: 'barcode',
  BarcodeItemType.qr: 'qr',
};
