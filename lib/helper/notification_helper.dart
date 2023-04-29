import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/data/model/response/order_model.dart';
import 'package:resturant_delivery_boy/main.dart';
import 'package:resturant_delivery_boy/provider/chat_provider.dart';
import 'package:resturant_delivery_boy/utill/app_constants.dart';
import 'package:resturant_delivery_boy/view/screens/order/order_details_screen.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {

        int _orderId;
        _orderId = int.tryParse(notificationResponse.payload);
        try{
          if(_orderId != null) {

            Get.navigator.push(MaterialPageRoute(builder: (context) =>
                OrderDetailsScreen(orderModelItem: OrderModel(id: _orderId),)),
            );
          }
        }catch (e) {}
        return;
      },);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      if(message.data['type'] == 'message') {
        int _id;
        _id = int.tryParse('${message.data['order_id']}');
        Provider.of<ChatProvider>(Get.context, listen: false).getChatMessages(Get.context, _id);
      }

      showNotification(message, flutterLocalNotificationsPlugin, false);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(message.data['type'] == 'message') {
        int _id;
        _id = int.tryParse('${message.data['order_id']}');

        if(_id != null) {
          Provider.of<ChatProvider>(Get.context, listen: false).getChatMessages(Get.context, _id);
        }

      }

      try{
        if(message.notification.titleLocKey != null && message.notification.titleLocKey.isNotEmpty) {
          int _orderId;
          _orderId = int.tryParse(message.notification.titleLocKey);

          if(_orderId != null) {
            Get.navigator.push(MaterialPageRoute(builder: (context) =>
                OrderDetailsScreen(orderModelItem: OrderModel(id: _orderId),)),
            );
          }

        }
      }catch (e) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    String _title;
    String _body;
    String _orderID;
    String _image;
    if(data) {
      _title = message.data['title'];
      _body = message.data['body'];
      _orderID = message.data['order_id'];
      _image = (message.data['image'] != null && message.data['image'].isNotEmpty)
          ? message.data['image'].startsWith('http') ? message.data['image']
          : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}' : null;
    }else {
      _title = message.notification.title;
      _body = message.notification.body;
      _orderID = message.notification.titleLocKey;
      if(Platform.isAndroid) {
        _image = (message.notification.android.imageUrl != null && message.notification.android.imageUrl.isNotEmpty)
            ? message.notification.android.imageUrl.startsWith('http') ? message.notification.android.imageUrl
            : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.android.imageUrl}' : null;
      }else if(Platform.isIOS) {
        _image = (message.notification.apple.imageUrl != null && message.notification.apple.imageUrl.isNotEmpty)
            ? message.notification.apple.imageUrl.startsWith('http') ? message.notification.apple.imageUrl
            : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.apple.imageUrl}' : null;
      }
    }

    if(_image != null && _image.isNotEmpty) {
      try{
        await showBigPictureNotificationHiddenLargeIcon(_title, _body, _orderID, _image, fln);
      }catch(e) {
        await showBigTextNotification(_title, _body, _orderID, fln);
      }
    }else {
      await showBigTextNotification(_title, _body, _orderID, fln);
    }
  }


  static Future<void> showBigTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 'efood', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 'efood',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint("onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
}

class PayloadModel {
  PayloadModel({
    this.title,
    this.body,
    this.orderId,
    this.image,
    this.type,
  });

  String title;
  String body;
  String orderId;
  String image;
  String type;

  factory PayloadModel.fromRawJson(String str) => PayloadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
    title: json["title"],
    body: json["body"],
    orderId: json["order_id"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "order_id": orderId,
    "image": image,
    "type": type,
  };
}