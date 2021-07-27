import 'CustomException.dart';

class FetchDataException extends CustomException {
  FetchDataException(String message) : super(message, "Error During Communication: ");
}
