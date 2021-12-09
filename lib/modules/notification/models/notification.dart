import 'package:lumas/general/helper.dart';

class Notify {
  int? appointmentId;
  String? title;
  String? member;
  int? memberId;
  int? userId;
  String? time;
  String? type;
  int? status;
  String? timeShow;
  String? userTimeShow;
  String? userReadAt;
  String? clientReadAt;
  String? clientTimeShow;

  Notify(
      {this.appointmentId,
        this.title,
        this.member,
        this.memberId,
        this.userId,
        this.time,
        this.type,
        this.status,
        this.timeShow,
        this.userTimeShow,
        this.userReadAt,
        this.clientReadAt,
        this.clientTimeShow});

  Notify.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    title = json['title'];
    member = json['member'];
    memberId = json['member_id'];
    userId = json['user_id'];
    time = Helper.formatDate(json['time']);
    type = json['type'];
    status = json['status'];
    timeShow = json['time_show'];
    userTimeShow = json['user_time_show'];
    userReadAt = json['user_read_at'];
    clientReadAt = json['client_read_at'];
    clientTimeShow = json['client_time_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['title'] = this.title;
    data['member'] = this.member;
    data['member_id'] = this.memberId;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    data['type'] = this.type;
    data['status'] = this.status;
    data['time_show'] = this.timeShow;
    data['user_time_show'] = this.userTimeShow;
    data['user_read_at'] = this.userReadAt;
    data['client_read_at'] = this.clientReadAt;
    data['client_time_show'] = this.clientTimeShow;
    return data;
  }
}