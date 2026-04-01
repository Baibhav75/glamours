class ApiConstants {
  static const String baseUrl = "https://glamorousfilmcity.com/api";

  static String login(String selfId, String password) {
    return "$baseUrl/Login/LoginUser?SelfId=$selfId&Password=$password";
  }
  // REGISTER
  static String register() {
    return "$baseUrl/UserRegistration/Register";
  }
  // profile
  static String getProfile(String selfId) {
    return "$baseUrl/GetProfile/GetProfileBySelfId?SelfId=$selfId";
  }
  // change password
  static String changePassword() {
    return "$baseUrl/ChangePassword/ChangePasswordBySelfId";
  }
  // wallet
  static String wallet(String selfId) {
    return "$baseUrl/GetWalletAndTransactionDetails/GetDetails?Self_Id=$selfId";
  }

  //
  static String categories() {
    return "$baseUrl/GetCategories/Categories";
  }


}



