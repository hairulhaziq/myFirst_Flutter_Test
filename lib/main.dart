import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCz3bm8GmT_Wv7Wmpw30VeLh5_r3S9K7O0",
      appId: "1:42048776440:android:fb31f72077a7a87967330d",
      messagingSenderId: "42048776440",
      projectId: "myfirst-flutter-test",
    ),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myFirst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const LoginScreen(),
    );
  }
}
