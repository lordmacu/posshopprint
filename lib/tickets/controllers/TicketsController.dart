import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/checkout/models/DiscountSimple.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticket_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsContoller extends GetxController {
  var indificualTicket = false.obs;
  var categorySelect = 0.obs;

  RxList<Ticket> tickets = RxList<Ticket>();

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new TicketProvider(_client.init(prefs.getString("token")));
    //getTickets();
  }

  getTickets() async {
    // try {
    var data = await _endpointProvider.getTickets();

    if (data["success"]) {
      var dataJson = (data["data"]);

      print("getticketssssss  ${dataJson}");

      List<Ticket> itemsLocal = [];

      for (var i = 0; i < dataJson.length; i++) {
        var payments = dataJson[i]["payments"];
        var items = dataJson[i]["items"];

        List<PaymentSimple> paymentsSimple = [];
        List<ItemSimple> itemsSimple = [];

        for (var p = 0; p < payments.length; p++) {
          paymentsSimple.add(PaymentSimple(payments[p]["name"],
              double.parse("${payments[p]["amount"]}"), payments[p]["method"]));
        }

        for (var t = 0; t < items.length; t++) {
          List<DiscountSimple> discountsSimple = [];

          var discounts = items[t]["discounts"];
          for (var d = 0; d < discounts.length; d++) {
            discountsSimple.add(DiscountSimple(
                discounts[d]["discount_id"], discounts[d]["total_discount"]));
          }

          itemsSimple.add(ItemSimple(items[t]["name"], items[t]["quantity"],
              items[t]["amount"], discountsSimple));
        }

        Ticket ticket = Ticket(
            dataJson[i]["id"],
            dataJson[i]["total"],
            dataJson[i]["email"],
            dataJson[i]["code"],
            paymentsSimple,
            itemsSimple);

        itemsLocal.add(ticket);
      }

      tickets.assignAll(itemsLocal);

      return true;
    }
    /* } catch (e) {
      print("aqui esta el error cinco ${e}");
      return false;
    }*/
  }
}
