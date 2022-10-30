import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_your_table_waiter/ui/menu/menu_screen.dart';
import 'package:on_your_table_waiter/ui/orders/orders_screen.dart';
import 'package:on_your_table_waiter/ui/orders/tables_screen.dart';

class IndexOrdersScreen extends ConsumerStatefulWidget {
  const IndexOrdersScreen({super.key});

  static const route = '/orders';
  
  @override
  ConsumerState<IndexOrdersScreen> createState() => _IndexOrdersScreenState();
}

class _IndexOrdersScreenState extends ConsumerState<IndexOrdersScreen> {
  int selectedIndex = 0;
  late List<bool> _selected;
  bool isSelectionMode = false;

  @override
  void initState(){
    super.initState();
    initializeSelection();
  }

  void initializeSelection(){
    _selected = List<bool>.generate(10, (_) => false);
  }

  @override
  void dispose(){
    _selected.clear();
    super.dispose();
  }

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
            icon: Icon(Icons.notification_important),
            label: 'Pedidos',
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child:  [TablesScreen(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x){
            setState(() {
              isSelectionMode = x;
            });
          },
        ),const MenuScreen(),const OrdersScreen()][selectedIndex],
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