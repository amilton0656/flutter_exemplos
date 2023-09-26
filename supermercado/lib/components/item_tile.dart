import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado/item_model.dart';
import 'package:supermercado/item_provider.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final String usuario;
  final Function onModal;

  const ItemTile({
    super.key,
    required this.item,
    required this.usuario,
    required this.onModal,
  });

  @override
  Widget build(BuildContext context) {
    String pre = item.isBought ? '---> ' : '';
    return GestureDetector(
      onDoubleTap: () {
        Provider.of<ItemProvider>(context, listen: false).itemBought(item);
      },
      onLongPress: () {
        onModal(item: item);
      },
      child: ListTile(
        textColor: Colors.black,
        leading: Text(item.quantidade.toString()),
        title: Text(
          pre + item.descricao,
          style: TextStyle(
            decoration: item.isBought
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Text(item.grupo.toString()),
      ),
    );
  }
}
