class MessageData {
  String? msgtext;
  String? auth;
  String? userid;
  DateTime? date;
  bool? isme;

  MessageData({this.msgtext, this.auth, this.userid, this.date, this.isme});

  MessageData.fromJson(Map<String, dynamic> json) {
    msgtext = json['msgtext'];
    auth = json['auth'];
    userid = json['userid'];
    date = DateTime.parse(json['date']);
    isme = json['isme'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgtext'] = this.msgtext;
    data['auth'] = this.auth;
    data['userid'] = this.userid;
    data['date'] = this.date!.toUtc().toString();
    data['isme'] = this.isme;
    return data;
  }
}
