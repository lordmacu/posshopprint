import 'package:poshop/tickets/model/Ticket.dart';

class ClientUserModel{

  int _id;
  String _name;
  String _address;
  String  _city;
  String _postalCode;
  String _customerCode;
  String _email;
  String _points;
  String _last_visit;


  String get points => _points;

  set points(String value) {
    _points = value;
  }

  List<Ticket> _tickets=[];


  List<Ticket> get tickets => _tickets;

  set tickets(List<Ticket> value) {
    _tickets = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  String get customerCode => _customerCode;

  set customerCode(String value) {
    _customerCode = value;
  }

  String get postalCode => _postalCode;

  set postalCode(String value) {
    _postalCode = value;
  }

  ClientUserModel();

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'ClientUserModel{_id: $_id, _name: $_name, _address: $_address, _city: $_city, _postalCode: $_postalCode, _customerCode: $_customerCode, _email: $_email, _tickets: $_tickets}';
  }

  String get last_visit => _last_visit;

  set last_visit(String value) {
    _last_visit = value;
  }
}