class ApiConstants {
  static const String baseUrl = 'https://thimar.amr.aait-d.com/public/api';
  static const String loginEp = 'login';
  static const String registerEp = 'driver_register';
  static const String pendingOrdersEp = 'driver/pending_orders';
  static String orderDetailsEp(int id) => 'driver/orders/$id';
  static const String currentOrderEp = 'driver/current_orders';
  static const String finishedOrderEp = 'driver/finished_orders';
  static const String getProfileEP = 'driver/profile';
  static const String aboutAppEP = 'about';
  static const String termsEP = 'policy';
  static const String faqsEP = 'faqs';
  static const String contactEP = 'contact';
  static const String logoutEP = 'logout';
  static const String verifiEP = 'verify';
  static const String forgetPasswordEP = 'forget_password';
  static const String resetPasswordEP = 'reset_password';
  static const String checkCodeEP = 'check_code';
  static const String notificationsEP = 'notifications';
}