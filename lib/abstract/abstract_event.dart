import 'package:chat/abstract/abstract_exception.dart';

abstract class AbstractEvent {}

abstract class InputEvent extends AbstractEvent {

}

abstract class OutputEvent extends AbstractEvent {
  AbstractException? exception;
}
