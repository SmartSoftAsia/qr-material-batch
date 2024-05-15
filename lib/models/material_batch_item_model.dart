import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material_batch_item_model.g.dart';

@JsonSerializable()
class MaterialBatchItem extends Equatable {
  final String? materialCode;
  final String? batchNo;
  final num? quantity;

  const MaterialBatchItem({
    required this.materialCode,
    required this.batchNo,
    required this.quantity,
  });

  String qrData() {
    return [
      materialCode,
      batchNo,
      quantity?.toStringAsFixed(3).padLeft(20, '0'),
    ].whereType<String>().join().toUpperCase();
  }

  String barcodeData() {
    return [
      materialCode,
      batchNo,
    ].whereType<String>().join().toUpperCase();
  }

  factory MaterialBatchItem.fromJson(Map<String, dynamic> json) =>
      _$MaterialBatchItemFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialBatchItemToJson(this);

  @override
  List<Object?> get props => [materialCode, batchNo, quantity];
}
