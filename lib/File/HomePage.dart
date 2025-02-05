import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list_examen/File/ListPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Listpage()),
      );
    });
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "TODOLIST",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
