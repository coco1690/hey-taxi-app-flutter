

abstract class Resource<T> {}

class Loading   extends Resource {}

class Succes<T> extends Resource<T> {
  final T data;
  Succes( this.data);

}
class ErrorData<T> extends Resource<T> {
  final String message;
  ErrorData( this.message);
}