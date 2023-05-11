class UserModel {
  String? name;
  String? id;
  List<Msglist>? msglist;

  UserModel({this.name, this.id, this.msglist});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['msglist'] != null) {
      msglist = <Msglist>[];
      json['msglist'].forEach((v) {
        msglist!.add(new Msglist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.msglist != null) {
      data['msglist'] = this.msglist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Msglist {
  String? msgtext;
  String? auth;
  String? userid;
  String? from;
  String? date;

  Msglist({this.msgtext, this.auth, this.userid, this.date, this.from});

  Msglist.fromJson(Map<String, dynamic> json) {
    msgtext = json['msgtext'];
    auth = json['auth'];
    from = json['from'];
    userid = json['userid'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgtext'] = this.msgtext;
    data['auth'] = this.auth;
    data['from'] = this.from;
    data['userid'] = this.userid;
    data['date'] = this.date;
    return data;
  }
}
