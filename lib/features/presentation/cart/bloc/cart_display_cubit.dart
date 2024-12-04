import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';
import 'package:star_shop/features/domain/order/use_cases/add_product_to_cart_use_case.dart';
import 'package:star_shop/features/domain/order/use_cases/get_products_from_cart_use_case.dart';
import 'package:star_shop/features/domain/order/use_cases/remove_product_from_cart_use_case.dart';
import 'package:star_shop/features/domain/order/use_cases/update_product_ordered_quantity_use_case.dart';
import 'package:star_shop/features/presentation/cart/bloc/cart_display_state.dart';

class CartDisplayCubit extends Cubit<CartDisplayState> {
  CartDisplayCubit() : super(CartDisplayInitialState(products: []));

  List<ProductOrderedEntity> products = [];

  getProductsFromCart() async {
    emit(CartDisplayLoading());
    var response = await GetProductsFromCartUseCase().call();

    response.fold(
      (error) {
        emit(CartDisplayLoadFailure(error: error));
      },
      (data) {
        products = data;
        emit(CartDisplayLoaded(products: products));
      },
    );
  }

  addProductToCart(ProductOrderedEntity product) async {
    products.removeWhere((e) => e.productID == product.productID);
    products.add(product);
    emit(CartDisplayLoaded(products: products));
  }

  removeProductFromCart(String productID) async {
    var response = await RemoveProductFromCartUseCase().call(params: productID);

    response.fold(
      (error) {},
      (data) {
        products.removeWhere((e) => e.productID == productID);
        emit(CartDisplayLoaded(products: products));
      },
    );
  }

  updateProductQuantity(String productID, num quantity, num totalPrice) async {
    var response = await UpdateProductOrderedQuantityUseCase()
        .call(productID: productID, quantity: quantity, totalPrice: totalPrice);

    response.fold(
      (error) {},
      (data) {
        for (var e in products) {
          if (e.productID == productID) {
            e.quantity = quantity;
            e.totalPrice = e.price * e.quantity;
          }
        }
        emit(CartDisplayLoaded(products: products));
      },
    );
  }

  displayInitialState(){
    emit(CartDisplayInitialState(products: []));
  }
}
