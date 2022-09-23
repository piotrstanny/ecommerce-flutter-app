import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FakeProductsRepository', () {
    FakeProductsRepository makeProductsRepository() =>
        FakeProductsRepository(addDelay: false);

    test('getProductsList returns global list', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    });

    test('getProduct(1) returns first item', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProduct('1'),
        kTestProducts[0],
      );
    });

    test('getProduct(999) returns null', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.getProduct('999'),
        null,
      );
    });

    test('fetchProductsList returns global list of products', () async {
      final productsRepository = makeProductsRepository();
      expect(
        await productsRepository.fetchProductsList(),
        kTestProducts,
      );
    });

    test('watchProductsList emits global list of products', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProductsList(),
        emits(kTestProducts),
      );
    });

    test('watchProduct(1) emits first item', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProduct('1'),
        emits(kTestProducts[0]),
      );
    });

    test('watchProduct(999) emits null', () {
      final productsRepository = makeProductsRepository();
      expect(
        productsRepository.watchProduct('999'),
        emits(null),
      );
    });
  });
}
