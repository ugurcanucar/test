class Endpoint {
  static String baseUrl = 'https://testapi.terapizone.com';
  /* auth */
  static String login = baseUrl + '/api/Auth/login';
  static String register = baseUrl + '/api/Auth/register';
  static String changePassword = baseUrl + '/api/Auth/ChangePassword';
  static String sendPasswordCode({required String email}) => baseUrl + '/api/Auth/SendPasswordCode/$email';
  static String resetPassword = baseUrl + '/api/Auth/ResetPassword';

  /* Diseases */
  static String diseasesGetAll = baseUrl + '/api/Diseases/getall';
  static String diseasesGetallmaindisease = baseUrl + '/api/Diseases/getallmaindisease';

  /* genders */
  static String gendersGetAll = baseUrl + '/api/Genders/getall';

  /* User Preferences */
  static String getlisttherapistclientmatch = baseUrl + '/api/UserPreferences/getlisttherapistclientmatch';
  static String adduserfirstpreference = baseUrl + '/api/UserPreferences/adduserfirstpreference';
  static String addclienttherapistpreference = baseUrl + '/api/UserPreferences/addclienttherapistpreference';
  static String myProfile = baseUrl + '/api/UserPreferences/Client/Profile';
  static String myTherapist = baseUrl + '/api/UserPreferences/MyTherapist';
  static String deviceRegistration = baseUrl + '/api/UserPreferences/DeviceRegistration';

  /* Therapists */
  static String getTherapistById({required String id}) => baseUrl + '/api/Therapists/getbyid/$id';
  static String getIsNewNlientAccepting = baseUrl + '/api/Therapists/getisnewclientaccepting';
  static String updateNewClientAccepting = baseUrl + '/api/Therapists/updatenewclientaccepting';
  static String getDiseases = baseUrl + '/api/Therapists/getdiseases';

  /* Tests */
  static String testsGetall = baseUrl + '/api/Tests';
  static String testsGetlisttestquestion({required int id}) => baseUrl + '/api/Tests/getlisttestquestion/$id';
  static String addtestanswer = baseUrl + '/api/Tests/addtestanswer';
  static String getlisttestscore({required String id}) => baseUrl + '/api/Tests/getlisttestscore/$id';
  static String getClientAppointmentSettings({required String id}) =>
      baseUrl + '/api/Appointment/ClientAppointmentSetting?clientUserId=$id';

  /* GetVimeoIDbyUrl  */
  static String getVimeoIDbyUrl({required String url}) => 'https://vimeo.com/api/oembed.json?url=$url';

  static String getClientTestScore({required String clientId}) => '/Tests/GetClientTestScoreResult/$clientId';

  /* Workschedule */
  static String workscheduleDayplanTimes = baseUrl + '/api/Workschedule/WorkscheduleDayplanTimes';
  static String workschedule = baseUrl + '/api/Workschedule';
  static String deleteWorkschedule({required String id}) => baseUrl + '/api/Workschedule/$id';
  static String workscheduleSettingSave = baseUrl + '/api/Workschedule/Setting/Save';
  static String workscheduleSetting = baseUrl + '/api/Workschedule/Setting';
  /* RoutineBreak */
  static String routineBreak = baseUrl + '/api/RoutineBreak';
  static String allRoutineBreak = baseUrl + '/api/RoutineBreak/all';
  static String routineBreakDetail({required String id}) => baseUrl + '/api/RoutineBreak/$id';
  /* AppointmentCalendar */
  static String dayAvailabilityListForClient({required String date}) =>
      baseUrl + '/api/AppointmentCalendar/DayAvailabilityListForClient?date=$date';
  static String dayAvailabilityListForTherapist({required String date}) =>
      baseUrl + '/api/AppointmentCalendar/DayAvailabilityListForTherapist?date=$date';
  static String changeTimeStatus = baseUrl + '/api/AppointmentCalendar/ChangeTimeStatus';

  /* Appointment */
  static String appointment = baseUrl + '/api/Appointment';
  static String appointmentCancel({required String id}) => baseUrl + '/api/Appointment/cancel/$id';
  static String activeAppointments = baseUrl + '/api/Appointment/ActiveAppointments';
  static String pastAppointments = baseUrl + '/api/Appointment/PastAppointments';
  static String appointmentJoin({required String id}) => baseUrl + '/api/Appointment/Join/$id';

  /* Packages */
  static String packages = baseUrl + '/api/Packages/getall';

  /* CardStorage */
  static String allCardStorage = baseUrl + '/api/CardStorage/all';
  static String postCardStorage = baseUrl + '/api/CardStorage';
  static String deleteCardStorage({required String id}) => baseUrl + '/api/CardStorage/$id';

  /* Payment​ */
  static String payWithCard({required String cardId}) => baseUrl + '/api/Payment/PayWithCard/$cardId';
  static String payWithoutCard({required String packageId}) => baseUrl + '/api/Payment/Pay/$packageId';
  static String payWith3D({required String packageId}) => baseUrl + '/api/Payment/PayWith3D_Initialize/$packageId';
  static String payWith3DRegisteredCard({required String cardId}) =>
      baseUrl + '/api/Payment/PayWith3D_RegisteredCard_Initialize/$cardId';

  /*  Message */
  static String sendMessage = baseUrl + '/api/Message/Send';
  static String chatList = baseUrl + '/api/Message/ChatList';
  static String chatDetails({required String messageGroupId}) => baseUrl + '/api/Message/ChatDetails/$messageGroupId';
  static String notifications = baseUrl + '/api/Message/Notifications';

  /* PurchasedPackages */
  static String purchasedPackages = baseUrl + '/api/PurchasedPackages/all';

  /* ClientChangingTherapist */
  static String getChangingreason = baseUrl + '/api/ClientChangingTherapist/getChangingreason';
  static String clientChangingTherapist = baseUrl + '/api/ClientChangingTherapist';

  /* Content */
  static String getbycontentkey({required String contentkey}) => baseUrl + '/api/Content/getbycontentkey/$contentkey';
}
