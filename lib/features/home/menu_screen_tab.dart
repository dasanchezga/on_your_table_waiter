import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/features/product/ui/product_detail.dart';
import 'package:on_your_table_waiter/features/restaurant/provider/restaurant_provider.dart';
import 'package:oyt_front_menu/ui/menu_screen_body.dart';
import 'package:oyt_front_widgets/loading/screen_loading_widget.dart';

class MenuScreenTab extends ConsumerWidget {
  const MenuScreenTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantState = ref.watch(restaurantProvider);
    return restaurantState.restaurant.on(
      onError: (error) => Center(child: Text(error.message)),
      onLoading: () => const ScreenLoadingWidget(),
      onInitial: () => const ScreenLoadingWidget(),
      onData: (data) => MenuScreenBody(
        restaurantData: data,
        onTapProduct: (menuItem) => GoRouter.of(context).push(
          '${ProductDetail.route}?productId=${menuItem.id}',
        ),
      ),
    );
  }
}
