import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/features/restaurant/provider/restaurant_provider.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/ui/menu/help_menu_screen.dart';
import 'package:on_your_table_waiter/ui/menu/menu_screen.dart';
import 'package:on_your_table_waiter/ui/orders/orders_screen.dart';
import 'package:on_your_table_waiter/ui/menu/table_menu_screen.dart';
import 'package:on_your_table_waiter/ui/orders/tables_screen.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/not_authenticated_bottom_sheet.dart';

class IndexOrdersScreen extends ConsumerStatefulWidget {
  const IndexOrdersScreen({super.key});

  static const route = '/orders';
  
  @override
  ConsumerState<IndexOrdersScreen> createState() => _IndexOrdersScreenState();
}

class _IndexOrdersScreenState extends ConsumerState<IndexOrdersScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 55,
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: handleOnNavigate,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.table_bar_outlined),
            label: 'Mesas',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_rounded),
            label: 'Pedidos',
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: const [TablesScreen(),MenuScreen(),OrdersScreen()][selectedIndex],
      ),
    );
  }


void handleOnNavigate(int index) {
    if (index != 3) {
      setState(() => selectedIndex = index);
      return;
    }
  }
}