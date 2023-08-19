import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditQuantityDialog extends HookWidget {
  final num? initialQuantity;

  const EditQuantityDialog({
    Key? key,
    this.initialQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return AlertDialog(
      content: TextField(
        controller: textController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: initialQuantity == null
              ? 'Nouvelle quantité'
              : 'Nouvelle quantité (actuellement $initialQuantity)',
        ),
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Modifier'),
          onPressed: () {
            final newQuantity = num.tryParse(textController.text);
            if (newQuantity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Doit être un nombre'),
                ),
              );
              return;
            }
            if (newQuantity < 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Doit être un nombre positif'),
                ),
              );
              return;
            }
            Navigator.of(context).pop(newQuantity);
          },
        ),
      ],
    );
  }
}
