import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';

part 'home_page_state.g.dart';

@JsonSerializable()
class HomePageState extends Equatable {
  final Set<BarcodeItem> items;

  const HomePageState({
    this.items = const {},
  });

  HomePageState copyWith({
    Set<BarcodeItem>? items,
  }) {
    return HomePageState(
      items: items ?? this.items,
    );
  }

  factory HomePageState.fromJson(Map<String, dynamic> json) =>
      _$HomePageStateFromJson(json);

  Map<String, dynamic> toJson() => _$HomePageStateToJson(this);

  @override
  List<Object?> get props => [
        items,
      ];
}
