import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/change_table_status_sheet.dart';

class TablesScreenTab extends ConsumerStatefulWidget {
  const TablesScreenTab({super.key});

  @override
  ConsumerState<TablesScreenTab> createState() => _TablesScreenTab();
}

class _TablesScreenTab extends ConsumerState<TablesScreenTab> {
  @override
  Widget build(BuildContext context) {
    final tableState = ref.watch(tableProvider);
    return tableState.tables.on(
      onError: (err) => Center(child: Text(err.message)),
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onInitial: () => const Center(child: CircularProgressIndicator()),
      onData: (data) => GridView.builder(
        itemCount: data.tables.length,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          final item = data.tables[index];
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => ChangeTableStatusSheet.show(context, item),
            child: Ink(
              decoration: BoxDecoration(
                color: item.status.color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mesa ${item.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5, width: double.infinity),
                      Text('${item.status.translatedValue}...'),
                    ],
                  ),
                  if (index % 3 == 0)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          FontAwesomeIcons.solidHand,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
