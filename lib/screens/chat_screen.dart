import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messeges.dart';
import '../widgets/chat/new_messege.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  //and init code downward....
  //cpnverting stateless to stateful for ios setup
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(), //to remove ugly underline
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //expanded ensures list takes only space as needed also maing it scrollable
            Expanded(child: Messeges()),
            NewMessege(), //m using a different spelling
          ],
        ),
      ),
    );
  }
}
//Previous Codes and Some Logic
//     .listen((data) {
//   // print(data.documents[0]['text']);
//   data.documents.forEach((document) {
//     print(document['text']);
//   });
// });

//there is always one active instance that is managed on out behalf and then we can access methods
//we can use collection to reach out to the collection
//SnapShot returns a stream it's gonna emit realtime value, that is everytime new value given if data changes
