import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/checkout/models/DiscountSimple.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/home/model/TaxCart.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticket_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TicketsContoller extends GetxController {
  var indificualTicket = false.obs;
  var categorySelect = 0.obs;

  RxList<Ticket> tickets = RxList<Ticket>();
  Rx<Ticket> TicketIndividual= Rx<Ticket>();
  Rx<int> indexTicket= Rx<int>();
  var panelController = PanelController().obs;

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
    tickets.refresh();
    tickets.clear();
    tickets.refresh();
    var prefs = await SharedPreferences.getInstance();

    _endpointProvider =
    new TicketProvider(_client.init(prefs.getString("token")));
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
        List<TaxCart> taxCartList = [];
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
                discounts[d]["discount_id"], discounts[d]["discount_applied"]));
          }

          itemsSimple.add(ItemSimple(items[t]["name"], items[t]["quantity"],
              items[t]["amount"], discountsSimple));
        }


        if(dataJson[i]["taxes"]!=null){
          for(var t=0 ; t <dataJson[i]["taxes"].length ; t ++){

            var tax=dataJson[i]["taxes"][t];
            TaxCart taxCart = TaxCart(0, "${tax["rate"]}", tax["name"], "${tax["total_tax"]}", tax["tax_type"]);
            taxCartList.add(taxCart);
          }
        }



        DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dataJson[i]["date"]);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        var outputDate = outputFormat.format(inputDate);

        print("asdfasdf asd datetime  ${outputDate}");

        Ticket ticket = Ticket();
        ticket.id=dataJson[i]["id"];
        ticket.total=dataJson[i]["total"];
        ticket.email=dataJson[i]["email"];
        ticket.code=dataJson[i]["code"];
        ticket.date=outputDate;
        ticket.taxes=taxCartList;
        ticket.payments=paymentsSimple;
        ticket.items=itemsSimple;
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
