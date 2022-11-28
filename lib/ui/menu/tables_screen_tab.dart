import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/ui/table/table_detail_screen.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/user_info_sheet.dart';

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
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onInitial: () => const Center(child: CircularProgressIndicator()),
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
                  onInitial: () => const Center(child: CircularProgressIndicator()),
                  onLoading: () => const Center(child: CircularProgressIndicator()),
                )
              ],
            ),
            const Text('Mesas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const Text('Aca puedes ver las mesas del restaurante y administrarlas...'),
            const SizedBox(height: 20),
            GridView.builder(
              itemCount: data.tables.length,
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final item = data.tables[index];
                return Material(
                  elevation: 2,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  color: item.status.color,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () => GoRouter.of(context).push(TableDetailScreen.route, extra: item),
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
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5, width: double.infinity),
                            Text('${item.status.translatedValue}...'),
                          ],
                        ),
                        if (tableState.customerRequests.data?.callingTables.contains(item.id) ??
                            false)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.bell,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
