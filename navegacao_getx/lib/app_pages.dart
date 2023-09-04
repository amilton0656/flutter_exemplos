import 'package:get/get.dart';
import 'package:navegacao_getx/home_screen.dart';
import 'package:navegacao_getx/tela01_screen.dart';
import 'package:navegacao_getx/tela02_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: PagesRoutes.tela01Route,
      page: () => const Tela01Screen(),
    ),
    GetPage(
      name: PagesRoutes.tela02Route,
      page: () => const Tela02Screen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String tela01Route = '/tela01';
  static const String tela02Route = '/tela02';
  static const String homeRoute = '/';
}
