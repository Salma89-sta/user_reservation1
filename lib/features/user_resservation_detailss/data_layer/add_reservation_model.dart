class AddReservationModel {
  bool? success;
  String? message;

  AddReservationModel({this.success, this.message});

  AddReservationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['Message']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['Message'] = this.message;

    return data;
  }
}
