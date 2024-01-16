class UserReservationsModel {
  bool? success;
  List<Data>? data;

  UserReservationsModel({this.success, this.data});

  UserReservationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? categoryName;
  String? itemId;
  String? time;
  String? timeOfReservationFrom;
  String? timeOfReservationTo;
  String? additionalOptions;
  String? status;
  String? document;
  String? approveOfPayment;
  String? price;
  String? paid;
  String? maritalStatus;
  Item? item;
  User? user;

  Data(
      {this.id,
        this.userId,
        this.categoryName,
        this.itemId,
        this.time,
        this.timeOfReservationFrom,
        this.timeOfReservationTo,
        this.additionalOptions,
        this.status,
        this.document,
        this.approveOfPayment,
        this.price,
        this.paid,
        this.maritalStatus,
        this.item,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    itemId = json['item_id'];
    time = json['time'];
    timeOfReservationFrom = json['time_of_reservation_from'];
    timeOfReservationTo = json['time_of_reservation_to'];
    additionalOptions = json['additional_options'];
    status = json['status'];
    document = json['document'];
    approveOfPayment = json['approve_of_payment'];
    price = json['price'];
    paid = json['paid'];
    maritalStatus = json['marital_status'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_name'] = this.categoryName;
    data['item_id'] = this.itemId;
    data['time'] = this.time;
    data['time_of_reservation_from'] = this.timeOfReservationFrom;
    data['time_of_reservation_to'] = this.timeOfReservationTo;
    data['additional_options'] = this.additionalOptions;
    data['status'] = this.status;
    data['document'] = this.document;
    data['approve_of_payment'] = this.approveOfPayment;
    data['price'] = this.price;
    data['paid'] = this.paid;
    data['marital_status'] = this.maritalStatus;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  String? categoryName;
  String? name;
  String? logo;
  String? image1;
  String? image2;
  String? image3;
  String? type;
  String? description;
  String? address;
  String? availableTimeFrom;
  String? availableTimeTo;
  String? devices;
  String? status;
  String? offer;
  String? price;

  Item(
      {this.id,
        this.categoryName,
        this.name,
        this.logo,
        this.image1,
        this.image2,
        this.image3,
        this.type,
        this.description,
        this.address,
        this.availableTimeFrom,
        this.availableTimeTo,
        this.devices,
        this.status,
        this.offer,
        this.price});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    name = json['name'];
    logo = json['logo'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    type = json['type'];
    description = json['description'];
    address = json['address'];
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    devices = json['devices'];
    status = json['status'];
    offer = json['offer'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['type'] = this.type;
    data['description'] = this.description;
    data['address'] = this.address;
    data['available_time_from'] = this.availableTimeFrom;
    data['available_time_to'] = this.availableTimeTo;
    data['devices'] = this.devices;
    data['status'] = this.status;
    data['offer'] = this.offer;
    data['price'] = this.price;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? phone;
  String? nid;
  String? type;
  String? email;
  String? password;
  String? status;

  User(
      {this.id,
        this.name,
        this.phone,
        this.nid,
        this.type,
        this.email,
        this.password,
        this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    nid = json['nid'];
    type = json['type'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['nid'] = this.nid;
    data['type'] = this.type;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}
