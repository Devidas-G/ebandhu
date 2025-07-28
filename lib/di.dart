import 'package:get_it/get_it.dart';

import 'features/auth/auth.dart';
import 'features/home/home.dart';
import 'features/product/product.dart';
import 'features/search/search.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(login: sl(), signup: sl(), logout: sl()),
  );
  // usecases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Repositorys
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(datasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(),
  );

  //! Feature - Home
  // Bloc
  sl.registerFactory(() => HomeBloc(fetchContent: sl()));
  // Usecases
  sl.registerLazySingleton(() => FetchContent(sl()));
  // Repositorys
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(datasource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<HomeRemoteDatasource>(
    // TODO: Change To Real Datasource
    () => FakeStoreDatasource(),
  );

  //! Feature - Product
  // Bloc
  sl.registerFactory(() => ProductBloc(fetchProduct: sl()));
  // Usecases
  sl.registerLazySingleton(() => FetchProduct(sl()));
  // Repositorys
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(datasource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<ProductRemoteDatasource>(
    // TODO: Change To Real Datasource
    () => FakeStoreProductDatasource(),
  );

  //! Feature - Search
  // Bloc
  sl.registerFactory(() => SearchBloc(searchProducts: sl()));
  // Usecases
  sl.registerLazySingleton(() => SearchProducts(sl()));
  // Repositorys
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(datasource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => FakeStoreSearchDatasource(),
  );

  //! Feature -
  // Bloc

  // Usecases

  // Repositorys

  // Datasources
}
