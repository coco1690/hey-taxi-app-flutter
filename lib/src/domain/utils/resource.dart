

abstract class Resource<T> {}

class Loading   extends Resource {}

class Succes<T> extends Resource {
  final T data;
  Succes( this.data);

}
class ErrorData<T> extends Resource {
  final String message;
  ErrorData( this.message);
}