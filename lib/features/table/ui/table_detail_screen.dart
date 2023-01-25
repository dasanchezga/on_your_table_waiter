import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/features/product/ui/product_detail.dart';
import 'package:oyt_front_table/modals/change_table_status_sheet.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:oyt_front_table/widgets/table_user_card.dart';
import 'package:oyt_front_table/widgets/table_status_card.dart';
import 'package:oyt_front_widgets/loading/loading_widget.dart';

import 'package:go_router/go_router.dart';

class TableDetailScreen extends ConsumerStatefulWidget {
  const TableDetailScreen({required this.table, super.key});

  static const route = '/table_detail';

  final TableResponse table;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends ConsumerState<TableDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tableProvider.notifier).joinToTable(widget.table);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tableState = ref.watch(tableProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(tableProvider.notifier).leaveTable(widget.table);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Mesa ${widget.table.name}')),
        body: tableState.tableUsers.on(
          onData: (data) => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  children: [
                    TableStatusCard(tableStatus: data.tableStatus),
                    const SizedBox(height: 10),
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: data.users.length,
                      itemBuilder: (context, index) {
                        final item = data.users[index];
                        return TableUserCard(
                          userTable: item,
                          showPrice: true,
                          onEdit: (userTable, productDetail) {
                            GoRouter.of(context).push(
                              '${ProductDetail.route}?productId=${productDetail.id}',
                              extra: productDetail,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: onChangeStatus,
                child: const Text('Cambiar estado de la mesa'),
              ),
              if (data.needsWaiter)
                TextButton(
                  onPressed: () =>
                      ref.read(tableProvider.notifier).stopCallingWaiter(widget.table.id),
                  child: const Text('Dejar de llamar al mesero'),
                ),
              const SizedBox(height: 20),
            ],
          ),
          onError: (error) => Center(child: Text(error.message)),
          onLoading: () => const LoadingWidget(),
          onInitial: () => const Center(child: Text('La mesa esta vacia.')),
        ),
      ),
    );
  }

  void onChangeStatus() => ChangeTableStatusSheet.show(
        context: context,
        table: widget.table,
        onTableStatusChanged: (status) =>
            ref.read(tableProvider.notifier).changeStatus(status, widget.table),
      );
}
