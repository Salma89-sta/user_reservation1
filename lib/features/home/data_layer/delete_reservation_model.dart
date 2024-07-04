class DeleteReservationModel {
  bool? success;

  DeleteReservationModel({this.success});

  DeleteReservationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}
