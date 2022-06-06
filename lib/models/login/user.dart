 
import 'user_configuration.dart';
import 'user_identity_info.dart';

class User {
  User() {
    userFullName = '';
    domainUserName = '';
    domainName = '';
    mobileNumber = '';
    userEmail = '';
    pushRegistered = false;
    pushRegisterId = '';
    userIdentityInfo = UserIdentityInfo(0, '', false);
    userConfiguration = UserConfiguration();
  }
  User.fromJson(Map<String, dynamic> json) {
    userFullName = json['userFullName'] as String;
    domainUserName = json['domainUserName'] as String;
    domainName = json['domainName'] as String;
    mobileNumber = json['mobileNumber'] as String;
    userImage = (json['hasUserImage'] as bool) ? (json['userImage'] as String) : null;
    userEmail = json['userEmail'] as String;
    pushRegistered = json['pushRegistered'] ;
    pushRegisterId = json['pushRegisterId'] ;
    userIdentityInfo = UserIdentityInfo(
        json['userIdentityInfo']['userBranchId'] as int, json['userIdentityInfo']['userId'] as String, json['userIdentityInfo']['isManager'] as bool);
    if (json['userConfiguration'] != null) {
      userConfiguration = UserConfiguration.fromMap(json['userConfiguration'] as Map<String, dynamic>);
    } else {
      userConfiguration = UserConfiguration();
    }
  }
  late UserConfiguration userConfiguration;
  late String userFullName;
  late String domainUserName;
  late String domainName;
  late String mobileNumber;
  late String userEmail;
  String? userImage;
  late UserIdentityInfo userIdentityInfo;
  String? pushRegisterId;
  late bool pushRegistered;
}
