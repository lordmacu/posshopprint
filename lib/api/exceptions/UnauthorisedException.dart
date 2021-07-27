import 'CustomException.dart';

class UnauthorisedException extends CustomException {
  UnauthorisedException(String message) : super(message, "Unauthorised: ");
}
