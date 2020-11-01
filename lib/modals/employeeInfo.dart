import 'package:shared_preferences/shared_preferences.dart';

class EmployeesInfo {
  final String uId;
  final String name;
  final String email;
  final String phoneNumber;
  final String imgUrl;
  final String country;
  final String city;
  final String address;
  final String dob;

  EmployeesInfo(
      {this.name,
      this.imgUrl,
      this.email,
      this.dob,
      this.country,
      this.city,
      this.address,
      this.phoneNumber,
      this.uId});

  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'name': name,
      'email': email,
      'address': address,
      'country': country,
      'city': city,
      'img': imgUrl,
      'dob': dob,
    };
  }

  EmployeesInfo fromJson(Map<String, dynamic> data) {
    return EmployeesInfo(
      uId: data['id'],
      address: data['address'],
      city: data['city'],
      country: data['country'],
      dob: data['dob'],
      email: data['email'],
      imgUrl: data['img'],
      name: data['name'],
    );
  }

  Future saveEmployeeInSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', uId);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('address', address);
    await prefs.setString('country', country);
    await prefs.setString('city', city);
    await prefs.setString('img', imgUrl);
    await prefs.setString('dob', dob);
  }

  Future<EmployeesInfo> getEmployeeFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return EmployeesInfo(
      uId: prefs.getString('id'),
      name: prefs.getString('name'),
      email: prefs.getString('email'),
      address: prefs.getString('address'),
      country: prefs.getString('country'),
      city: prefs.getString('city'),
      imgUrl: prefs.getString('img'),
      dob: prefs.getString('dob'),
    );
  }
}

class User {
  final String uId;
  User({this.uId});
}

enum SessionType { COMPANY, EMPLOYEE }
