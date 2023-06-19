import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/cubit/login_cubit/login_cubit.dart';
import 'package:flutter_ecatalog/cubit/products_cubit/product_cubit.dart';
import 'package:flutter_ecatalog/cubit/register_cubit/register_cubit_cubit.dart';
import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';
import 'package:flutter_ecatalog/presentation/register_page.dart';
import 'package:flutter_ecatalog/themes/app_theme.dart';

import 'cubit/add_cubit/add_product_cubit.dart';
import 'cubit/product_update/product_update_cubit.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubitCubit(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductCubit(ProductDataSource()),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(ProductDataSource()),
        ),
        // BlocProvider(
        //   create: (context) => UpdateProductBloc(ProductDataSource()),
        // ),
        BlocProvider(
          create: (context) => ProductUpdateCubit(ProductDataSource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        home: const LoginPage(),
      ),
    );
  }
}
