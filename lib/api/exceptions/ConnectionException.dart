import 'CustomException.dart';

class ConnectionException extends CustomException {
  ConnectionException(String message) : super(message, "No Internet connection: ");
}
