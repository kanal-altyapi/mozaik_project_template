class UserIdentityInfo {
  UserIdentityInfo(this.userBranchId, this.userId, this.isManager) {
    userIdBackUp = userId;
  }

  int userBranchId;
  String userId;
  late String userIdBackUp;
  bool isManager;
}
