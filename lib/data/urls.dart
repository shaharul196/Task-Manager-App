class Urlss {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registationUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String createNewTaskUrl = '$_baseUrl/createTask';
  static const String getNewTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTaskUrl =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String getTaskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static String updateTaskStatusUrl(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static const String getCompletedTaskUrl =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTaskUrl =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static  String getRecoverVerifyEmailUrl (String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String getVerifyOTPUrl (String email,String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static String getResetPasswordUrl = '$_baseUrl/RecoverResetPassword';


}
