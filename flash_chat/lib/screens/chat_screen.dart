import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import '../objects/Chat.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userText = "";
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, '/');
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          userText = value;
                        },
                        controller: _textFieldController,
                        decoration: kMessageTextFieldDecoration,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (userText.trim() != "") {
                          Chat chatToSend = Chat(
                              text: userText, sender: _auth.currentUser?.email);

                          final docRef = _db.collection("messages");
                          docRef.add(chatToSend.sendToFirestore());
                        }

                        _textFieldController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db.collection("messages").snapshots(),
      builder: (context, snapshot) {
        List<Column> msgColumns = [];

        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ));
        } else {
          for (var msg in snapshot.data!.docs) {
            final msgText = msg.data()['text'];
            final msgSender = msg.data()['sender'];
            bool msgOwner = false;

            if (_auth.currentUser?.email == msgSender) {
              msgOwner = true;
            }

            msgColumns.add(Column(
              crossAxisAlignment:
                  msgOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                msgOwner
                    ? const Text(
                        'Me',
                        style: TextStyle(color: Colors.grey),
                      )
                    : Text(
                        '$msgSender',
                        style: const TextStyle(color: Colors.grey),
                      ),
                const SizedBox(height: 5),
                BubbleMessageWidget(
                    msgOwner: msgOwner,
                    myChild: Text('$msgText',
                        textAlign: msgOwner ? TextAlign.right : TextAlign.left,
                        style: msgOwner ? const TextStyle(color: Colors.white) : const TextStyle(color : Colors.grey))),
                const SizedBox(
                  height: 50,
                ),
              ],
            ));
          }

          return Expanded(
              child: ListView(
                  padding: const EdgeInsets.all(10), children: msgColumns));
        }
      },
    );
  }
}

class BubbleMessageWidget extends StatelessWidget {
  BubbleMessageWidget({required this.myChild, required this.msgOwner});

  Widget myChild;
  bool msgOwner;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            topRight: !msgOwner ? Radius.circular(30) : Radius.circular(0),
            topLeft: msgOwner ? Radius.circular(30) : Radius.circular(0),
        ),
        color: msgOwner ? Colors.lightBlueAccent : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Container(constraints: BoxConstraints(maxWidth: 200), child: myChild),
        ));
  }
}
