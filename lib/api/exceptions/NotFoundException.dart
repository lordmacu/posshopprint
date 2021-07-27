import 'CustomException.dart';

class NotFoundException extends CustomException {
  NotFoundException(String message) : super(message, "Not found: ");
}
