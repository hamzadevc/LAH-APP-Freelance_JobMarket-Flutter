import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String name;
  final String email;
  final String mobileNumber;
  final String imgUrl;
  final String country;
  final String city;
  final String address;
  final String dob;
  final String cardNo;
  final String cVV;
  final String expiry;
  final int type;
  final String uId;
  final String cvLink;
  final List<dynamic> appliedJobs;
  final List<dynamic> myCompletedJobs; // contains my jobs which

  UserProfile({
    this.uId,
    this.address,
    this.cardNo,
    this.city,
    this.country,
    this.cVV,
    this.dob,
    this.email,
    this.expiry,
    this.imgUrl,
    this.mobileNumber,
    this.name,
    this.type,
    this.cvLink,
    this.appliedJobs,
    this.myCompletedJobs,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'name': name,
      'email': email,
      'mobile_number': mobileNumber,
      'address': address,
      'country': country,
      'city': city,
      'img': imgUrl,
      'dob': dob,
      'card_no': cardNo,
      'cvv': cVV,
      'expiry': expiry,
      'cvLink': cvLink,
      'type': type,
      'completedJobs': myCompletedJobs,
    };
  }

  Map<String, dynamic> toJsonImg() {
    return {
      'id': uId,
      'img': imgUrl,
    };
  }

  Map<String, dynamic> toJson2Cv() {
    return {
      'cvLink': cvLink,
    };
  }

  Map<String, dynamic> toJson2AppliedJobs() {
    return {
      'appliedJobs': appliedJobs,
    };
  }

  UserProfile fromJson(Map<String, dynamic> data) {
    return UserProfile(
      uId: data['id'],
      address: data['address'],
      cardNo: data['card_no'],
      city: data['city'],
      country: data['country'],
      cVV: data['cvv'],
      dob: data['dob'],
      email: data['email'],
      expiry: data['expiry'],
      imgUrl: data['img'],
      mobileNumber: data['mobile_number'],
      name: data['name'],
      cvLink: data['cvLink'],
      type: data['type'],
      appliedJobs: data['appliedJobs'],
      myCompletedJobs: data['completedJobs'],
    );
  }

  Future saveUserInSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', uId);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('mobile_number', mobileNumber);
    await prefs.setString('address', address);
    await prefs.setString('country', country);
    await prefs.setString('city', city);
    await prefs.setString('img', imgUrl);
    await prefs.setString('dob', dob);
    await prefs.setString('card_no', cardNo);
    await prefs.setString('cvv', cVV);
    await prefs.setString('expiry', expiry);
    await prefs.setString('cvLink', cvLink);
    await prefs.setInt('type', type);
  }

  Future saveCVLinkInSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cvLink', expiry);
  }

  Future<UserProfile> getUserFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserProfile(
      uId: prefs.getString('id'),
      name: prefs.getString('name'),
      email: prefs.getString('email'),
      mobileNumber: prefs.getString('mobile_number'),
      address: prefs.getString('address'),
      country: prefs.getString('country'),
      city: prefs.getString('city'),
      imgUrl: prefs.getString('img'),
      dob: prefs.getString('dob'),
      cardNo: prefs.getString('card_no'),
      cVV: prefs.getString('cvv'),
      expiry: prefs.getString('expiry'),
      cvLink: prefs.getString('cvLink'),
      type: prefs.getInt('type'),
    );
  }
}

///TODO Convert applicants back to list...
class AllApplicants {
  final String id;
  final bool completed;
  final String applicant;
  AllApplicants({
    this.applicant,
    this.id,
    this.completed,
  });

  Map<String, dynamic> toJson() => {
        'allApplicants': applicant,
        'completed': completed,
      };

  AllApplicants fromJson(Map<String, dynamic> data) => AllApplicants(
        id: id,
        applicant: data['allApplicants'],
        completed: data['completed'],
      );
}
