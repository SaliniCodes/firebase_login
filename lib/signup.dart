import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mainhome.dart';

class signup extends StatelessWidget {
  signup({Key? key}) : super(key: key);

  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Future<void> registerWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => mainhome()),
      );
    } catch (e) {
      // Handle registration failure
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
               'https://images.unsplash.com/photo-1551894116-15e3812343f1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHBsYW5lJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D',
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
                'SIGN UP',
                style: TextStyle(fontWeight:FontWeight.w600,
                  fontSize: 20, // Set the desired font size
                  color: Colors.green, // Set the desired font color
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
                      registerWithEmailAndPassword(usercontroller.text, passcontroller.text, context);
                    },
                    child: Text('Create Account',),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
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
