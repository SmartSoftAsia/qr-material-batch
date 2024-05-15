import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_material_batch/models/material_batch_item_model.dart';

part 'home_state.g.dart';

@JsonSerializable()
class HomeState extends Equatable {
  final List<MaterialBatchItem> items;

  const HomeState({
    this.items = const [],
  });

  HomeState copyWith(List<MaterialBatchItem>? items) {
    return HomeState(
      items: items ?? this.items,
    );
  }

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  @override
  List<Object?> get props => [items.map((e) => e.qrData())];
}
