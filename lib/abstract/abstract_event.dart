abstract class AbstractEvent {}

abstract class InputEvent extends AbstractEvent {

}

abstract class OutputEvent extends AbstractEvent {
  Exception? exception;
}
