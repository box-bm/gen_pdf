import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/selecteds_cubit.dart';
import 'package:gen_pdf/utils/device.dart';
import 'package:gen_pdf/widgets/empty_list.dart';

class BaseHomeScreen extends StatefulWidget {
  final String title;
  final List<Widget> Function(List<String> ids)? actions;
  final Function() onInit;
  final Function(String searchValue) onChangedFilter;
  final int itemCount;
  final bool isLoading;
  final String searchInitialValue;
  final Widget? Function(
          int index, List<String> selecteds, Function(String id) select)
      itemBuilder;

  const BaseHomeScreen(
      {super.key,
      required this.title,
      required this.actions,
      required this.onInit,
      required this.itemCount,
      required this.itemBuilder,
      required this.onChangedFilter,
      required this.isLoading,
      this.searchInitialValue = ""});

  @override
  State<BaseHomeScreen> createState() => _BaseHomeScreenState();
}

class _BaseHomeScreenState extends State<BaseHomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    widget.onInit();
    textEditingController.value =
        textEditingController.value.copyWith(text: widget.searchInitialValue);
    super.initState();
  }

  void handleSearch(String value) {
    widget.onChangedFilter(value);
  }

  void select(String id) {
    context.read<SelectedsCubit>().select(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedsCubit, List<String>>(builder: buildWidget);
  }

  Widget buildWidget(BuildContext context, List<String> selecteds) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 14),
            Expanded(
                child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            Row(
              children: [
                isDesktop ? searchWidget() : const SizedBox.shrink(),
                ...widget.actions!(selecteds),
              ],
            ),
            const SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(child: buildList(selecteds))
      ],
    );
  }

  Widget buildList(List<String> selecteds) {
    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (widget.itemCount == 0) {
      if (textEditingController.text.isNotEmpty) {
        return const EmptyList(message: "No se han encontrado resultados");
      }
      return const EmptyList();
    }

    return Column(
      children: [
        isMobile ? searchWidget() : const SizedBox(),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: widget.itemCount,
                itemBuilder: (context, index) =>
                    widget.itemBuilder(index, selecteds, select)))
      ],
    );
  }

  Widget searchWidget() {
    return TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Buscar",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            constraints: const BoxConstraints(maxWidth: 300, maxHeight: 40)),
        onChanged: handleSearch);
  }
}
