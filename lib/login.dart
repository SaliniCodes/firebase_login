import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mainhome.dart';


class login extends StatelessWidget {
  login({super.key});
  TextEditingController usercontroller = TextEditingController(text: 'salinikb2000@gmail.com');

  TextEditingController passcontroller= TextEditingController(text: "Salini@123");


  Future<void> loginAccount(String emailAddress,String password,var context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      print(credential);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mainhome();
      },));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  // signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1501312461524-5ebfbb52e2bc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBsYW5lJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D',
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(height: 150),
              Column(
                children: [
                  // Text('SIGN UP'),
                  Text(
                    'LOGIN HERE',
                    style: TextStyle(fontWeight:FontWeight.w600,
                      fontSize: 20, // Set the desired font size
                      color: Colors.blueGrey, // Set the desired font color
                      // You can also set other properties like fontWeight, fontStyle, etc. if needed
                    ),
                  ),
                  SizedBox(height: 10),

                  Text("Never Lost Discover Music",
                  ),
                ],
              ),
              TextField(
                controller: usercontroller,
                decoration: InputDecoration(
                  labelText: 'Enter your Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      loginAccount(usercontroller.text, passcontroller.text, context);
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.queue_music),
                    onPressed: () {
                      // Handle tapping the comment icon
                    },
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
