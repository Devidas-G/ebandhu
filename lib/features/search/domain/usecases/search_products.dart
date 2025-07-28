import '../../../../core/common/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/product.dart';
import '../repositories/search_repository.dart';

class SearchProducts implements UseCase<List<ProductEntity>, String> {
  final SearchRepository repository;

  SearchProducts(this.repository);

  @override
  ResultFuture<List<ProductEntity>> call(String query) async {
    return await repository.search(query);
  }
}
