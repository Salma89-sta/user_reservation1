class UpdateReservationModel {
  bool? success;

  UpdateReservationModel({this.success});

  UpdateReservationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}
