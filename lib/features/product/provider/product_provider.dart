import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/external/socket_handler.dart';
import 'package:oyt_front_core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/product/provider/product_state.dart';
import 'package:oyt_front_product/repositories/product_repositories.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:oyt_front_widgets/error/error_screen.dart';

final productProvider = StateNotifierProvider<ProductProvider, ProductState>((ref) {
  return ProductProvider.fromRead(ref);
});

class ProductProvider extends StateNotifier<ProductState> {
  ProductProvider({
    required this.productRepository,
    required this.ref,
    required this.socketIOHandler,
  }) : super(ProductState(productDetail: StateAsync.initial()));

  factory ProductProvider.fromRead(Ref ref) {
    final productRepository = ref.read(productRepositoryProvider);
    final socketIo = ref.read(socketProvider);
    return ProductProvider(
      ref: ref,
      productRepository: productRepository,
      socketIOHandler: socketIo,
    );
  }

  final Ref ref;
  final ProductRepository productRepository;
  final SocketIOHandler socketIOHandler;

  void cleanProduct() {
    state = ProductState(productDetail: StateAsync.initial());
  }

  Future<void> productDetail(String productID) async {
    state = state.copyWith(productDetail: StateAsync.loading());
    final res = await productRepository.productDetail(productID);
    res.fold(
      (l) {
        state = state.copyWith(productDetail: StateAsync.error(l));
        ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': l.message});
      },
      (r) {
        state = state.copyWith(productDetail: StateAsync.success(r));
      },
    );
  }
}
