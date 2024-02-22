import 'dart:ui';

import 'package:flutter/material.dart';

final String sendbirdappid = "BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF";
final String channelurl = "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211";
final String apiurl = "https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com";
final String apitoken = "f93b05ff359245af400aa805bafd2a091a173064";
Color ACTIVECOLOR = Color(0xff132b3b);

double WIDTH({required BuildContext context}) {
  return MediaQuery.of(context).size.width;
}

TextStyle nnomessage = TextStyle(
  color: Colors.white,
  fontSize: 20
);

TextStyle appbar = TextStyle(
color: Colors.black,
fontWeight: FontWeight.bold,
    fontSize: 20
);
const IconData arrow_circle_up_sharp = IconData(0xe795, fontFamily: 'MaterialIcons');

