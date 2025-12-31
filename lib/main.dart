import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lati_game_app/helpers/notification_helper.dart';
import 'package:lati_game_app/providers/auth_provider.dart';
import 'package:lati_game_app/providers/base_provider.dart';
import 'package:lati_game_app/providers/dark_mode_provider.dart';
import 'package:lati_game_app/providers/games_providers.dart';
import 'package:lati_game_app/screens/home_screen.dart';
import 'package:lati_game_app/screens/login_screen.dart';
import 'package:lati_game_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    if (kDebugMode) {
      print("BACKGROUND MESSAGE");
      print("Handling a background message: ${message.messageId}");
      print("Notification Data: ${message.data}");
      print("message ---");
    }
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("FOREGROUND MESSAGE");
    }

    showFlutterNotification(message);
  });

  await setupFlutterNotifications();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
            create: (context) => BaseProvider()),
        ChangeNotifierProvider<GamesProviders>(create: (_) => GamesProviders()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()..getMode()),
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (context) => AuthenticationProvider()),
      ],
      child:
          Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GAMER',
            theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(),
              scaffoldBackgroundColor:
                  darkModeConsumer.isDark ? Colors.black : Colors.white,
              useMaterial3: true,
            ),
            home: const SplashScreen());
      }),
    );
  }
}

class ScreenRoute extends StatefulWidget {
  const ScreenRoute({super.key});

  @override
  State<ScreenRoute> createState() => _ScreenRouteState();
}

class _ScreenRouteState extends State<ScreenRoute> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return firebaseAuth.currentUser != null
        ? const HomeScreen()
        : const LoginScreen();
  }
}
