import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_fix/Constants/firestore_constants.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_field_constants.dart';
import 'package:auto_fix/Models/chat_messages.dart';

import 'package:auto_fix/Provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_fix/Constants/cust_colors.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Constants/cust_colors.dart';
import '../../../../../../Constants/styles.dart';
import 'dart:ui' as ui;

class ChatScreen extends StatefulWidget {
  final String peerId;

  /*final String peerAvatar;
  final String peerNickname;
  final String userAvatar;*/

  ChatScreen({
    Key? key,
    // required this.peerNickname,
    // required this.peerAvatar,
    required this.peerId,
    //required this.userAvatar
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentUserId = "123";

  List<QueryDocumentSnapshot> listMessages = [];

  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId = 'messages';

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late ChatProvider chatProvider = ChatProvider(
      firebaseStorage: firebaseStorage, firebaseFirestore: firebaseFirestore);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData FindYourCustomerScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
  }

  bool isMessageSent(int index) {
    if ((index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // checking if received message
  bool isMessageReceived(int index) {
    if ((index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chatting with Athira'.trim()),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              buildListMessage(),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: CustColors.light_navy,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: getImage,
              icon: const Icon(
                Icons.camera_alt,
                size: 28,
              ),
              color: Colors.white,
            ),
          ),
          Flexible(
              child: TextField(
            focusNode: focusNode,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: textEditingController,
            decoration:
                kTextInputDecoration.copyWith(hintText: 'write here...'),
            onSubmitted: (value) {
              onSendMessage(textEditingController.text, MessageType.text);
            },
          )),
          Container(
            margin: EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: CustColors.light_navy,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {
                onSendMessage(textEditingController.text, MessageType.text);
              },
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      ChatMessages chatMessages = ChatMessages.fromDocument(documentSnapshot);
      if (chatMessages.idFrom == currentUserId) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        chatContent: chatMessages.content,
                        color: CustColors.light_navy02,
                        textColor: Colors.white,
                        margin: const EdgeInsets.only(right: 10,top:2),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
                isMessageSent(index)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHYAAAB2CAMAAAAqeZcjAAAAMFBMVEXk5ueutLeqsLPo6era3d6xt7q4vcDq7O27wMLW2dvJzc/e4eLFycu1ur3T1tjN0dNC/DypAAACiUlEQVRoge2ZDXKsIBCEgQFFUbn/bQOb7Ctrn8qM6dmkUvQFvpo/YBpjurq6urq6urq6uv6eiMiklAyN9D6mmZYh2KoQszdvIZNfrHP2KedCTupg8sOO+UW2i27EZJZX5ic4bIpcSuGQWsGLGpemM2jlrkrcS2qVCpd8g2qDCrdFtXbAc6kJLfWd0Vw6npxXbgJjE4da0oylUmRRrcMeG80ufgo6vdxgS7gTEJu4VGsjLlzK3BwX4ZqZBj7VbTCs4VOtxV1FXoKF9bKotNaCqOVglFBhPcWf2odQkyvDwlpZMj9I7A9FK8PCaivrZI/CzqK5hR3K248cF5J7D3rzBT4V+HqU9BTyedFaQ3YKOKogy9AXumCEoA90bi+D11xuuPBthEdF717t7bYKv+FyVj6n4BTR2qSq2DXUGF78Us3hunlUodZnxnl9XdYzxE7vBLd6TfuvWo5H2IWU3U6a1hev09mob7EaGnfOrivpze8xlKt3nrZ5iTEueTJv88+Jxp20q1qBhfIIdA0lzzXT6xDn7M2oFjON5Odo//POa4WdG2aNdNOYcjwi7tnr7KEZp5Rfp+aEHOYEIhNNJbVt5nOihg0AJtpW0SpS/yvm705yPZNk0M+Qv3WEUDo+gTkRT/e5LOv6DBzvBXzx6cME5xv3/ijbpY8DFsd79ZDgc630RrzTwEdgGRfCfHAlHQ2jFi7/kSXwDHBcSDftFFhboNCFYojz9df8LpWLtaVAC/vFbZaX94UoVTPNIsONrdYKKvTn2Wqs+TrBtsLFD89Tl9VtGwW3dXVmiL63RLrauoXfWyLF86fGqNTHD11Eq3BC/dNFcRWpF39wySkqn0dLijqndnV1df06fQBDZxuwbCYKtwAAAABJRU5ErkJggg==",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: CustColors.light_navy,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: CustColors.almost_black,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
              ],
            ),
            isMessageSent(index)
                ? Container(
                    margin: const EdgeInsets.only(right: 50, top: 6, bottom: 8),
                    child: Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chatMessages.timestamp),
                        ),
                      ),
                      style: const TextStyle(
                          color: CustColors.light_navy02,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMessageReceived(index)
                    // left side (received message)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHYAAAB2CAMAAAAqeZcjAAAAMFBMVEXk5ueutLeqsLPo6era3d6xt7q4vcDq7O27wMLW2dvJzc/e4eLFycu1ur3T1tjN0dNC/DypAAACiUlEQVRoge2ZDXKsIBCEgQFFUbn/bQOb7Ctrn8qM6dmkUvQFvpo/YBpjurq6urq6urq6uv6eiMiklAyN9D6mmZYh2KoQszdvIZNfrHP2KedCTupg8sOO+UW2i27EZJZX5ic4bIpcSuGQWsGLGpemM2jlrkrcS2qVCpd8g2qDCrdFtXbAc6kJLfWd0Vw6npxXbgJjE4da0oylUmRRrcMeG80ufgo6vdxgS7gTEJu4VGsjLlzK3BwX4ZqZBj7VbTCs4VOtxV1FXoKF9bKotNaCqOVglFBhPcWf2odQkyvDwlpZMj9I7A9FK8PCaivrZI/CzqK5hR3K248cF5J7D3rzBT4V+HqU9BTyedFaQ3YKOKogy9AXumCEoA90bi+D11xuuPBthEdF717t7bYKv+FyVj6n4BTR2qSq2DXUGF78Us3hunlUodZnxnl9XdYzxE7vBLd6TfuvWo5H2IWU3U6a1hev09mob7EaGnfOrivpze8xlKt3nrZ5iTEueTJv88+Jxp20q1qBhfIIdA0lzzXT6xDn7M2oFjON5Odo//POa4WdG2aNdNOYcjwi7tnr7KEZp5Rfp+aEHOYEIhNNJbVt5nOihg0AJtpW0SpS/yvm705yPZNk0M+Qv3WEUDo+gTkRT/e5LOv6DBzvBXzx6cME5xv3/ijbpY8DFsd79ZDgc630RrzTwEdgGRfCfHAlHQ2jFi7/kSXwDHBcSDftFFhboNCFYojz9df8LpWLtaVAC/vFbZaX94UoVTPNIsONrdYKKvTn2Wqs+TrBtsLFD89Tl9VtGwW3dXVmiL63RLrauoXfWyLF86fGqNTHD11Eq3BC/dNFcRWpF39wySkqn0dLijqndnV1df06fQBDZxuwbCYKtwAAAABJRU5ErkJggg==",
                          //widget.peerAvatar,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: CustColors.green,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: CustColors.greyish,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        color: CustColors.light_navy02,
                        textColor: Colors.white,
                        chatContent: chatMessages.content,
                        margin: const EdgeInsets.only(left: 10,top:2),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
            isMessageReceived(index)
                ? Container(
                    margin: const EdgeInsets.only(left: 50, top: 6, bottom: 8),
                    child: Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chatMessages.timestamp),
                        ),
                      ),
                      style: const TextStyle(
                          color: CustColors.light_navy02,
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              //stream: chatProvider.getChatMessage(groupChatId, _limit),
              stream: chatProvider.getChatMessage("1727", _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessages = snapshot.data!.docs;
                  if (listMessages.isNotEmpty) {
                    return Container(
                      // height: 70,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: snapshot.data?.docs.length,
                          reverse: true,
                          controller: scrollController,
                          itemBuilder: (context, index) =>
                              buildItem(index, snapshot.data?.docs[index])),
                    );
                  } else {
                    return const Center(
                      child: Text('No messages...'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: CustColors.light_navy,
                    ),
                  );
                }
              })
          : const Center(
              child: CircularProgressIndicator(
                color: CustColors.light_navy,
              ),
            ),
    );
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      print(">>>>01");
      chatProvider.sendChatMessage(
          content, type, groupChatId, currentUserId, widget.peerId);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return SizedBox(
              height: 115.0,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt,
                      color: CustColors.blue,
                    ),
                    title: const Text("Camera",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      pickedFile = await imagePicker.pickImage(
                          source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          imageFile = File(pickedFile!.path);
                          if (imageFile != null) {
                            setState(() {
                              isLoading = true;
                            });
                            uploadImageFile();
                          }
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: const Text("Gallery",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      pickedFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          imageFile = File(pickedFile!.path);
                          if (imageFile != null) {
                            setState(() {
                              isLoading = true;
                            });
                            uploadImageFile();
                          }
                        }
                      });
                    },
                  ),
                ],
              ));
        });
  }

  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatProvider.uploadImageFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, MessageType.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  Widget messageBubble(
      {required String chatContent,
      required EdgeInsetsGeometry? margin,
      Color? color,
      Color? textColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: margin,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }

  Widget chatImage({required String imageSrc, required Function onTap}) {
    return OutlinedButton(
      onPressed: onTap(),
      child: Image.network(
        imageSrc,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              color: CustColors.greyish,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 200,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: CustColors.pale_grey,
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, object, stackTrace) => errorContainer(),
      ),
    );
  }

  Widget errorContainer() {
    return Container(
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        'assets/images/img_not_available.jpeg',
        height: 200,
        width: 200,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
