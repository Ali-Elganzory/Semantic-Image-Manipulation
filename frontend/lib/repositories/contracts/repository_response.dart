import '/third_party/third_party.dart';
import '/exceptions/exceptions.dart';

typedef RepositoryResponse<Type>
    = FutureOr<Either<Failure, SuccessfulRepositoryResponse<Type>>>;

class SuccessfulRepositoryResponse<T> {
  final String message;
  final T data;

  const SuccessfulRepositoryResponse({
    required this.message,
    required this.data,
  });
}
