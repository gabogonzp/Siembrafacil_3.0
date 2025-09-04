import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:siembra_facil/firebase_options.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:siembra_facil/screens/main/weather_tab.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/main/main_screen.dart';
import 'screens/parcels/parcel_management_screen.dart';
import 'screens/analysis/analysis_request_screen.dart';
import 'screens/analysis/analysis_results_screen.dart';
import 'screens/recommendations_screen.dart';
import 'services/auth_services.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the date and time formatting data for all locales.
  // This must be done before any date/time formatting functions are called.
  // Passing null, null loads data for all supported locales.
  await initializeDateFormatting(null, null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SiembraFacilApp());
}

class SiembraFacilApp extends StatelessWidget {
  const SiembraFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiembraFácil',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2E7D32),
        fontFamily: 'Roboto',
      ),
      home: const OnboardingScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/main': (context) => const MainScreen(),
        '/parcels': (context) => const ParcelManagementScreen(),
        '/weather': (context) => const WeatherTab(),
        '/analysis-request': (context) => const AnalysisRequestScreen(),
        '/analysis-results': (context) => const AnalysisResultsScreen(),
        '/recommendations': (context) => const RecommendationsScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authServices.value.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
