class CalenderModel {
  bool? success;
  List<int>? availableTime;
  int? percent;

  CalenderModel({this.success, this.availableTime, this.percent});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    availableTime = json['available_time'].cast<int>();
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['available_time'] = this.availableTime;
    data['percent'] = this.percent;
    return data;
  }
}
