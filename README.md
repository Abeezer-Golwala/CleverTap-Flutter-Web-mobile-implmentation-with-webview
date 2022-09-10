# Implmenting Flutter Web with clevertap

Following are the step to implement web sdk inside flutter and to pass event data from dart to js. <br/>
### 1. Insert the following dependency in pubspec.yaml </br>
       universal_html: ^2.0.8
   
### 2. Import this package inside your dart file where you wish to push data to CleverTap<br/>
       import 'package:universal_html/html.dart' as html;<br/>
       import 'dart:convert';

### 3. Pass your data json payload as follows<br/>
  #### OnUserLogin Code<br/>
    html.window.postMessage(jsonEncoder.convert({"Type": "onuserlogin","Payload": {'Name': 'Abctest','Identity': '9789','Email': 'hello2@react.com','MSG-push': true,'MSG-email': true,'MSG-sms': true,'MSG-whatsapp': true}}), "*");

#### Profile Push Code<br/>

    html.window.postMessage(jsonEncoder.convert({"Type": "profilepush","Payload": {'Gender': 'M','test': 'hell123o','test2': ["hello2", "helloe3"]}}), "*");

#### Push Event<br/>
    html.window.postMessage(jsonEncoder.convert({"Type": "event","EventName": 'Product Viewed',"Payload": {'Product Name': 'Dairy Milk','Category': 'Chocolate','Amount': 20.00}}), "*");

### 4. Inside your web/app.js file copy and paste code from the following file :-<br/>
https://github.com/Abeezer-Golwala/clevertap_flutter_webview_bridge_master/blob/flutterweb/web/app.js<br/>
### Refer to this file for Passing data from dart to js <br/>
https://github.com/Abeezer-Golwala/CleverTap-Web-mobile-implmentation-with-webvoiew/blob/flutterweb/lib/main.dart<br/>
Refer to this link for more details on Clevertaps Web SDK :-<br/>
https://developer.clevertap.com/docs/web-quickstart-guide
