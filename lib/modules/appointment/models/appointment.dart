import 'package:intl/intl.dart';
import 'package:lumas/general/helper.dart';
import 'package:lumas/general/models.dart';
import 'package:get/get.dart';

class Appointment {
  int? id;
  String? name;
  String? location;
  String? time;
  String? startTime;
  String? endTime;
  int? storeId;
  String? serviceIds;
  String? courseIds;
  int? memberId;
  int? userId;
  int? status;
  String? type;
  String? description;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Store? store;
  Client? client;
  User? user;
  List? services;
  List? courses;
  String? instrumentName;
  String? roomName;
  String? comment;
  String? commentCreatedAt;
  String? remarks;
  String? remarksCreatedAt;

  Map<int, String> statuses = {
    0: 'waiting'.tr,
    1: 'progressing'.tr,
    2: 'completed'.tr,
    -1: 'abort'.tr,
  };

  Appointment({
    this.id,
    this.name,
    this.location,
    this.time,
    this.startTime,
    this.endTime,
    this.storeId,
    this.serviceIds,
    this.courseIds,
    this.memberId,
    this.userId,
    this.status,
    this.type,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.client,
    this.user,
    this.services,
    this.courses,
    this.instrumentName,
    this.roomName,
    this.comment,
    this.commentCreatedAt,
    this.remarks,
    this.remarksCreatedAt,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    time = Helper.formatDate(json['time']);
    startTime = json['start_time'];
    endTime = json['end_time'];
    storeId = json['store_id'];
    serviceIds = json['service_ids'];
    courseIds = json['course_ids'];
    memberId = json['member_id'];
    userId = json['user_id'];
    status = json['status'];
    type = json['type'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    client = json['member'] != null ? new Client.fromJson(json['member']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    var serviceList = json['services'] != null ? json['services'] : [];
    print(serviceList);
    services = serviceList != []
        ? serviceList.map((e) {
            return Service.fromJson(e);
          }).toList()
        : [];
    var courseList = json['courses'] != null ? json['courses'] : [];
    courses = courseList.map((e) {
      return Course.fromJson(e);
    }).toList();
    instrumentName = json['instrument_name '];
    roomName = json['room_name'];
    comment = json['comment'];
    commentCreatedAt = json['comment_created_at'];
    remarks = json['remarks'];
    remarksCreatedAt = json['remarks_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['time'] = this.time;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['store_id'] = this.storeId;
    data['service_ids'] = this.serviceIds;
    data['course_ids'] = this.courseIds;
    data['member_id'] = this.memberId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['description'] = this.description;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['instrument_name '] = this.instrumentName;
    data['room_name'] = this.roomName;
    data['comment'] = this.comment;
    data['comment_created_at'] = this.commentCreatedAt;
    data['remarks'] = this.remarks;
    data['remarks_created_at'] = this.remarksCreatedAt;
    return data;
  }

  String? getStatus(status) {
    return statuses[status] ?? null;
  }
}
