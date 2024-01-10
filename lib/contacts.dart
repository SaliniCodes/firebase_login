import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'contactview.dart';
import 'firebasehome.dart';

class contacts extends StatefulWidget {
  contacts({super.key});


  @override
  State<contacts> createState() => _mainhomeState();
}

class _mainhomeState extends State<contacts> {
  List products = [];
  TextEditingController usercontroller = TextEditingController();

  TextEditingController passcontroller= TextEditingController();


  Future<void> setData() async {
    try {
      Map<String,dynamic> data ={
        "name":usercontroller.text,
        "number":passcontroller.text
      };
      var ref =
      await FirebaseFirestore.instance.collection('contactsinformation').add(data);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Number saved "),
          // content: const Text("You have raised a Alert Dialog Box"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                usercontroller.clear();
                passcontroller.clear();
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
      );



    } catch (e) {
      print("error : $e");
    }
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){},backgroundColor: Colors.pink,child:Icon(Icons.add)),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Add Contacts"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return contactview();
                  }),
                );
              },
              child: Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
               'https://images.unsplash.com/photo-1703210466493-994109aec84f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),


              image ==null
                  ? CircularProgressIndicator()
                  : Image.file(image!,height: 200,width: 200,),
              TextField(
                controller: usercontroller,
                decoration: InputDecoration(
                  labelText: 'Enter your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  setData();
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.aladin(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton(onPressed:(){
                pickImage();
              }, child:Text('Pick Image')),



              
            ],
          ),
        ),
      ),
    );
  }
}