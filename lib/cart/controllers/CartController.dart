import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poshop/cart/cart_provider.dart';

class CartContoller extends GetxController {
  RxList<Cart> items = RxList<Cart>();

  var totalCart = 0.obs;

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new CartProvider(_client.init(prefs.getString("token")));
  }

  Future setTickets() async {
    try {
      var data = await _endpointProvider.setTickets();

      if (data["success"]) {
        return true;
      }
    } catch (e) {
      print("aqui esta el error ${e.toString()}");
      return false;
    }
  }
}
