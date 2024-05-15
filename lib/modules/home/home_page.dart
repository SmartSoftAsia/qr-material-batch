import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_material_batch/modules/home/cubit/home_cubit.dart';
import 'package:qr_material_batch/modules/home/cubit/home_state.dart';
import 'package:qr_material_batch/modules/home/widgets/material_batch_item_tile.dart';
import 'package:qr_material_batch/utils/upper_case_text_formatter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (builderContext, state) {
        return Scaffold(
          body: _gridView(builderContext),
          floatingActionButton: IconButton.filled(
            onPressed: () => _showForm(builderContext),
            icon: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }

  Widget _gridView(BuildContext builderContext) {
    final cubit = context.read<HomeCubit>();
    final items = cubit.state.items;
    return Stack(
      fit: StackFit.expand,
      children: [
        LayoutBuilder(
          builder: (_, constraint) {
            final maxWidth = constraint.maxWidth;
            final crossAxisCount = maxWidth ~/ 480;
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
                    (e) => MaterialBatchItemTile(
                      item: e,
                      onTapDelete: () => cubit.onDeleteMaterialBatchItem(e),
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
              onTap: () {
                _showForm(builderContext);
              },
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

  void _showForm(BuildContext builderContext) {
    showDialog(
      context: builderContext,
      builder: (_) {
        final cubit = builderContext.read<HomeCubit>();
        return BlocProvider.value(
          value: builderContext.read<HomeCubit>(),
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxWidth: 480),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) {
                        return (value ?? '').trim().length == 15
                            ? null
                            : 'Required 15 Characters';
                      },
                      onSaved: (newValue) {
                        cubit.materialCodeText = newValue?.trim() ?? '';
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
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) {
                        return (value ?? '').trim().length == 10
                            ? null
                            : 'Required 10 Characters';
                      },
                      onSaved: (newValue) {
                        cubit.batchNumberText = newValue?.trim() ?? '';
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
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,3}'),
                        ),
                      ],
                      validator: (value) {
                        return (value ?? '').trim().isNotEmpty
                            ? null
                            : 'Required';
                      },
                      onSaved: (newValue) {
                        cubit.quantityText = newValue?.trim() ?? '';
                      },
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: cubit.onTapAdd,
                      style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(48),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
