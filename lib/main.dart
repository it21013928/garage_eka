import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:garage_eka/screens/login_screen.dart';
import 'package:garage_eka/screens/registration_screen.dart';
import 'package:garage_eka/screens/home_screen.dart';
import 'package:garage_eka/screens/profile_screen.dart';
import 'package:garage_eka/screens/edit_profile_screen.dart';
import 'package:garage_eka/screens/selectmanufacture.dart';
import 'package:garage_eka/screens/selectmodel.dart';
import 'package:garage_eka/services/authentication_service.dart';
import 'package:garage_eka/screens/reminder.dart';
import 'package:garage_eka/screens/viewport.dart';
import 'package:garage_eka/screens/edit_carport.dart';
import 'package:garage_eka/services_center/add.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Replace with your app's icon
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized.');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data as User?;
            if (user == null) {
              return LoginScreen();
            }
            return HomeScreen();
          }
          return CircularProgressIndicator();
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
         '/profile': (context) => ProfileScreen(),
          '/edit_profile': (context) => EditProfileScreen(),
          '/manufacture': (context) => ManufactureScreen(),
           '/model': (context) => ModelScreen(),
           '/reminder': (context) => ReminderScreen(),
           '/view_port': (context) => ViewPortScreen(),
          '/edit_port': (context) => EditCarportScreen(),
          '/appointments': (context) => Add(),
      },
    );
  }
}
