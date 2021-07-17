import 'ClientRequest.dart';

class ClientsRequest {
  List<ClientRequest>? clients;

  ClientsRequest({
    this.clients,
  });

  factory ClientsRequest.fromJson(Map<String, dynamic> json) {
    return ClientsRequest(
      clients: List<ClientRequest>.from(
          json['data'].map((model) => ClientRequest.fromJson(model))),
    );
  }
}
