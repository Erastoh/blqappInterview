
import 'dart:convert';

import 'package:blqdeveloper/Constants/const.dart';
import 'package:blqdeveloper/Models/chatmessage.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/src/widgets/async.dart' as conn;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  FocusNode _focusNode = FocusNode();
  sendmessage({String? message}) async {
    try {
      var response = await http.post(Uri.parse(apiurl),
          headers: {
            'header': apitoken!
          },
          body: {
            'ride_id': "widget.rideid",
            'user_type': "driver",
            'message' : message
          });

      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
      }
    } catch (e) {
      // "ERROR IS THIS ==========\n$e");
    }
  }

  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 3), (_) async {
      var response = await http.post(Uri.parse(apiurl), headers: {
        'header': apitoken!
      }, body: {
        'message': "rideid",
      });

      return await http.post(Uri.parse(apiurl), headers: {
        'header': apitoken!
      }, body: {
        'message': "rideid",
      });
    }).asyncMap((event) async => await event);
  }

  String email = 'erastudmugambi@gmail.com';



  chatUser() async {
    // Hash the email using SHA-256 algorithm
    var bytes = utf8.encode(email); // Convert email to UTF-8 bytes
    var digest = sha256.convert(bytes); // Calculate SHA-256 hash
    // Convert the hash digest to a hexadecimal string
    var hashedEmail = digest.toString();

    final sendbird = SendbirdSdk(appId: sendbirdappid);

    try {
      // connect sendbird server with user id
      final user = await sendbird.connect(hashedEmail);
      print("user---$user");

      // generate group channel parameters
      final params = GroupChannelParams()
        ..userIds = [user.userId]
        ..operatorUserIds = [user.userId]
        ..name = 'YOUR_GROUP_NAME'
        ..customType = 'CUSTOM_TYPE'
        ..isPublic = true;

      // create group channel
      final channel = await GroupChannel.createChannel(params);

      // send user message to the group channel
      channel.sendUserMessageWithText('Hello World',
          onCompleted: (message, error) {
            // message has been sent successfully
            print('${message.message} has been sent!');
          });
    } catch (e) {
      // handle error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Messages',style: appbar),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),

                // Icon(Icons.more_vert,color: Colors.grey.shade700,),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu_sharp, color: Colors.white, size: 30,),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => JobSummary()),
              // );
              // Navigate to the next page or perform other actions
              print('Next Page pressed');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                StreamBuilder<http.Response>(
                    stream: getRandomNumberFact(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == conn.ConnectionState.waiting) {
                        return Container(
                          // height: 70,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ACTIVECOLOR,
                            ),
                          ),
                        );
                      } else if (snapshot.data == null) {
                        return Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "You Have No Messages",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ));
                      } else if (GetChatMessage.fromJson(jsonDecode(snapshot.data!.body)) == '' || GetChatMessage.fromJson(jsonDecode(snapshot.data!.body)) == null) {
                        return Container(
                          child: Center(
                            child: Text(
                              "No Messages",
                              style: nnomessage,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        var mainmessage =
                        GetChatMessage.fromJson(jsonDecode(snapshot.data!.body!));
                        return mainmessage.messages == null
                            ? Container(
                          child: Container(
                            child: Center(
                                child: Text(
                                  "No Messages",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        )
                            : SingleChildScrollView(
                          reverse: true,
                          child: ListView.builder(

                              itemCount: mainmessage.messages!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 30),
                              physics: ScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Align(
                                  child: BubbleNormal(
                                    text:
                                    "${mainmessage.messages![i].message} \n ${mainmessage.messages![i].datetime}",

                                    tail: true,
                                    isSender: mainmessage.messages![i].userType ==
                                        'driver'
                                        ? true
                                        : false,
                                    color: (mainmessage.messages![i].userType ==
                                        'rider'
                                        ? Colors.grey.shade400
                                        : ACTIVECOLOR),

                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        color: mainmessage.messages![i].userType ==
                                            'rider'
                                            ? Colors.black
                                            : Colors.white
                                      // fontSize: 16,
                                      // color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Center(
                            child: Text(
                              "You Have No Messages",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ));
                      }
                    }),

                SizedBox(height: 80),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                 Icon(Icons.add, color: Colors.white, size: 25,),
                SizedBox(width: 1,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only( left:8, right: 8, bottom: 9),
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.4),
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: TextField(
                          controller: messagecontroller,
                          // autofocus: true,
                          focusNode: _focusNode,
                          maxLines: null,
                          style: TextStyle(fontSize: 20, color: messagecontroller.text != "" ? Colors.white : Colors.grey),
                          decoration: InputDecoration(
                              hintText: "Type message...",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                color: messagecontroller.text != "" ? Colors.red : Colors.grey,
                                onPressed: (){
                                  sendmessage(message: messagecontroller.text);
                                  messagecontroller.text = '';
                                  _focusNode.unfocus();

                                },
                                icon: Icon(Icons.arrow_circle_up_sharp, size: 30,),
                              ),

                          ),

                          onChanged: (value){
                            setState(() {
                              messagecontroller.text = value;
                            });
                          },

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}