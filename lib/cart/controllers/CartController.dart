
import 'package:get/get.dart';
import 'package:poshop/cart/model/Cart.dart';

class CartContoller extends GetxController{

  RxList<Cart> items = RxList<Cart>();

  var totalCart=0.obs;
}