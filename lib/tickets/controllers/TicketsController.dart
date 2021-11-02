
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
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
    try {
      var data = await _endpointProvider.getTickets();

      if (data["success"]) {
        var dataJsonGeneral = (data["data"]);
        var dataJson = dataJsonGeneral["data"];
        List<Ticket> productsLocal = [];

        for (var i = 0; i < dataJson.length; i++) {
          Ticket ticket = Ticket(_id, _total, _email, _code, _payments, _items);

        }

        tickets.assignAll(productsLocal);

        return true;
      }
    } catch (e) {
      print("aqui esta el error ${e}");
      return false;
    }
  }

}