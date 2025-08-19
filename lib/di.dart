import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/auth.dart';
import 'features/cart/cart.dart';
import 'features/home/home.dart';
import 'features/orders/orders.dart';
import 'features/product/product.dart';
import 'features/search/search.dart';
import 'features/wishlist/wishlist.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //! Firebase core services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

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
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => FirebaseAuthDataSourceImpl(auth: sl<FirebaseAuth>()),
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
  sl.registerFactory(
    () => ProductBloc(fetchProduct: sl(), favoriteStatus: sl()),
  );
  // Usecases
  sl.registerLazySingleton(() => FetchProduct(sl()));
  sl.registerLazySingleton(() => FavoriteStatus(sl()));
  // Repositorys
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(datasource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<ProductRemoteDatasource>(
    // TODO: Change To Real Datasource
    () => FakeStoreProductDatasource(
      firestore: sl<FirebaseFirestore>(),
      userId: sl<FirebaseAuth>().currentUser?.uid,
    ),
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

  //! Feature - Cart
  // Bloc
  sl.registerFactory(
    () => CartBloc(
      clearCart: sl(),
      fetchCart: sl(),
      addItemToCart: sl(),
      removeItemFromCart: sl(),
      updateItemInCart: sl(),
    ),
  );
  // Usecases
  sl.registerLazySingleton(() => FetchCart(sl()));
  sl.registerLazySingleton(() => AddItemToCart(sl()));
  sl.registerLazySingleton(() => RemoveItemFromCart(sl()));
  sl.registerLazySingleton(() => UpdateItemInCart(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));
  // Repositorys
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(datasource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => FirebaseCartDatasource(
      firestore: sl<FirebaseFirestore>(),
      userId: sl<FirebaseAuth>().currentUser?.uid,
    ),
  );

  //! Feature - Wishlist
  // Bloc
  sl.registerFactory(
    () => WishlistBloc(
      fetchWishlist: sl(),
      addToWishlist: sl(),
      removeFromWishlist: sl(),
      clearWishlist: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => AddToWishlist(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlist(sl()));
  sl.registerLazySingleton(() => FetchWishlist(sl()));
  sl.registerLazySingleton(() => ClearWishlist(sl()));

  // Repositorys
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(dataSource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => FirebaseWishlistDatasource(
      firestore: sl<FirebaseFirestore>(),
      userId: sl<FirebaseAuth>().currentUser?.uid,
    ),
  );

  //! Feature - Orders
  // Bloc
  sl.registerFactory(() => OrdersBloc(fetchOrders: sl()));
  // Usecases
  sl.registerLazySingleton(() => FetchOrders(sl()));
  // Repositorys
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(dataSource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => FirebaseOrdersDataSource(
      firestore: sl<FirebaseFirestore>(),
      userId: sl<FirebaseAuth>().currentUser?.uid,
    ),
  );

  //! Feature -
  // Bloc

  // Usecases

  // Repositorys

  // Datasources
}
