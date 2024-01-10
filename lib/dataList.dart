// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class dataList extends StatelessWidget {
//   String name;
//   dataList({required this.name, super.key});
//   TextEditingController messageController = TextEditingController();
//
//   Future<void> sendMessage() async {
//     try {
//       Map<String, dynamic> data = {
//         "message": messageController.text,
//         "user": name,
//         "time": FieldValue.serverTimestamp()
//       };
//       var ref =
//           await FirebaseFirestore.instance.collection('messages').add(data);
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('messages').orderBy('time').snapshots(),
//       builder: (context, snapshot) {
//           return snapshot.hasData
//               ? Column(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height - 120,
//                       child: ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           var documents = snapshot.data!.docs[index];
//                           return Column(
//                             crossAxisAlignment: name == documents['user']
//                                 ? CrossAxisAlignment.end
//                                 : CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   width: 200,
//                                   margin: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: name == documents['user']
//                                   ? Colors.red
//                                     : Colors.grey,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20)),
//                                   ),
//
//                                   // width: 200,
//                                   // height: 200,
//                                   child: Column(
//                                     children: [
//                                       Text(documents['user']),
//                                       Text(documents['message']),
//                                     ],
//                                   )),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width - 80,
//                             child: TextField(
//                               controller: messageController,
//                               decoration: InputDecoration(
//                                 labelText: 'Enter your message',
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                               onTap: () {
//                                 sendMessage();
//                               },
//                               child: Icon(
//                                 Icons.arrow_circle_up,
//                                 size: 50,
//                               ))
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               : Center(
//                   child: CircularProgressIndicator(),
//                 );
//       },
//     ),
//         ));
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final String name;

  DataList({required this.name});
  ScrollController _scrollController = ScrollController();

  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage() async {
    try {
      Map<String, dynamic> data = {
        "message": messageController.text,
        "user": name,
        "time": FieldValue.serverTimestamp()
      };
      await FirebaseFirestore.instance.collection('messages').add(data);
    } catch (e) {
      print("error : $e");
    }
  }
  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                    controller: _scrollController,

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var documents = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: name == documents['user']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: name == documents['user']
                                    ? Colors.red
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    documents['user'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(documents['message']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Enter your message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: ()async {
                      await sendMessage();
                      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                    },
                    child: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
