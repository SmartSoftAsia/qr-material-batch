// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_batch_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialBatchItem _$MaterialBatchItemFromJson(Map<String, dynamic> json) =>
    MaterialBatchItem(
      materialCode: json['materialCode'] as String?,
      batchNo: json['batchNo'] as String?,
      quantity: json['quantity'] as num?,
    );

Map<String, dynamic> _$MaterialBatchItemToJson(MaterialBatchItem instance) =>
    <String, dynamic>{
      'materialCode': instance.materialCode,
      'batchNo': instance.batchNo,
      'quantity': instance.quantity,
    };
