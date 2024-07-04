class SignupModel {
  bool? success;

  SignupModel({this.success});

  SignupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}