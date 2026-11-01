import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/proof_screens.dart';
import 'widgets/proof_style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: paper,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: paper,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProofApp());
}

class ProofApp extends StatelessWidget {
  const ProofApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Proof',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'serif',
      scaffoldBackgroundColor: paper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: green,
        primary: green,
        surface: paper,
      ),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: ink)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: green,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'serif',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: green,
          side: const BorderSide(color: green),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textStyle: const TextStyle(
            fontFamily: 'serif',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: green,
          textStyle: const TextStyle(
            fontFamily: 'serif',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    initialRoute: '/sign-in',
    routes: {
      '/sign-in': (_) => const SignInScreen(),
      '/today': (_) => const TodayScreen(),
      '/goals': (_) => const GoalsScreen(),
      '/add-goal': (_) => const AddGoalScreen(),
      '/camera': (_) => const CameraScreen(),
      '/post': (_) => const PostScreen(),
      '/feed': (_) => const FeedScreen(),
      '/friends': (_) => const FriendsScreen(),
      '/week': (_) => const WeekScreen(),
      '/reminders': (_) => const RemindersScreen(),
    },
  );
}
