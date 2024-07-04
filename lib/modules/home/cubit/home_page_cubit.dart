import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:qr_material_batch/models/barcode_item_model.dart';
import 'package:qr_material_batch/modules/home/cubit/home_page_state.dart';

class HomePageCubit extends HydratedCubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  @override
  HomePageState? fromJson(Map<String, dynamic> json) =>
      HomePageState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomePageState state) => state.toJson();

  void onDeleteItem(BarcodeItem item) {
    Set<BarcodeItem> items = {};
    items.addAll(state.items);
    items.removeWhere((e) => e == item);
    emit(
      state.copyWith(
        items: items,
      ),
    );
  }

  void onAddBarcodeItem(BarcodeItem item) {
    Set<BarcodeItem> items = {};
    items.addAll(state.items);
    items.add(item);
    emit(state.copyWith(items: items));
  }
}
