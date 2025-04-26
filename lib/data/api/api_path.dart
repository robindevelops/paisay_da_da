class ApiPaths {
  static String liveBaseURL = "http://10.0.2.2:4000/api/v1/";
  static String baseURL = liveBaseURL;

  // ==> Authentication ==>
  static String signup = "${baseURL}auth/signup";
  static String signin = "${baseURL}auth/signin";
  static String deleteAccount = "${baseURL}auth/deleteAccount";

  // ==> AddFriend ==>
  static String getFriend = "${baseURL}friendRequest/getUserFriends";
  static String addFriend = "${baseURL}friendRequest/addFriend";
  static String accept = "${baseURL}friendRequest/accept";
  static String reject = "${baseURL}friendRequest/reject";

  //==== Groups ====>

  static String createGroup = "${baseURL}group/createGroup";
  static String getGroup = "${baseURL}group/getGroup";
  static String deleteGroup = "${baseURL}group/deleteGroup";
  static String leaveGroup = "${baseURL}group/leaveGroup";
  static String addMember = "${baseURL}group/addMember";
}
