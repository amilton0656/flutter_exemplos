import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/components/item_tile.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/item_provider.dart';

class ListPage extends StatefulWidget {
  final String usuario;
  final Color color;
  final Function onModal;

  const ListPage({
    super.key,
    required this.usuario,
    required this.color,
    required this.onModal,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ItemModel> loadedItems = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      loadedItems = Provider.of<ItemProvider>(context, listen: false)
          .getItems(widget.usuario);
    });
  }

  Future<void> refreshItems(BuildContext context) async {
    loadedItems = Provider.of<ItemProvider>(context, listen: false)
        .getItems(widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (ctx, items, child) => RefreshIndicator(
        onRefresh: () => refreshItems(context),
        child: Container(
          color: widget.color,
          child: ListView.builder(
            itemCount: loadedItems.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(loadedItems[index].id),
              onDismissed: (_) {
                Provider.of<ItemProvider>(context, listen: false)
                    .removeItem(loadedItems[index].id);
              },
              child: ItemTile(
                item: loadedItems[index],
                usuario: widget.usuario,
                onModal: widget.onModal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
