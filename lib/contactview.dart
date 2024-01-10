import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'contacts.dart';

class contactview extends StatefulWidget {
  contactview({Key? key}) : super(key: key);

  @override
  State<contactview> createState() => _ContactViewState();
}

class _ContactViewState extends State<contactview> {
  List imageUrlList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQey3S6VQ4qIppedXehx8CQYDshaMBwU1UwpQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs7QPGzBefaOz5xC_y7q_Ncne7Kd8J8f85xw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8aKhMUzKc38uUGgOhMfhWkoDeT6qu1ucHiw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5yhD3mGjpoEDHg2TnDM-UNoj1Jn_crs-Z2g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5yhD3mGjpoEDHg2TnDM-UNoj1Jn_crs-Z2g&usqp=CAU',
  ];

  List contact = [];
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List contactList;
    try {
      var snapshot =
      await FirebaseFirestore.instance.collection('contactsinformation').get();
      contactList = snapshot.docs;
      setState(() {
        contact = contactList;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){},backgroundColor: Colors.pink,child:Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Contacts"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return contacts();
                }),
              );
            },
            child: Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1703210466493-994109aec84f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D',

            ),
            fit: BoxFit.cover,
          ),
        ),
          child: Center(
            child: contact.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: contact.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: ClipOval(
                    child: Image.network(
                    imageUrlList[index],
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    fit: BoxFit.cover,
                ),
                ),
                // return ListTile(
                //   leading: Image.network(imageUrlList[index]),
                  title: Text(contact[index]['name']),
                  subtitle: Text(contact[index]['number']),
                 );

              },
            ),
          ),
        ),
      ),
    );
  }
}

