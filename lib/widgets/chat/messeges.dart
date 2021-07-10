import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/messege_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messeges extends StatefulWidget {
  @override
  _MessegesState createState() => _MessegesState();
}

class _MessegesState extends State<Messeges> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true, //order messeges different
                itemCount: chatSnapshot.data.documents.length,
                itemBuilder: (ctx, index) => MessegeBubble(
                  chatSnapshot.data.documents[index]['text'],
                  chatSnapshot.data.documents[index]['userId'] ==
                      futureSnapshot.data.uid,
                  chatSnapshot.data.documents[index]['userImage'],
                  chatSnapshot.data.documents[index]['username'],
                  key: ValueKey(chatSnapshot.data.documents[index].documentID),
                ),

                //valuekey is a unique key and use some unique document id
              );
            });
      },
    );
  }
}
