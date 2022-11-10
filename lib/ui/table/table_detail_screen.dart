import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:on_your_table_waiter/core/constants/lotti_assets.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/change_table_status_sheet.dart';
import 'package:on_your_table_waiter/ui/widgets/buttons/custom_elevated_button.dart';

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
    //TODO: SUSCRIBE TO SOCKET
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mesa ${widget.table.name}')),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Lottie.asset(
                  LottieAssets.ordering,
                  width: 140,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Estado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Ordenando...'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // ListView.separated(
          //   separatorBuilder: (context, index) => const Divider(),
          //   shrinkWrap: true,
          //   primary: false,
          //   itemCount: tableData.users.length,
          //   itemBuilder: (context, index) {
          //     final item = tableData.users[index];
          //     return TableUserCard(userTable: item, showPrice: true);
          //   },
          // ),
          CustomElevatedButton(
            onPressed: onChangeStatus,
            child: const Text('Cambiar estado de la mesa'),
          ),
          TextButton(onPressed: () {}, child: const Text('Dejar de llamar al mesero')),
        ],
      ),
    );
  }

  void onChangeStatus() => ChangeTableStatusSheet.show(context, widget.table);
}