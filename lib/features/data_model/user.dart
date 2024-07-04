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
  "id": id.toString() ,
  "name": name.toString(),
  "phone": phone.toString(),
  "nid": nid.toString(),
  "email": email.toString(),
  "password": password.toString()
};
}