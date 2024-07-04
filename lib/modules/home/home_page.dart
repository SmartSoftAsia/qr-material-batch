import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_material_batch/modules/add_barcode/add_barcode_page.dart';
import 'package:qr_material_batch/modules/home/cubit/home_page_cubit.dart';
import 'package:qr_material_batch/modules/home/cubit/home_page_state.dart';
import 'package:qr_material_batch/modules/home/widgets/home_page_barcode_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => HomePageCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          body: _gridView(),
          floatingActionButton: IconButton.filled(
            onPressed: _onTapAdd,
            icon: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }

  Widget _gridView() {
    final cubit = context.read<HomePageCubit>();
    final items = cubit.state.items;
    return Stack(
      fit: StackFit.expand,
      children: [
        LayoutBuilder(
          builder: (_, constraint) {
            final maxWidth = constraint.maxWidth;
            final crossAxisCount = maxWidth < 480 ? 1 : maxWidth ~/ 480;
            const double crossAxisSpacing = 16;
            final width =
                (maxWidth - ((crossAxisCount - 1) * crossAxisSpacing) - 32) /
                    crossAxisCount;
            return GridView.count(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: crossAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: width / 260,
              children: items
                  .map(
                    (e) => HomePageBarcodeTile(
                      item: e,
                      onTapDelete: () => cubit.onDeleteItem(e),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        Visibility(
          visible: items.isEmpty,
          child: Center(
            child: GestureDetector(
              onTap: _onTapAdd,
              child: SvgPicture.asset(
                'assets/images/add_files.svg',
                height: 240,
                width: 240,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTapAdd() {
    final cubit = context.read<HomePageCubit>();
    AddBarcode.show(
      context,
      onAddBarcodeItem: cubit.onAddBarcodeItem,
    );
  }
}
