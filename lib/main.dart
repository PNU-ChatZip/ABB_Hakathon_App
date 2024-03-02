import 'package:d_map/constant/color.dart';
import 'package:d_map/theme/button_theme.dart';
import 'package:d_map/view/home_view.dart';
import 'package:d_map/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

Future main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository.initialize(appKey: dotenv.get('APP_KEY'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        primaryColor: CustomColor.primaryColor,
        elevatedButtonTheme: elevatedButtonTheme,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeView(),
        '/login': (context) => const LoginView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
