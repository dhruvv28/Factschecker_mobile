// main.dart
import 'package:faxx_checker/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faxx_checker/providers/theme_provider.dart';
import 'package:faxx_checker/theme/app_theme.dart';
import 'package:faxx_checker/screens/login_screen.dart';
import 'package:faxx_checker/screens/signup_screen.dart';
import 'package:faxx_checker/screens/theme_screen.dart';
import 'package:faxx_checker/screens/main_screen.dart';
import 'package:faxx_checker/widgets/animated_background.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FaxxChecker',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(), // Change to your welcome screen
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            // Get the current route name
            final currentRoute = ModalRoute.of(context)?.settings.name;
            
            // If it's the welcome screen, return the child as is
            if (currentRoute == '/' || currentRoute == null) {
              return child!;
            }
            
            // For all other screens, wrap with AnimatedBackground
            return AnimatedBackground(child: child!);
          },
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/main': (context) => const MainScreen(),
            '/theme': (context) => const ThemeScreen(),
          },
        );
      },
    );
  }
}