import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_your_table_waiter/features/restaurant/provider/restaurant_provider.dart';
import 'package:on_your_table_waiter/ui/menu/products_screen_tab.dart';
import 'package:on_your_table_waiter/ui/menu/tables_screen_tab.dart';
import 'package:on_your_table_waiter/ui/menu/menu_screen_tab.dart';

class IndexHomeScreen extends ConsumerStatefulWidget {
  const IndexHomeScreen({super.key});

  static const route = '/menu';

  @override
  ConsumerState<IndexHomeScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<IndexHomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantProvider.notifier).getMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: selectedIndex,
        onDestinationSelected: handleOnNavigate,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.table_bar),
            label: 'Mesas',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.burger),
            label: 'Productos',
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [TablesScreenTab(), MenuScreenTab(), ProductsMenuScreen()],
      ),
    );
  }

  void handleOnNavigate(int index) => setState(() => selectedIndex = index);
}
