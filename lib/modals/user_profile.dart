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
  final int sessionType;
  final String uId;
  final String cvLink;
  final String avgRating;
  final String companyAvgRating;
  final List<dynamic> allRatings;
  final List<dynamic> allCompanyRatings;
  final List<dynamic> appliedJobs;
  final List<dynamic> allApplicants;
  final List<dynamic> allChats;
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
    this.sessionType,
    this.cvLink,
    this.appliedJobs,
    this.myCompletedJobs,
    this.allRatings,
    this.avgRating,
    this.allCompanyRatings,
    this.companyAvgRating,
    this.allApplicants,
    this.allChats,///TODO Start from here....
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
      'type': sessionType,
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

  Map<String, dynamic> toJsonRating() {
    return {
      'avg_rating': avgRating,
      'all_rating': allRatings,
    };
  }

  Map<String, dynamic> toJsonCompanyRating() {
    return {
      'avg_company_rating': companyAvgRating,
      'all_company_rating': allCompanyRatings,
    };
  }

  Map<String, dynamic> toJsonAllApplicants() => {
    'all_applicants': allApplicants,
  };

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
      sessionType: data['type'],
      appliedJobs: data['appliedJobs'] ?? [],
      myCompletedJobs: data['completedJobs'] ?? [],
      allRatings: data['all_rating'] ?? [],
      avgRating: data['avg_rating'],
      allCompanyRatings: data['all_company_rating'] ?? [],
      companyAvgRating: data['avg_company_rating'],
      allApplicants: data['all_applicants'] ?? [],
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
    await prefs.setInt('type', sessionType);
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
      sessionType: prefs.getInt('type'),
    );
  }
}

class AllApplicants {
  final String id;
  final bool completed;
  final List<dynamic> applicant;
  AllApplicants({
    this.applicant,
    this.id,
    this.completed,
  });

  Map<String, dynamic> toJson() => {
        'allApplicants': applicant,
        'completed': completed,
      };
  Map<String, dynamic> toJsonStatus() => {
    'completed': completed,
  };

  AllApplicants fromJson(Map<String, dynamic> data) => AllApplicants(
        id: id,
        applicant: data['allApplicants'],
        completed: data['completed'],
      );
}
