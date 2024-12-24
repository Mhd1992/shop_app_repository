class User {
  int? id, points, credit;
  String? name, email, phone, image, token;

  User(
      {this.id,
      this.points,
      this.credit,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
