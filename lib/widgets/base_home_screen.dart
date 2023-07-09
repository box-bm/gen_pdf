import 'package:gen_pdf/common.dart';
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
  List<String> selecteds = [];
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

  void cleanSelecteds() {
    setState(() {
      selecteds = const [];
    });
  }

  void select(String id) {
    var newSelecteds = [...selecteds];
    if (selecteds.contains(id)) {
      newSelecteds.removeWhere((element) => element == id);
    } else {
      newSelecteds.add(id);
    }
    setState(() {
      selecteds = newSelecteds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text(widget.title),
            actions: widget.actions == null
                ? null
                : [
                    TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Buscar",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 14),
                            constraints: const BoxConstraints(
                                maxWidth: 300, maxHeight: 40)),
                        onChanged: handleSearch),
                    ...widget.actions!(selecteds),
                  ]),
        body: SafeArea(
            child: SizedBox.expand(
          child: buildList(),
        )));
  }

  Widget buildList() {
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

    return ListView.builder(
        itemCount: widget.itemCount,
        itemBuilder: (context, index) =>
            widget.itemBuilder(index, selecteds, select));
  }
}
