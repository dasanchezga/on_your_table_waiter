import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/features/table/models/users_table.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:on_your_table_waiter/ui/widgets/buttons/custom_elevated_button.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';

class UserInfoSheet extends ConsumerStatefulWidget {
  const UserInfoSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => UserInfoSheet(),
    );
  }

  @override
  ConsumerState<UserInfoSheet> createState() => _UserInfoSheet();
}

class _UserInfoSheet extends ConsumerState<UserInfoSheet> {
  late TableStatus _tableStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.close)),
            const Flexible(
              child: Text(
                'Username',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 25,
              width: double.infinity,
              child: CustomElevatedButton(onPressed: onLogout, child: const Text('Cerrar sesión')),
            ),
          ]),
    );
  }

  void onLogout() {
    ref.read(authProvider.notifier).logout();
    Navigator.of(context).pop();
  }
}
