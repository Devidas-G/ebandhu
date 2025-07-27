import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class FetchContent implements UseCase<List<ProductEntity>, NoParams> {
  final HomeRepository repository;

  FetchContent(this.repository);
  @override
  ResultFuture<List<ProductEntity>> call(NoParams params) async {
    return await repository.fetchContent();
  }
}
