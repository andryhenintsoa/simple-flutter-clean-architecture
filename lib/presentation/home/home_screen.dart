import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_clean_architecture/core/extensions/num/displayable_text.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/dialogs/edit_quantity_dialog.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/home/home_logic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStateNotifierProvider);

    useMemoized(() async => Future(ref.read(homeStateNotifierProvider.notifier).initialize));

    final categorizedProducts = state.products.groupListsBy((element) => element.category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Total : ${state.total.displayableText} €'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...categorizedProducts.entries.map(
              (e) {
                final categoryName = e.key.name;
                final categoryProducts = e.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categoryName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    ...categoryProducts.map(
                      (e) => Card(
                        child: InkWell(
                          onTap: () async {
                            final newQuantity = await showDialog<num>(
                              context: context,
                              builder: (context) => EditQuantityDialog(
                                initialQuantity: state.cart[e.id],
                              ),
                            );
                            if (newQuantity != null) {
                              ref.read(homeStateNotifierProvider.notifier).setProductQuantity(e, newQuantity);
                            }
                          },
                          child: ListTile(
                            title: Text(e.name),
                            subtitle: e.description == null
                                ? null
                                : Text(
                                    e.description!,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if ((state.cart[e.id] ?? -1) > 0) ...[
                                  IconButton(
                                    onPressed: () {
                                      ref.read(homeStateNotifierProvider.notifier).reduceItemOnCart(e);
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    state.cart[e.id]!.toString(),
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                                IconButton(
                                  onPressed: () {
                                    ref.read(homeStateNotifierProvider.notifier).addItemOnCart(e);
                                  },
                                  icon: const Icon(Icons.add_circle),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
