abstract class AbstractException implements Exception {
  String message;
  int code;
  AbstractException(this.message, {this.code = 0});
}

class NotFoundException extends AbstractException {
  NotFoundException(super.message) : super(code: 0001);
}

class InvalidException extends AbstractException {
  InvalidException(super.message) : super(code: 0002);
}

class UnCatchException extends AbstractException {
  UnCatchException(super.message) : super(code: 0003);
}
