import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_examen/File/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBhXQF7VWsvzmsh7kE-hE9B0Qmk3SqP7l8",
            authDomain: "todo-list-a2aa2.firebaseapp.com",
            projectId: "todo-list-a2aa2",
            storageBucket: "todo-list-a2aa2.firebasestorage.app",
            messagingSenderId: "1079297207463",
            appId: "1:1079297207463:web:048f89da655137a8f3bf82"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todolist",
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
