class Content {
  int id;
  String firstName;
  String lastName;
  String street;
  String city;
  String state;
  String gender;
  String lat;
  String lng;

  Content(
      {this.id,
      this.firstName,
      this.lastName,
      this.street,
      this.city,
      this.state,
      this.gender,
      this.lat,
      this.lng});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    gender = json['gender'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstName;
    data['lastname'] = this.lastName;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['gender'] = this.gender;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
