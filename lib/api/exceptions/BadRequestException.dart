import 'CustomException.dart';

class BadRequestException extends CustomException {
  BadRequestException(String message) : super(message, "Invalid Request: ");
}
