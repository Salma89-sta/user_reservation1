class ItemModel {
  bool? success;
  List<Data>? data;

  ItemModel({this.success, this.data});

  ItemModel.fromJson(Map<String, dynamic> json) {
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
    data['devices'] = this.devices;
    data['status'] = this.status;
    data['offer'] = this.offer;
    return data;
  }
}
