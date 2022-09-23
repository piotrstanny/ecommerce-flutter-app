import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  FakeProductsRepository({this.addDelay = true});
  final List<Product> _products = kTestProducts;
  final bool addDelay;

  List<Product> getProductsList() {
    return _products;
  }

  Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (err) {
      return null;
    }
  }

  Product? getProduct(String id) {
    return _getProduct(_products, id);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(products, id));
  }

  Future<List<Product>> fetchProductsList() async {
    await delay(addDelay);
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await delay(addDelay);
    yield _products;
  }
}

// RIVERPOD PROVIDERS FOR THIS REPO:

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

// Provider for using Future call of products
final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

// Provider for using Stream of products
final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint('Created productsListStreamProvider');
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

// By adding family you can add id as argument, which is only passed at runtime,
// e.g. this Product provider is watched in ProductScreen and only then the
// product id is known.
final productProvider = StreamProvider.autoDispose.family<Product?, String>(
  (ref, id) {
    debugPrint('Created productProvider with id: $id');
    ref.onDispose(() => debugPrint('Disposed productProvider id: $id'));
    final productsRepository = ref.watch(productsRepositoryProvider);
    return productsRepository.watchProduct(id);
  },
);
