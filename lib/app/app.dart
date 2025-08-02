import '../features/cart/cart.dart';
import '../features/search/search.dart';
import '../features/wishlist/wishlist.dart';
import 'theme.dart';
import '../features/home/home.dart';
import '../features/product/presentation/bloc/product_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di.dart';
import '../features/auth/auth.dart';
import '../initial_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //do not use BlocProvider(create:...) for auth bloc as it is already regestered in di,
        //else you’ll have two separate AuthBloc instances.
        BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<CartBloc>()),
        BlocProvider(create: (context) => sl<WishlistBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          ); // optional loading screen
        } else if (snapshot.hasData) {
          return InitialPage(); // user is logged in
        } else {
          return AuthPage(); // user is not logged in
        }
      },
    );
  }
}
