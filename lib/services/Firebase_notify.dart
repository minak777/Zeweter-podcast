import 'package:firebase_messaging/firebase_messaging.dart';

class Firebase_api {
  //instance of firebase messaging
  final _firebasemesaging = FirebaseMessaging.instance;
  //function to intialize notification
  Future<void> initNotifications() async {
    //request permission
    await _firebasemesaging.requestPermission();

    //fetch fcm token
    final fcmtoken = await _firebasemesaging.getToken();
    //print token(normally sent to server)
    print('Token: $fcmtoken');
  }
  //function to handle recived messages
  //functions to initiallize forground and background
}
