class ApiPaths {
  static String liveBaseURL = "http://192.168.100.17:4000/api/v1/";
  static String baseURL = liveBaseURL;

  // ==> Authentication ==>
  static String google = "${baseURL}auth/google";
  static String signup = "${baseURL}auth/signup";
  static String signin = "${baseURL}auth/signin";

  static String send = "${baseURL}friendrequest/send";
  static String pending = "${baseURL}friendrequest/pending";
  static String accepted = "${baseURL}friendrequest/accepted";
  static String accept = "${baseURL}friendrequest/accept";
  static String reject = "${baseURL}friendrequest/reject";

  static String createExpense = "${baseURL}expense";
}
