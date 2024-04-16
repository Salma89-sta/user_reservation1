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
        availableTime!.add(new AvailableTime.fromJson(v));
      });
    }
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.availableTime != null) {
      data['available_time'] =
          this.availableTime!.map((v) => v.toJson()).toList();
    }
    data['percent'] = this.percent;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['available_time_from'] = this.availableTimeFrom;
    data['available_time_to'] = this.availableTimeTo;
    data['day'] = this.day;
    data['status'] = this.status;
    data['price'] = this.price;
    return data;
  }
}
