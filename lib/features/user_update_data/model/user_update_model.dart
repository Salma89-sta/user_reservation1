class UpdateUserModel {
  bool? success;



  UpdateUserModel({this.success});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }


}