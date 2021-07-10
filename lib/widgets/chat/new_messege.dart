import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessege extends StatefulWidget {
  @override
  _NewMessegeState createState() => _NewMessegeState();
}

class _NewMessegeState extends State<NewMessege> {
  var _enteredMessege = '';
  final _controller = new TextEditingController();
  void _sendMessege() async {
    FocusScope.of(context).unfocus();
    final user =
        await FirebaseAuth.instance.currentUser(); //gives current user id
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessege,
      'createdAt': Timestamp.now(), //time stamp is made available by firestore
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _controller.clear();
    setState(() {
      _enteredMessege = '';
    }); //I added to avoid sending same msg again n again
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          //expanded used as text field alone takes up a lot of space
          Expanded(
              child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: 'Send a message...'),
            onChanged: (value) {
              setState(() {
                _enteredMessege = value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessege.trim().isEmpty ? null : _sendMessege,
          ),
        ],
      ),
    );
  }
}
