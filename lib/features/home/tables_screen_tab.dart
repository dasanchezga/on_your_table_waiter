import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_widgets/cards/table_grid_card.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/features/table/ui/table_detail_screen.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/widgets/bottom_sheet/user_info_sheet.dart';
import 'package:oyt_front_widgets/loading/loading_widget.dart';

class TablesScreenTab extends ConsumerStatefulWidget {
  const TablesScreenTab({super.key});

  @override
  ConsumerState<TablesScreenTab> createState() => _TablesScreenTab();
}

class _TablesScreenTab extends ConsumerState<TablesScreenTab> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.read(authProvider);
    final tableState = ref.watch(tableProvider);
    return tableState.tables.on(
      onError: (err) => Center(child: Text(err.message)),
      onLoading: () => const LoadingWidget(),
      onInitial: () => const LoadingWidget(),
      onData: (data) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  iconSize: 45,
                  padding: EdgeInsets.zero,
                  onPressed: () => UserInfoSheet.show(context),
                  icon: const Icon(Icons.account_circle_rounded, color: Colors.blue),
                ),
                const SizedBox(width: 5),
                authState.authModel.on(
                  onData: (data) => Flexible(
                    child: Text(
                      'Bienvenido ${data.user.firstName} ${data.user.lastName}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  onError: (e) => Center(child: Text(e.message)),
                  onInitial: () => const LoadingWidget(),
                  onLoading: () => const LoadingWidget(),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text('Mesas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const Text('Aca puedes ver las mesas del restaurante y administrarlas...'),
            const SizedBox(height: 20),
            GridView.builder(
              itemCount: data.tables.length,
              shrinkWrap: true,
              primary: false,
              gridDelegate: TableGridCard.gridDelegate,
              itemBuilder: (context, index) {
                final item = data.tables[index];
                return TableGridCard(
                  item: item,
                  isCallingTable:
                      tableState.customerRequests.data?.callingTables.contains(item.id) ?? false,
                  onSelectTable: (item) =>
                      GoRouter.of(context).push(TableDetailScreen.route, extra: item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
