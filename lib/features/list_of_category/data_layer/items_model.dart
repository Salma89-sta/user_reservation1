class ItemModel {
  bool? success;
  List<Data>? data;

  ItemModel({this.success, this.data});

  ItemModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  String? devices;
  String? status;
  String? offer;

  Data(
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
        this.devices,
        this.status,
        this.offer});

  Data.fromJson(Map<String, dynamic> json) {
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
    devices = json['devices'];
    status = json['status'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['name'] = name;
    data['logo'] = logo;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['type'] = type;
    data['description'] = description;
    data['address'] = address;
    data['devices'] = devices;
    data['status'] = status;
    data['offer'] = offer;
    return data;
  }
}
