import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  // final String country;
  // final String city;
  // final String cVV;
  // final String expiry;
  final String name;
  final String email;
  final String mobileNumber;
  final String imgUrl;
  final String address;
  final String dob;
  final String accountNo;
  final int sessionType;
  final String uId;
  final String cvLink;
  final String avgRating;
  final String companyAvgRating;
  final String bank;
  final String nip;
  final String krs;
  final String phone2;
  final String resPerson;
  final List<dynamic> allRatings;
  final List<dynamic> allCompanyRatings;
  final List<dynamic> appliedJobs;
  final List<dynamic> allApplicants;
  final List<dynamic> allChats;
  final List<dynamic> myCompletedJobs; // contains my jobs which

  UserProfile({
    this.nip,
    this.krs,
    this.phone2,
    this.resPerson,
    this.uId,
    this.address,
    this.accountNo,
    // this.city,
    // this.country,
    // this.cVV,
    this.dob,
    this.email,
    // this.expiry,
    this.bank,
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
    this.allChats,

    ///TODO Start from here....
  });

  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'name': name,
      'email': email,
      'mobile_number': mobileNumber,
      'address': address,
      // 'country': country,
      // 'city': city,
      'img': imgUrl,
      'dob': dob,
      'account_no': accountNo,
      'bank_name': bank,
      // 'cvv': cVV,
      // 'expiry': expiry,
      'cvLink': cvLink,
      'type': sessionType,
      'completedJobs': myCompletedJobs,
      'secound_phone': phone2,
      'nip': nip,
      'krs': krs,
      'responsible_person': resPerson,
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
      accountNo: data['account_no'],
      bank: data['bank'],
      // city: data['city'],
      // country: data['country'],
      // cVV: data['cvv'],
      dob: data['dob'],
      email: data['email'],
      // expiry: data['expiry'],
      imgUrl: data['img'],
      mobileNumber: data['mobile_number'],
      name: data['name'],
      cvLink: data['cvLink'],
      sessionType: data['type'],
      phone2: data['second_phone'],
      nip: data['nip'],
      krs: data['krs'],
      resPerson: data['responsible_person'],
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
    await prefs.setString('phone', phone2);
    await prefs.setString('nip', nip);
    await prefs.setString('img', imgUrl);
    await prefs.setString('dob', dob);
    await prefs.setString('account_no', accountNo);
    await prefs.setString('bank', bank);
    await prefs.setString('krs', krs);
    await prefs.setString('responsible_person', resPerson);
    await prefs.setString('cvLink', cvLink);
    await prefs.setInt('type', sessionType);
  }

  Future saveCVLinkInSharedPrefs() async {
    // ignore: unused_local_variable
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('cvLink', expiry);
  }

  Future<UserProfile> getUserFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserProfile(
      uId: prefs.getString('id'),
      name: prefs.getString('name'),
      email: prefs.getString('email'),
      mobileNumber: prefs.getString('mobile_number'),
      address: prefs.getString('address'),
      phone2: prefs.getString('phone'),
      nip: prefs.getString('nip'),
      imgUrl: prefs.getString('img'),
      dob: prefs.getString('dob'),
      accountNo: prefs.getString('account_no'),
      krs: prefs.getString('krs'),
      resPerson: prefs.getString('responsible_person'),
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
