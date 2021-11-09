
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/tickets/model/Ticket.dart';
import 'package:poshop/tickets/ticket_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsContoller extends GetxController{

  var indificualTicket=false.obs;
  var categorySelect=0.obs;

  var tickets=[].obs;


  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
    new TicketProvider(_client.init(prefs.getString("token")));
    getTickets();
  }

  getTickets() async {
   // try {
      var data = await _endpointProvider.getTickets();

      if (data["success"]) {
        var dataJson = (data["data"]);

        print("getticketssssss  ${dataJson}");


         List<Ticket> productsLocal = [];

        for (var i = 0; i < dataJson.length; i++) {
          var payments=dataJson[i]["payments"];

          List<PaymentSimple> paymentsSimple=[];

          for(var p=0; p<payments.length; p++){
            print("payyyments  ${payments}");
            paymentsSimple.add( PaymentSimple(payments["name"], payments["amount"],  payments["method"]));

          }

         Ticket ticket = Ticket(dataJson[i]["id"], dataJson[i]["total"], dataJson[i]["email"], dataJson[i]["code"], dataJson[i]["payments"], dataJson[i]["items"]);

        }

        tickets.assignAll(productsLocal);

        return true;
      }
   /* } catch (e) {
      print("aqui esta el error cinco ${e}");
      return false;
    }*/
  }

}