import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/router/app_router.dart';
import 'package:news_app/core/constants/app_route_names.dart';
import 'package:news_app/core/local/local_database_set_up.dart';
import 'package:news_app/core/local/set_parameters.dart';
import 'package:news_app/presentation/main/bloc/news_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setUp();
  runApp(const MainApp());
}

Future<void> _setUp() async {
  await SetParameters.init();
  await LocalDatabaseSetUp.setUp();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRouteNames.mainPage,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
