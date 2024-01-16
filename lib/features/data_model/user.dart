class User{
int id;
String name;
String phone;
String nid;
String email;
String password;

factory User.fromJson(Map<String, dynamic> json) => User(
int.parse(json["id"]),
json["name"],
json["phone"],
json["nid"],
json["email"],
json["password"],
);

User(this.id,this.name,this.phone,this.nid,this.email,this.password);

Map<String, dynamic> toJson() => {
  "id": this.id.toString() ,
  "name": this.name.toString(),
  "phone": this.phone.toString(),
  "nid": this.nid.toString(),
  "email": this.email.toString(),
  "password": this.password.toString()
};
}