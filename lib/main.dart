import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD-wyTmIACVNLOzLZlyQmGd2YrK3zqoR3A",
          appId: "1:1075820227580:android:80cebdf57acbb2b178a079",
          messagingSenderId: "1075820227580",
          projectId: "project-relay-new",
          databaseURL:
              "https://project-relay-new-default-rtdb.firebaseio.com/"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool a = false;
  bool b = false;
  final DatabaseReference dbr = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _loadInitialValues();
  }

  Future<void> _loadInitialValues() async {
    DataSnapshot snapshotA = await dbr.child('light_a').get();
    DataSnapshot snapshotB = await dbr.child('light_b').get();

    setState(() {
      a = snapshotA.value as bool? ?? false;
      b = snapshotB.value as bool? ?? false;
    });
  }

  Future<void> _toggleLightA() async {
    setState(() {
      a = !a;
    });
    await dbr.child('bulb_01').set(a);
  }

  Future<void> _toggleLightB() async {
    setState(() {
      b = !b;
    });
    await dbr.child('bulb_02').set(b);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My app 07"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              a
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 248, 19, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: _toggleLightA,
                  child: a ? const Text("OFF") : const Text("ON")),
              b
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 60, 248, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: _toggleLightB,
                  child: b ? const Text("OFF") : const Text("ON")),
            ],
          ),
        ),
      ),
    );
  }
}
