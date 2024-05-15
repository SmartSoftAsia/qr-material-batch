import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_material_batch/models/material_batch_item_model.dart';
import 'package:qr_material_batch/modules/home/cubit/home_state.dart';

part 'home_cubit.g.dart';

@JsonSerializable()
class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final ScrollController scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey();

  String materialCodeText = '';
  String batchNumberText = '';
  String quantityText = '';

  void onDeleteMaterialBatchItem(MaterialBatchItem item) {
    final items = state.items;
    items.removeWhere((e) => e.qrData() == item.qrData());
    emit(state.copyWith(items));
  }

  void onTapAdd() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final item = MaterialBatchItem(
        materialCode: materialCodeText,
        batchNo: batchNumberText,
        quantity: (double.tryParse(quantityText) ?? 0.0),
      );

      final items = state.items;
      if (items.where((e) => e.qrData() == item.qrData()).isEmpty) {
        items.add(item);
        emit(state.copyWith(items));
      }
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) => HomeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}
