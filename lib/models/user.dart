class User {
  int id = 0;
  String firstName;
  String city;
  String username;
  String phoneNumber;
  String email;
  String password;

  User(
      {this.firstName,
      this.city,
      this.username,
      this.phoneNumber,
      this.email,
      this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'city': city,
      'username': username,
      'phoneNumber': phoneNumber,
      // 'email': email,
      'password': password
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    city = map['city'];
    username = map['userName'];
    phoneNumber = map['phoneNumber'];
    // email = map['email'];
    password = map['password'];
  }
}
