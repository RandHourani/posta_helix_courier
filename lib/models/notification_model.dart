class NotificationModel {
  NotificationDetails notification;
  Data data;
 NotificationModel({this.data,this.notification});

 factory NotificationModel.fromJson(Map<String,dynamic>json)
 {
   return NotificationModel(
     notification: NotificationDetails.fromJson(json['notification']),
     data: Data.fromJson(json['data'])
   );
 }
}

class NotificationDetails {
  String body;
  String title;

  NotificationDetails({this.title, this.body});

  factory NotificationDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDetails(
        body: json['body'] as String, title: json['title'] as String);
  }
}

class Data {
  String code;

  Data({this.code});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      code: json['code'] as String,
    );
  }
}
