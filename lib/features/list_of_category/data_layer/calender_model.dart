class CalenderModel {
  bool? success;
  List<AvailableTime>? availableTime;
  int? percent;

  CalenderModel({this.success, this.availableTime, this.percent});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['available_time'] != null) {
      availableTime = <AvailableTime>[];
      json['available_time'].forEach((v) {
        availableTime!.add(AvailableTime.fromJson(v));
      });
    }
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (availableTime != null) {
      data['available_time'] =
          availableTime!.map((v) => v.toJson()).toList();
    }
    data['percent'] = percent;
    return data;
  }
}

class AvailableTime {
  String? id;
  String? itemId;
  String? availableTimeFrom;
  String? availableTimeTo;
  String? day;
  String? status;
  String? price;

  AvailableTime(
      {this.id,
        this.itemId,
        this.availableTimeFrom,
        this.availableTimeTo,
        this.day,
        this.status,
        this.price});

  AvailableTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    day = json['day'];
    status = json['status'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['available_time_from'] = availableTimeFrom;
    data['available_time_to'] = availableTimeTo;
    data['day'] = day;
    data['status'] = status;
    data['price'] = price;
    return data;
  }
}
