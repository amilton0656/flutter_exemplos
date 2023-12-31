import 'package:flutter/material.dart';
import 'package:compras/models/item_model.dart';
import 'package:provider/provider.dart';

import '../models/items_provider.dart';

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
        Provider.of<ItemsProvider>(context, listen: false).itemBought(item);
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
        trailing: 'Amilton,Selene,Eduardo'.contains(item.usuario)
            ? Text(item.usuario.substring(0, 3))
            : null,
      ),
    );
  }
}
