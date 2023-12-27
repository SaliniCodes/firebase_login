import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebasehome.dart';

class mainhome extends StatefulWidget {
  mainhome({super.key});

  @override
  State<mainhome> createState() => _mainhomeState();
}

class _mainhomeState extends State<mainhome> {
  List products = [];

  Future<void> fetchData() async {
    List productlist;
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('product').get();
      productlist = snapshot.docs;
      setState(() {
        products = productlist;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1495001258031-d1b407bc1776?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHdlbGNvbWUlMjBob21lfGVufDB8fDB8fHww',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return firebasehome();
                    }),
                  );
                },
                child: Text(
                  "SIGNOUT",
                  style: GoogleFonts.aladin(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  fetchData();
                },
                child: Text(
                  "fetchdata",
                  style: GoogleFonts.aladin(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
              ),
              products.isEmpty
                  ? CircularProgressIndicator()
                  : Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          // return Row(
                          //   children: [
                          //     Text(products[index]['name']),
                          //     Text(products[index]['initial']),
                          //
                          //   ],
                          // );
                          return Table(
                            border: TableBorder.all(), // Add borders to the table cells
                            children: List.generate(products.length, (index) {
                              return TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey, // Set background color for the cell
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0), // Adjust padding as needed
                                        child: Row(
                                          children: [
                                            // Display 'name' and 'initial' once for each row
                                            Text(products[index]['name']),
                                            SizedBox(width: 8), // Adding space between name and initial
                                            Text(products[index]['initial']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );



                        },
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('productinserted')
                      .add({'text': 'data added through app'});
                },
                child: Text(
                  "setdata",
                  style: GoogleFonts.aladin(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
