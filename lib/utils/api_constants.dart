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

  // Products API ✅ correct
  static const String getProducts = "$baseUrl/GetProducts/Products";

  static String getProductsByCategory(String catId) {
    return "$baseUrl/GetProducts/Products/?CatId=$catId";
  }

  // Image URL FIX ✅
  static String getImageUrl(String path) {
    return "https://glamorousfilmcity.com$path";
  }

  // oderlist
  static String orderList(String selfId) {
    return "$baseUrl/GetOrderList/OrderList?Self_Id=$selfId";
  }

  // updated profile

  static const String updateProfile =
      "$baseUrl/UpdateProfile/UpdateProfileBySelfId";

  static const String rewardIncome =
      "$baseUrl/RewardIncome/GetRewardIncome";

  static String poolIncome(String selfId) =>
      "$baseUrl/PoolIncome/GetPoolIncome?Self_Id=$selfId";


  static String levelIncome(String selfId) =>
      "$baseUrl/LevelIncome/GetLevelIncome?Self_Id=$selfId";

  static String withdrawAmount(String selfId) =>
      "$baseUrl/WithdrawalAmount/GetWithdrawAmountList?Self_Id=$selfId";

  static String levelTeamList(String selfId) =>
      "$baseUrl/LevelTeamList/GetLevelTeam?Self_Id=$selfId";


  static String referralLink(String selfId) =>
      "$baseUrl/ReferralLink/GetReferralLink?Self_Id=$selfId";

  static String welcomeLetter(String selfId) =>
      "$baseUrl/GetWelcomeLetter/LetterData?Self_Id=$selfId";


  static String autoPoolList(
      String selfId,
      String type,
      ) =>

      "$baseUrl/AutoPoolMemberList/GetAutopoolList?Self_Id=$selfId&type=$type";

  static String shoppingLevelIncome(
      String selfId,
      ) =>

      "$baseUrl/ShoppingLevelIncome/GetShoppingLevelIncome?Self_Id=$selfId";
}





