
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'chatRoomUser.dart';
import 'contacts.dart';
import 'contactview.dart';
import 'container_button.dart';
import 'dataList.dart';
import 'firebase_options.dart';
import 'firebasehome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: firebasehome(),
      home: ChatroomUser(),
    );
  }
}


