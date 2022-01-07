import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/home/model/TaxCart.dart';
import 'package:poshop/products/model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poshop/cart/cart_provider.dart';

class CartContoller extends GetxController {
  RxList<Cart> items = RxList<Cart>();

  var totalCart = 0.obs;
  var indexSingleCart= 0.obs;
  var controllerCheckboxes = GroupController(isMultipleSelection: true).obs;
  RxList<TaxCart> taxes = RxList<TaxCart>();



  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  var dropdownvalue = 'Descuento1'.obs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();



  }

  Cart checkItemCart(Product product) {
    Cart isInCart = null;

    for (var i = 0; i < items.length; i++) {
      if (items[i].product.id == product.id) {
        isInCart = items[i];
      }
    }

    return isInCart;
  }

  addItemCart(product){
    Cart isInCart =
    checkItemCart(
        product);

    if (isInCart == null) {
      isInCart = addEmptyCart(product);
    }

    isInCart.numberItem =
        isInCart.numberItem +
            1;

    int cartIndex =
    checkItemCartIndex(
        product);

    items[
    cartIndex] = isInCart;
  }

  Cart addEmptyCart(product) {
    Cart cartItem = Cart();
    cartItem.product =
        product;
    cartItem.numberItem = 0;
    items
        .add(cartItem);
    return cartItem;
  }

  int checkItemCartIndex(Product product) {
    int isInCart = 0;

    for (var i = 0; i < items.length; i++) {
      if (items[i].product.id == product.id) {
        isInCart = i;
      }
    }

    return isInCart;
  }



  Future setTickets() async {
    var prefs = await SharedPreferences.getInstance();

    _endpointProvider =
    new CartProvider(_client.init(prefs.getString("token")));
    try {
      var data = await _endpointProvider.setTickets(items,totalCart);

      if (data["success"]) {
        return true;
      }
    } catch (e) {

      return false;
    }
  }
}
