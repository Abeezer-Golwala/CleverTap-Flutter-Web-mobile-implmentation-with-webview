// ignore_for_file:  unnecessary_this
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';

GlobalKey globalKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter SDK Integration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var inboxInitialized = false;
  late CleverTapPlugin _clevertapPlugin;
  var optOut = false;
  var offLine = false;
  var enableDeviceNetworkingInfo = false;

  //for killed state notification clicked
  static const platform = MethodChannel("myChannel");

  @override
  void initState() {
    CleverTapPlugin.setDebugLevel(3);
    initPlatformState();
    activateCleverTapFlutterPluginHandlers();
    CleverTapPlugin.createNotificationChannel(
        "abtest", "abtest", "Flutter Test", 5, true);
    var stuff = ["bags", "shoes"];
    CleverTapPlugin.onUserLogin({
      'Name': 'Test 28',
      'Identity': 'test28',
      'Email': 'test28@test.com',
      'Phone': '+14364532109',
      'MSG-email': true,
      'MSG-push': true,
      'MSG-sms': true,
      'MSG-whatsapp': true,
    });
    //For Killed State Handler
    platform.setMethodCallHandler(nativeMethodCallHandler);

    super.initState();
    CleverTapPlugin.initializeInbox();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  void activateCleverTapFlutterPluginHandlers() {
    _clevertapPlugin = CleverTapPlugin();

    //Handler for receiving Push Clicked Payload in FG and BG state
    _clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
        pushClickedPayloadReceived);
    _clevertapPlugin.setCleverTapInboxDidInitializeHandler(inboxDidInitialize);
    _clevertapPlugin
        .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
  }

  //For Push Notification Clicked Payload in FG and BG state
  void pushClickedPayloadReceived(Map<String, dynamic> map) {
    debugPrint("pushClickedPayloadReceived called");
    this.setState(() async {
      var data = jsonEncode(map);
      debugPrint("on Push Click Payload = $data");
    });
  }

  //For Push Notification Clicked Payload in killed state
  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    debugPrint("killed state called!");
    switch (methodCall.method) {
      case "onPushNotificationClicked":
        debugPrint("onPushNotificationClicked in dart");
        debugPrint("Clicked Payload in Killed state: ${methodCall.arguments}");
        return "This is from android!!";
      default:
        return "Nothing";
    }
  }

  void inboxDidInitialize() {
    this.setState(() {
      debugPrint("inboxDidInitialize called");
      inboxInitialized = true;
    });
  }

  void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    this.setState(() async {
      List? displayUnits = await CleverTapPlugin.getAllDisplayUnits();
      debugPrint("inboxDidInitialize called");
      debugPrint("Display Units are " + displayUnits.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Profile push"),
                  subtitle: const Text("push your profile"),
                  onTap: login,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Push Event"),
                  subtitle: const Text("Pushes/Records an event"),
                  onTap: recordEvent,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Notification Event"),
                  subtitle: const Text("Pushes Notification"),
                  onTap: pushNotification,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("InApp Event"),
                  subtitle: const Text("Pushes InApp Notification"),
                  onTap: inAppNotification,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("App Inbox Event"),
                  subtitle: const Text("Pushes App Inbox Messages"),
                  onTap: appInbox,
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: const Text("Native Display"),
                  subtitle: const Text("Returns all Display Units set"),
                  onTap: nativeDisplay,
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void login() {
    var profile = {
      'Photo':
      "https://i.pinimg.com/originals/39/95/65/399565162c331db08fde4211da835551.jpg",
    };
    CleverTapPlugin.profileSet(profile);
    // showToast("Pushed profile " + profile.toString());
  }

  void recordEvent() {
    var eventData = {
      'Stuff': 'Shirt',
    };
    CleverTapPlugin.recordEvent("ProductF Event", eventData);
    // showToast("ProductF Event Clicked!", context: context);
  }

  void pushNotification() {
    var eventData = {
      '': '',
    };
    CleverTapPlugin.recordEvent("AbeezerPushEvent", eventData);
    // showToast("Karthik's Noti Event Clicked!", context: context);
  }

  void inAppNotification() {
    var eventData = {
      '': '',
    };
    CleverTapPlugin.recordEvent("Karthik's InApp Event", eventData);
    // showToast("Karthik's InApp Event Clicked!", context: context);
  }

  void appInbox() {
    var eventData = {
      '': '',
    };
    CleverTapPlugin.recordEvent("Karthik's App Inbox Event", eventData);
    // showToast("Karthik's App Inbox Event Clicked!", context: context);
    showInbox();
  }

  void showInbox() {
    var styleConfig = {
      'noMessageTextColor': '#ff6600',
      'noMessageText': 'No message(s) to show.',
      'navBarTitle': 'App Inbox'
    };
    CleverTapPlugin.showInbox(styleConfig);
  }

  void nativeDisplay() {
    var eventData = {
      '': '',
    };
    CleverTapPlugin.recordEvent("Karthik's Native Display Event", eventData);
    getAdUnits();
  }

  void getAdUnits() async {
    // var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    // var a = "";
    // for (var i in displayUnits) {
    //   a = i;
    // }
    // var decodedJson = json.decode(a);
    // var jsonValue = json.decode(decodedJson['content']);
    // debugPrint("value = " + jsonValue['message']);
    // for (var i = 0; i < displayUnits.length; i++) {
    //   var units = displayUnits[i];
    //   displayText(units);
    //   // debugPrint("units= " + units.toString());
    // }
    // for (var element in displayUnits) {
    //   debugPrint("units= " + element[1].toString());
    // }
  }

  void displayText(units) {
    for (var i = 0; i < units.length; i++) {
      debugPrint("title= " + units[i].toString());
      // debugPrint("message= " + item.message.toString());

    }
  }
}