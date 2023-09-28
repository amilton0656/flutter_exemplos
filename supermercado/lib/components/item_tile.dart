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
    String pre = item.isbought ? '---> ' : '';

    TextStyle estilo = TextStyle(
      decoration:
          item.isbought ? TextDecoration.lineThrough : TextDecoration.none,
    );
    return GestureDetector(
      onDoubleTap: () async {
        final response = await Provider.of<ItemProvider>(context, listen: false)
            .itemBought(item);
      },
      onLongPress: () {
        onModal(item: item);
      },
      child: ListTile(
        textColor: Colors.black,
        leading: SizedBox(
          width: 50,
          child: Text(
            item.quantidade.toString(),
            style: estilo,
          ),
        ),
        title: Text(
          pre + item.descricao,
          style: estilo,
        ),
        trailing: Text(item.grupo.toString()),
      ),
    );
  }
}
