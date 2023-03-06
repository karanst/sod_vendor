import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../modal/MessageModel.dart';
import '../modal/User_Model.dart';

class ChatDetailScreen extends StatefulWidget {
   User? user;

  ChatDetailScreen({this.user});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final db = FirebaseFirestore.instance;
  CollectionReference? chatReference;
  TextEditingController _textController = new TextEditingController();
  bool _isWritting = false;

  @override
  void initState() {
    super.initState();
    chatReference =
        db.collection("chats").doc(widget.user!.id.toString()).collection('messages');
  }

  String? chatSenderId;
  TextEditingController messageController =  TextEditingController();
  DateTime dateTime = DateTime.now();
    Message?  userMessage;
    String? messageTime;

      sendChat()async{
        User users =  User(
            id : widget.user!.id,
            name : "${widget.user!.name}",
            imageUrl : "",
            isOnline : widget.user!.isOnline,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("senderId", "${users.id}");
        String? idChek = prefs.getString("senderId");
        print("idCheck here ${idChek}");
        String? senderName;
        senderName = widget.user!.name.toString();
        print("sender name here ${senderName}");
        messageTime =  DateFormat("hh:mm a").format(DateTime.now());
        setState(() {
          messages.add( Message(text: messageController.text.toString(),time: messageTime.toString(),sender: users));
        });
        setState(() {
          messageController.clear();
        });
        chatSenderId = prefs.getString("senderId");
      }

  _chatBubble(Message message, bool isMe, bool isSameUser) {
        print("its me check ${isMe}");
    if (!isMe) {
      print("yes its me");
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.PrimaryDark,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "${message.text.toString()}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                message.time.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColor.PrimaryDark,
                 // backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
                ),
              ),
            ],
          )
              : Container(
            child: null,
          ),
        ],
      );
    } else {
      print("Its not me");
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "${message.text.toString()}",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 15,
                  //.backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                message.time.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          )
              : Container(
            child: null,
          ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: AppColor.PrimaryDark,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: AppColor.PrimaryDark,
            onPressed: () {
              sendChat();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.user!.name.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              widget.user!.isOnline == true ?
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
                  :
              TextSpan(
                text: 'Offline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                 // final bool isMe = message.sender!.id == currentUser.id;
                final bool isMe = message.sender!.id == currentUser.id;
                print("checking isMe ${isMe}");
                 final bool isSameUser = prevUserId == message.sender!.id;
                prevUserId = message.sender!.id;
                return    _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}