import 'package:flutter/material.dart';
import 'package:myapp/src/features/auth/application/auth_service.dart';
import 'package:myapp/src/features/auth/infrastructure/firebase_auth_repository.dart';
import 'package:myapp/src/features/auth/presentation/login_screen.dart';
import 'package:myapp/src/features/home/presentation/home_screen.dart';
import 'package:myapp/src/providers/theme_provider.dart';
import 'package:myapp/src/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:myapp/src/l10n/app_localizations.dart'; // Caminho corrigido
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        Provider<FirebaseAuthRepository>(
          create: (_) => FirebaseAuthRepository(firebase_auth.FirebaseAuth.instance),
        ),
        Provider<AuthService>(
          create: (context) => AuthService(context.read<FirebaseAuthRepository>()),
        ),
      ],
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
          title: 'Farm Manager',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AuthWrapper(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<dynamic>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          }
          return const HomeScreen();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
