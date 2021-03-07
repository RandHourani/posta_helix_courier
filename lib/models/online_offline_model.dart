class OnlineOfflineModel {

  CaptainStatus captain;

  OnlineOfflineModel({this.captain});

  factory OnlineOfflineModel.fromJson(Map<String,dynamic>json)
  {
    return OnlineOfflineModel(
    captain: CaptainStatus.fromJsont(json['data'])
    );
  }

}

class CaptainStatus {
  bool state;
  bool goingOffline;
  CheckLog checkLog;
  CaptainStatus({this.checkLog,this.goingOffline,this.state});
  factory CaptainStatus.fromJsont(Map<String, dynamic> json) {
    return CaptainStatus(
      state: json['state']as bool,
      goingOffline: json['state']as bool,
      checkLog: CheckLog.fromJsont(json['check_log'])
    );
  }

  }

class CheckLog {
  int id;
  int destinationAreaId;
  int destinationBookingId;
  int parentId;
  int captainId;

  CheckLog(
      {this.id,
      this.destinationAreaId,
      this.destinationBookingId,
      this.captainId,
      this.parentId});

  factory CheckLog.fromJsont(Map<String, dynamic> json) {
    return CheckLog(
        id: json['id'] as int,
        destinationAreaId: json["destination_area_id"] != null
            ? json["destination_area_id"] as int
            : null,
        destinationBookingId: json["destination_booking_id"] != null
            ? json["destination_booking_id"] as int
            : null,
        parentId: json['parent_id'] as int,
        captainId: json['captain_id'] as int);
  }
}
