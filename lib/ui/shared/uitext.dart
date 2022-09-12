import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/lang/tr_tr.dart';

class Langauge {
  static Locale locale = const Locale('tr', 'TR');

  static String language = '';
}

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('tr', 'TR');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('tr', 'TR');

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('tr', 'TR'), /* Locale('en', 'US') */
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'tr_TR': trTR,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    inspect(locale);
    Langauge.language = locale.languageCode;
    Langauge.locale = locale;
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < locales.length; i++) {
      if (lang == locales[i].toString()) {
        return locales[i];
      } else {
        return locales[0];
      }
    }
    return locales[0];
  }
}

class UIText {
  static String terapizone = 'terapizone'.tr;
  static String back = 'back'.tr;
  static String save = 'save'.tr;
  static String edit = 'edit'.tr;
  //toast
  static String networkError = 'networkError'.tr;
  static String genericError = 'genericError'.tr;
  static String connectionTimeOut = 'connectionTimeOut'.tr;

  static String toaastTitle1 = 'toaastTitle1'.tr;
  static String toastLoginIncorrect = 'toastLoginIncorrect'.tr;
  static String toastRedSign = 'toastRedSign'.tr;
  static String toastChangeConsultant = 'toastChangeConsultant'.tr;
  static String toastSelectOption = 'toastSelectOption'.tr;
  static String toastLastQuestionSaveText = 'toastLastQuestionSaveText'.tr;
  static String toastPaymentAddCard = 'toastPaymentAddCard'.tr;
  static String toastSelectTopic = 'toastSelectTopic'.tr;

  static String toastUserAgreement = 'toastUserAgreement'.tr;
  static String toastKVKK = 'toastKVKK'.tr;
  static String toastLightningText = 'toastLightningText'.tr;
  static String toastPreliminaryContract = 'toastPreliminaryContract'.tr;
  static String toastDistanceSalesAgreement = 'toastDistanceSalesAgreement'.tr;
  static String toastApproveExternalHelp = 'toastApproveExternalHelp'.tr;
  static String toastPhoneAuthFailed = 'toastPhoneAuthFailed'.tr;

  //alert dialogs
  static String textSure = 'textSure'.tr;
  static String textCancel = 'textCancel'.tr;
  static String textOK = 'textOK'.tr;
  static String textError = 'textError'.tr;
  static String textSuccess = 'textSuccess'.tr;
  static String textAbort = 'textAbort'.tr;

  static String textRequestLocation = 'textRequestLocation'.tr;
  static String textExitAppTitle = 'textExitAppTitle'.tr;
  static String textExitAppContent = 'textExitAppContent'.tr;

  static String textAddCardSuccess = 'textAddCardSuccess'.tr;
  static String textAddCardFail = 'textAddCardFail'.tr;
  static String textAddWorkScheduleBreak = 'textAddWorkScheduleBreak'.tr;
  static String textAddRoutineBreak = 'textAddRoutineBreak'.tr;
  static String textDeleteWarning = 'textDeleteWarning'.tr;
  static String textDeleteSuccess = 'textDeleteSuccess'.tr;
  static String textSettingSaveSuccess = 'textSettingSaveSuccess'.tr;
  static String textAddTestAnswerSaveSure = 'textAddTestAnswerSaveSure'.tr;
  static String textAddTestAnswerSuccess = 'textAddTestAnswerSuccess'.tr;
  static String textCancelAppointmentWarning =
      'textCancelAppointmentWarning'.tr;
  static String textCancelAppointmentSuccess =
      'textCancelAppointmentSuccess'.tr;
  static String textNotAllowedPastDates = 'textNotAllowedPastDates'.tr;
  static String textDeleteCardWarning = 'textDeleteCardWarning'.tr;
  static String textDeleteCardSuccess = 'textDeleteCardSuccess'.tr;
  static String textChangePswrdSuccess = 'textChangePswrdSuccess'.tr;
  static String textChangePswrdError = 'textChangePswrdError'.tr;
  static String textPaymentError = 'textPaymentError'.tr;

  static String textSendTest = 'textSendTest'.tr;

  //days
  static String monday = 'monday'.tr;
  static String tuesday = 'tuesday'.tr;
  static String wednesday = 'wednesday'.tr;
  static String thursday = 'thursday'.tr;
  static String friday = 'friday'.tr;
  static String saturday = 'saturday'.tr;
  static String sunday = 'sunday'.tr;
  static String mondayShort = 'mondayShort'.tr;
  static String tuesdayShort = 'tuesdayShort'.tr;
  static String wednesdayShort = 'wednesdayShort'.tr;
  static String thursdayShort = 'thursdayShort'.tr;
  static String fridayShort = 'fridayShort'.tr;
  static String saturdayShort = 'saturdayShort'.tr;
  static String sundayShort = 'sundayShort'.tr;
  //welcome
  static String welcomeMotto1 = 'welcomeMotto1'.tr;
  static String welcomeMotto2 = 'welcomeMotto2'.tr;
  static String welcomeMotto3 = 'welcomeMotto3'.tr;
  static String welcomeBtn = 'welcomeBtn'.tr;
  static String welcomeLogin1 = 'welcomeLogin1'.tr;
  static String welcomeLogin2 = 'welcomeLogin2'.tr;
  static String welcomeWarning = 'welcomeWarning'.tr;

  //login & register
  static String loginRegisterOr = 'loginRegisterOr'.tr;
  static String loginRegisterTab1 = 'loginRegisterTab1'.tr;
  static String loginRegisterTab2 = 'loginRegisterTab2'.tr;
  static String loginRegisterTitle1 = 'loginRegisterTitle1'.tr;
  static String loginRegisterTitle2 = 'loginRegisterTitle2'.tr;
  static String loginWithFacebook = 'loginWithFacebook'.tr;
  static String loginWithGoogle = 'loginWithGoogle'.tr;
  static String loginWithApple = 'loginWithApple'.tr;
  static String loginEmail = 'loginEmail'.tr;
  static String loginPswrd = 'loginPswrd'.tr;
  static String loginHintEmail = 'loginHintEmail'.tr;
  static String loginHintPswrd = 'loginHintPswrd'.tr;
  static String loginButton1 = 'loginButton1'.tr;
  static String loginButton2 = 'loginButton2'.tr;
  static String loginValidator = 'loginValidator'.tr;
  static String registerWithFacebook = 'registerWithFacebook'.tr;
  static String registerWithGoogle = 'registerWithGoogle'.tr;
  static String registerWithApple = 'registerWithApple'.tr;
  static String registerNickname = 'registerNickname'.tr;
  static String registerPhone = 'registerPhone'.tr;

  static String registerEmail = 'registerEmail'.tr;
  static String registerPswrd = 'registerPswrd'.tr;
  static String registerHintNickname = 'registerHintNickname'.tr;
  static String registerHintPhone = 'registerHintPhone'.tr;
  static String registerHintEmail = 'registerHintEmail'.tr;
  static String registerHintPswrd = 'registerHintPswrd'.tr;
  static String registerButton1 = 'registerButton1'.tr;
  static String registerButton2_1 = 'registerButton2_1'.tr;
  static String registerButton2_2 = 'registerButton2_2'.tr;
  static String registerButton2_3 = 'registerButton2_3'.tr;
  static String registerButton2_4 = 'registerButton2_4'.tr;
  static String registerButton3_1 = 'registerButton3_1'.tr;
  static String registerEmailValidator = 'registerEmailValidator'.tr;
  static String registerCodeDialogTitle = 'registerCodeDialogTitle'.tr;

//login forgot password
  static String forgotPasswordTitle1CodeToMail =
      'forgotPasswordTitle1CodeToMail'.tr;
  static String forgotPasswordHint1EnterYourMail =
      'forgotPasswordHint1EnterYourMail'.tr;
  static String forgotPasswordSendButton = 'forgotPasswordSendButton'.tr;
  static String forgotPasswordThisFieldCantBeEmpty =
      'forgotPasswordThisFieldCantBeEmpty'.tr;
  static String forgotPasswordEnterCodeThisFieldTitle2 =
      'forgotPasswordEnterCodeThisFieldTitle2'.tr;
  static String forgotPasswordEnterCodeHint2 =
      'forgotPasswordEnterCodeHint2'.tr;
  static String forgotPasswordRefreshPasswordButton =
      'forgotPasswordRefreshPasswordButton'.tr;
  static String forgotPasswordSendAgainButton =
      'forgotPasswordSendAgainButton'.tr;
  static String forgotPasswordSetPasswordTitle3 =
      'forgotPasswordSetPasswordTitle3'.tr;
  static String forgotPasswordNewPasswordHint3 =
      'forgotPasswordNewPasswordHint3'.tr;
  static String forgotPasswordNewPasswordAgainHint4 =
      'forgotPasswordNewPasswordAgainHint4'.tr;
  static String forgotPasswordSaveButton = 'forgotPasswordSaveButton'.tr;
  static String forgotPasswordMustSamePassword =
      'forgotPasswordMustSamePassword'.tr;

  //user select for who
  static String selectForWhoTitle = 'selectForWhoTitle'.tr;
  static String selectForWhoButton = 'selectForWhoButton'.tr;
  //user select topic
  static String selectTopicTitle = 'selectTopicTitle'.tr;
  static String selectTopicInfo = 'selectTopicInfo'.tr;
  static String selectTopicButton = 'selectTopicButton'.tr;
  //user select gender
  static String selectGenderTitle = 'selectGenderTitle'.tr;
  static String selectGenderOption1 = 'selectGenderOption1'.tr;
  static String selectGenderOption2 = 'selectGenderOption2'.tr;
  static String selectGenderOption3 = 'selectGenderOption3'.tr;
  static String selectGenderButton = 'selectGenderButton'.tr;
  //user list consultant
  static String listConsultantTitle = 'listConsultantTitle'.tr;
  static String listConsultantSubTitle = 'listConsultantSubTitle'.tr;
  static String listConsultantAbout = 'listConsultantAbout'.tr;
  static String listConsultantRead = 'listConsultantRead'.tr;
  static String listConsultantButton = 'listConsultantButton'.tr;
  static String listConsultantLoading = 'listConsultantLoading'.tr;

  //user meet consultant
  static String meetConsultantBtn = 'meetConsultantBtn'.tr;
  static String meetConsultantExperience = 'meetConsultantExperience'.tr;
  static String meetConsultantAbout = 'meetConsultantAbout'.tr;
  static String meetConsultantComments = 'meetConsultantComments'.tr;
  static String meetConsultantSeeAll = 'meetConsultantSeeAll'.tr;
  static String meetConsultatWorkingTopics = 'meetConsultatWorkingTopics'.tr;
  static String meetConsultantEducation = 'meetConsultantEducation'.tr;
  static String meetConsultantApproaches = 'meetConsultantApproaches'.tr;
  //user match consultant
  static String matchConsultantMatch = 'matchConsultantMatch'.tr;
  static String matchConsultantText1 = 'matchConsultantText1'.tr;
  static String matchConsultantText2 = 'matchConsultantText2'.tr;
  static String matchConsultantText3 = 'matchConsultantText3'.tr;
  static String matchConsultantButton = 'matchConsultantButton'.tr;
  //user payment
  static String paymentSummary = 'paymentSummary'.tr;
  static String paymentChat = 'paymentChat'.tr;
  static String paymentDiscount = 'paymentDiscount'.tr;
  static String paymentTotal = 'paymentTotal'.tr;
  static String paymentCoupon = 'paymentCoupon'.tr;
  static String paymentAddCoupon = 'paymentAddCoupon'.tr;
  static String paymentCouponCode = 'paymentCouponCode'.tr;
  static String paymentBill = 'paymentBill'.tr;
  static String paymentNickname = 'paymentNickname'.tr;
  static String paymentAddBillInfo = 'paymentAddBillInfo'.tr;
  static String paymentInfo = 'paymentInfo'.tr;
  static String paymentCardName = 'paymentCardName'.tr;
  static String paymentCardNameHint = 'paymentCardNameHint'.tr;
  static String paymentCardNumber = 'paymentCardNumber'.tr;
  static String paymentCardNumberHint = 'paymentCardNumberHint'.tr;
  static String paymentCardExpiry = 'paymentCardExpiry'.tr;
  static String paymentCardExpiryHint = 'paymentCardExpiryHint'.tr;
  static String paymentCardCvc = 'paymentCardCvc'.tr;
  static String paymentCardCvcHint = 'paymentCardCvcHint'.tr;
  static String paymentAgreementText1 = 'paymentAgreementText1'.tr;
  static String paymentAgreementText2 = 'paymentAgreementText2'.tr;
  static String paymentAgreementText3 = 'paymentAgreementText3'.tr;
  static String paymentAgreementText4 = 'paymentAgreementText4'.tr;
  static String paymentAgreementText5 = 'paymentAgreementText5'.tr;
  static String paymentButton = 'paymentButton'.tr;
  static String paymentFieldReq = 'paymentFieldReq'.tr;
  static String paymentNumberIsInvalid = 'paymentNumberIsInvalid'.tr;
  static String paymentCvcIsInvalid = 'paymentCvcIsInvalid'.tr;
  static String paymentMonthIsInvalid = 'paymentMonthIsInvalid'.tr;
  static String paymentYearIsInvalid = 'paymentYearIsInvalid'.tr;
  static String paymentCardExpired = 'paymentCardExpired'.tr;
  //user add invoice
  static String addInvoiceTitle = 'addInvoiceTitle'.tr;
  static String addInvoiceCancel = 'addInvoiceCancel'.tr;
  static String addInvoicePerson = 'addInvoicePerson'.tr;
  static String addInvoiceCompany = 'addInvoiceCompany'.tr;
  static String addInvoiceInfo = 'addInvoiceInfo'.tr;
  static String addInvoiceNameSurname = 'addInvoiceNameSurname'.tr;
  static String addInvoiceNameSurnameHint = 'addInvoiceNameSurnameHint'.tr;
  static String addInvoiceIdentity = 'addInvoiceIdentity'.tr;
  static String addInvoiceIdentityHint = 'addInvoiceIdentityHint'.tr;
  static String addInvoiceAddress = 'addInvoiceAddress'.tr;
  static String addInvoiceAddressHint = 'addInvoiceAddressHint'.tr;
  static String addInvoiceCity = 'addInvoiceCity'.tr;
  static String addInvoiceCityHint = 'addInvoiceCityHint'.tr;
  static String addInvoiceDistrict = 'addInvoiceDistrict'.tr;
  static String addInvoiceDistrictHint = 'addInvoiceDistrictHint'.tr;
  static String addInvoiceTitleWork = 'addInvoiceTitleWork'.tr;
  static String addInvoiceTitleWorkHint = 'addInvoiceTitleWorkHint'.tr;
  static String addInvoiceTaxNo = 'addInvoiceTaxNo'.tr;
  static String addInvoiceTaxNoHint = 'addInvoiceTaxNoHint'.tr;
  static String addInvoiceTaxAdministration = 'addInvoiceTaxAdministration'.tr;
  static String addInvoiceTaxAdministrationHint =
      'addInvoiceTaxAdministrationHint'.tr;
  //user payment success
  static String paymentSuccessClose = 'paymentSuccessClose'.tr;
  static String paymentSuccessText = 'paymentSuccessText'.tr;
  static String paymentSuccessSubText = 'paymentSuccessSubText'.tr;
  static String paymentSuccessBtn = 'paymentSuccessBtn'.tr;
  //user settings
  static String settingsTitle = 'settingsTitle'.tr;
  static String settingsInfo = 'settingsInfo'.tr;
  static String settingsConsultant = 'settingsConsultant'.tr;
  static String settingsSubscription = 'settingsSubscription'.tr;
  static String settingsVideoTherapy = 'settingsVideoTherapy'.tr;
  static String settingsNotification = 'settingsNotification'.tr;
  static String settingsChangePswrd = 'settingsChangePswrd'.tr;
  static String settingsHelp = 'settingsHelp'.tr;
  static String settingsRecommend = 'settingsRecommend'.tr;
  static String settingsExit = 'settingsExit'.tr;
  static String settingsWarning = 'settingsWarning'.tr;
  static String settingsBuyNewPackage = 'settingsBuyNewPackage'.tr;
  static String settingsContact = 'settingsContact'.tr;
  static String settingsEmail = 'settingsEmail'.tr;
  static String settingsPhoneCall = 'Ara'.tr;
  static String settingsWhatsapp = 'settingsWhatsapp'.tr;

  //user profile
  static String profileTitle = 'profileTitle'.tr;
  static String profileChange = 'profileChange'.tr;
  static String profileNickname = 'profileNickname'.tr;
  static String profilePswrd = 'profilePswrd'.tr;
  static String profileEmail = 'profileEmail'.tr;
  static String profilePhone = 'profilePhone'.tr;
  static String profileAdd = 'profileAdd'.tr;
  static String profileBirthdate = 'profileBirthdate'.tr;
  static String profileGender = 'profileGender'.tr;
  static String profileMatchChoices = 'profileMatchChoices'.tr;
  static String profileComplaint = 'profileComplaint'.tr;
  static String profileComplaintSub = 'profileComplaintSub'.tr;
  static String profileConsultantGender = 'profileConsultantGender'.tr;
  static String profileDeleteAccount = 'profileDeleteAccount'.tr;
  //user nickname
  static String nicknameTitle = 'nicknameTitle'.tr;
  //user change password
  static String changePswrdTitle = 'changePswrdTitle'.tr;
  static String changePswrdCurrentHint = 'changePswrdCurrentHint'.tr;
  static String changePswrdNewHint = 'changePswrdNewHint'.tr;
  static String changePswrdNewHint2 = 'changePswrdNewHint2'.tr;
  static String changePswrdFieldReq = 'changePswrdFieldReq'.tr;
  static String changePswrdCurrentPswrdError =
      'changePswrdCurrentPswrdError'.tr;

  //user preferences
  static String preferencesTitle = 'preferencesTitle'.tr;
  static String preferencesNotifications = 'preferencesNotifications'.tr;
  static String preferencesVideoTherapy = 'preferencesVideoTherapy'.tr;
  static String preferencesNewMessage = 'preferencesNewMessage'.tr;

  static String preferencesCampaign = 'preferencesCampaign'.tr;
  //user delete account
  static String deleteAccountCancel = 'deleteAccountCancel'.tr;
  static String deleteAccountTitle = 'deleteAccountTitle'.tr;
  static String deleteAccountText = 'deleteAccountText'.tr;
  static String deleteAccountSubtext = 'deleteAccountSubtext'.tr;
  static String deleteAccountBtn = 'deleteAccountBtn'.tr;
  static String deleteAccountWhy = 'deleteAccountWhy'.tr;
  static String deleteAccountReason1 = 'deleteAccountReason1'.tr;
  static String deleteAccountReason2 = 'deleteAccountReason2'.tr;
  static String deleteAccountReason3 = 'deleteAccountReason3'.tr;
  static String deleteAccountReason4 = 'deleteAccountReason4'.tr;
  static String deleteAccountReason5 = 'deleteAccountReason5'.tr;
  static String deleteAccountReason6 = 'deleteAccountReason6'.tr;
  //user subscription
  static String subscriptionTitle = 'subscriptionTitle'.tr;
  static String subscriptionPlan = 'subscriptionPlan'.tr;
  static String subscriptionTherapyChat = 'subscriptionTherapyChat'.tr;
  static String subscriptionStartDate = 'subscriptionStartDate'.tr;
  static String subscriptionEndDate = 'subscriptionEndDate'.tr;
  static String subscriptionRenew = 'subscriptionRenew'.tr;
  static String subscriptionCards = 'subscriptionCards'.tr;
  static String subscriptionAddCard = 'subscriptionAddCard'.tr;
  static String subscriptionPurchaseHistory = 'subscriptionPurchaseHistory'.tr;
  static String subscriptionEditInvoice = 'subscriptionEditInvoice'.tr;
  // user Purchase History
  static String purchaseHistoryTitle = 'purchaseHistoryTitle'.tr;
  //user my consultant
  static String myConsultantChange = 'myConsultantChange'.tr;
  static String myConsultantTitle = 'myConsultantTitle'.tr;
  static String myConsultantBtn = 'myConsultantBtn'.tr;
  static String myConsultantExperience = 'myConsultantExperience'.tr;
  static String myConsultantAbout = 'myConsultantAbout'.tr;
  static String myConsultantComments = 'myConsultantComments'.tr;
  static String myConsultantSeeAll = 'myConsultantSeeAll'.tr;
  static String myConsultantWorkingTopics = 'myConsultantWorkingTopics'.tr;
  static String myConsultantEducation = 'myConsultantEducation'.tr;
  static String myConsultantApproaches = 'meetConsultantApproaches'.tr;
  //user change consultant
  static String changeConsultantCancel = 'changeConsultantCancel'.tr;
  static String changeConsultantTitle = 'changeConsultantTitle'.tr;
  static String changeConsultantText = 'changeConsultantText'.tr;
  static String changeConsultantSubtext = 'changeConsultantSubtext'.tr;
  static String changeConsultantBtn = 'changeConsultantBtn'.tr;
  static String changeConsultantWhy = 'changeConsultantWhy'.tr;
  static String changeConsultantHint = 'changeConsultantHint'.tr;
  static String changeConsultantNote = 'changeConsultantNote'.tr;
  static String changeConsultantComplaint = 'changeConsultantComplaint'.tr;
  static String changeConsultantComplaintSub =
      'changeConsultantComplaintSub'.tr;
  static String changeConsultantGender = 'changeConsultantGender'.tr;
  static String changeConsultantApproval = 'changeConsultantApproval'.tr;
  static String changeConsultantBtn2 = 'changeConsultantBtn2'.tr;
  //user video therapy
  static String videoTherapyTitle = 'videoTherapyTitle'.tr;
  static String videoTherapySession = 'videoTherapySession'.tr;
  static String videoTherapyBuy = 'videoTherapyBuy'.tr;
  static String videoTherapyAppointments = 'videoTherapyAppointments'.tr;
  static String videoTherapyNoAppointments = 'videoTherapyNoAppointments'.tr;
  static String videoTherapyNewAppointments = 'videoTherapyNewAppointments'.tr;
  static String videoTherapyAppointmentsNote =
      'videoTherapyAppointmentsNote'.tr;
  static String videoTherapyPastAppointments =
      'videoTherapyPastAppointments'.tr;
  static String videoTherapyJoin = 'videoTherapyJoin'.tr;
  static String videoTherapyCancel = 'videoTherapyCancel'.tr;
  static String videoTherapyToday = 'videoTherapyToday'.tr;

  //user past appointments
  static String pastAppointmentsTitle = 'pastAppointmentsTitle'.tr;
  static String pastAppointmentsNote = 'pastAppointmentsNote'.tr;
  //user buy video therapy
  static String buyVideoTherapyTitle = 'buyVideoTherapyTitle'.tr;

  static String buySubtext = 'buySubtext'.tr;
  static String buyButton = 'buyButton'.tr;
  //user payment video therapy
  static String paymentVideoTherapySummary = 'paymentVideoTherapySummary'.tr;
  static String paymentVideoTherapy = 'paymentVideoTherapy'.tr;
  static String paymentVideoTherapyDiscount = 'paymentVideoTherapyDiscount'.tr;
  static String paymentVideoTherapyTotal = 'paymentVideoTherapyTotal'.tr;
  static String paymentVideoTherapyBill = 'paymentVideoTherapyBill'.tr;
  static String paymentVideoTherapyNickname = 'paymentVideoTherapyNickname'.tr;
  static String paymentVideoTherapyAddBillInfo =
      'paymentVideoTherapyAddBillInfo'.tr;
  static String paymentVideoTherapyMethod = 'paymentVideoTherapyMethod'.tr;
  static String paymentVideoTherapyAddCard = 'paymentVideoTherapyAddCard'.tr;
  static String paymentVideoTherapyAgreement1 =
      'paymentVideoTherapyAgreement1'.tr;
  static String paymentVideoTherapyAgreement2 =
      'paymentVideoTherapyAgreement2'.tr;
  static String paymentVideoTherapyAgreement3 =
      'paymentVideoTherapyAgreement3'.tr;
  static String paymentVideoTherapyBtn1 = 'paymentVideoTherapyBtn1'.tr;
  static String paymentVideoTherapyBtn2 = 'paymentVideoTherapyBtn2'.tr;
  static String paymentVideoTherapyBtn3 = 'paymentVideoTherapyBtn3'.tr;

  //user payment video therapy success
  static String paymentVideoTherapySuccessClose =
      'paymentVideoTherapySuccessClose'.tr;
  static String paymentVideoTherapySuccessText =
      'paymentVideoTherapySuccessText'.tr;
  static String paymentVideoTherapySuccessSubText =
      'paymentVideoTherapySuccessSubText'.tr;
  static String paymentVideoTherapySuccessBtn =
      'paymentVideoTherapySuccessBtn'.tr;
  //user new appointment
  static String newAppointmentTitle = 'newAppointmentTitle'.tr;
  static String newAppointmentBtn = 'newAppointmentBtn'.tr;
  static String newAppointmentInfo = 'newAppointmentInfo'.tr;
  static String newAppointmentSuccess = 'newAppointmentSuccess'.tr;

  //user dashbaord
  static String dashboardMessages = 'dashboardMessages'.tr;
  static String dashboardMeetings = 'dashboardMeetings'.tr;
  static String dashboardSeeAll = 'dashboardSeeAll'.tr;
  static String dashboardNewMeeting = 'dashboardNewMeeting'.tr;
  static String dashboardNoUpcomingsMeeting = 'dashboardNoUpcomingsMeeting'.tr;
  static String dashboardSymptomTracker = 'dashboardSymptomTracker'.tr;
  //user chat
  static String chatMsgHint = 'chatMsgHint'.tr;
  static String chatCamera = 'chatCamera'.tr;
  static String chatPhoto = 'chatPhoto'.tr;
  static String chatDocument = 'chatDocument'.tr;
  static String chatVoiceMessage = 'chatVoiceMessage'.tr;
  static String chatButtonCancel = 'chatButtonCancel'.tr;
  static String chatSendTest = 'chatSendTest'.tr;

  // user external help
  static String externalHelpTitle = 'externalHelpTitle'.tr;
  static String externalHelpText1 = 'externalHelpText1'.tr;
  static String externalHelpText2 = 'externalHelpText2'.tr;
  static String externalHelpText3 = 'externalHelpText3'.tr;
  static String externalHelpText4 = 'externalHelpText4'.tr;
  static String externalHelpText5 = 'externalHelpText5'.tr;
  static String externalHelpWarning1 = 'externalHelpWarning1'.tr;
  static String externalHelpWarning2 = 'externalHelpWarning2'.tr;
  static String externalHelpApproveText = 'externalHelpApproveText'.tr;
  static String externalHelpButton = 'externalHelpButton'.tr;

  /* -------------------- Consultant -------------------------*/
  static String bottomAppbarMessages = 'bottomAppbarMessages'.tr;
  static String bottomAppbarMeetings = 'bottomAppbarMeetings'.tr;
  static String bottomAppbarCalendar = 'bottomAppbarCalendar'.tr;
  static String bottomAppbarSettings = 'bottomAppbarSettings'.tr;
  //Consultant settings
  static String cSettingsTitle = 'settingsTitle'.tr;
  static String cSettingsNotifications = 'cSettingsNotifications'.tr;
  static String cSettingsFinance = 'cSettingsFinance'.tr;
  static String cSettingCalendarSettings = 'cSettingCalendarSettings'.tr;
  static String cSettingsScales = 'cSettingsScales'.tr;
  static String cSettingsScriptedMsg = 'cSettingsScriptedMsg'.tr;
  static String cSettingsMeetChoices = 'cSettingsMeetChoices'.tr;
  static String cSettingsNotificationSettings =
      'cSettingsNotificationSettings'.tr;
  static String cSettingsSecurity = 'cSettingsSecurity'.tr;
  static String cSettingsHelp = 'cSettingsHelp'.tr;
  static String cSettingsExit = 'settingsExit'.tr;

  //Consultant messages
  static String cMessagesTitle = 'cMessagesTitle'.tr;
  static String cMessagesArchive = 'cMessagesArchive'.tr;
  static String cMessagesHint = 'cMessagesHint'.tr;
  static String cMessagesEmpty = 'cMessagesEmpty'.tr;

  //Consultant meeting
  static String cMeetingsTitle = 'cMeetingsTitle'.tr;

  //Consultant client profile
  static String cClientProfileLeading = 'cClientProfileLeading'.tr;
  static String cClientProfileAbout = 'cClientProfileAbout'.tr;
  static String cClientProfileAge = 'cClientProfileAge'.tr;
  static String cClientProfileSex = 'cClientProfileSex'.tr;
  static String cClientProfileStartDate = 'cClientProfileStartDate'.tr;
  static String cClientProfileReason = 'cClientProfileReason'.tr;
  static String cClientProfileSessions = 'cClientProfileSessions'.tr;
  static String cClientProfileNotes = 'cClientProfileNotes'.tr;
  static String cClientProfileTargets = 'cClientProfileTargets'.tr;
  static String cClientProfileTestScores = 'cClientProfileTestScores'.tr;
  static String cClientProfileTestScoresNotFound =
      'cClientProfileTestScoresNotFound'.tr;

  //Consultant security
  static String cSecurityTitle = 'cSecurityTitle'.tr;
  static String cSecurityChangePswrd = 'cSecurityChangePswrd'.tr;
  static String cSecurityChangePswrdHint = 'cSecurityChangePswrdHint'.tr;
  static String cSecurityAppPswrd = 'cSecurityAppPswrd'.tr;
  static String cSecurityAppPswrdHint = 'cSecurityAppPswrdHint'.tr;
  static String cSecurityFaceId = 'cSecurityFaceId'.tr;
  static String cSecurityChangeAppPswrd = 'cSecurityChangeAppPswrd'.tr;

  //Consultant notifications
  static String cnotificationsTitle = 'cnotificationsTitle'.tr;
  static String cnotificationsNewMsg = 'cnotificationsNewMsg'.tr;
  static String cnotificationsNewClient = 'cnotificationsNewClient'.tr;
  static String cnotificationsNewSession = 'cnotificationsNewSession'.tr;
  static String cnotificationsJoinSession = 'cnotificationsJoinSession'.tr;

  //Consultant match choices
  static String cMatchTitle = 'cMatchTitle'.tr;
  static String cMatchNewClient = 'cMatchNewClient'.tr;
  static String cMatchNewClientHint = 'cMatchNewClientHint'.tr;
  static String cMatchNote = 'cMatchNote'.tr;

  //Consultant finance
  static String cFinanceTitle = 'cFinanceTitle'.tr;
  static String cFinanceBalance = 'cFinanceBalance'.tr;
  static String cFinancePending = 'cFinancePending'.tr;
  static String cFinanceAdvanceAcoount = 'cFinanceAdvanceAcoount'.tr;
  static String cFinanceTotal = 'cFinanceTotal'.tr;
  static String cFinanceSubtitle = 'cFinanceSubtitle'.tr;

  //Consultant calendar settings
  static String cCalendarSettingsTitle = 'cCalendarSettingsTitle'.tr;
  static String cCalendarSettingsSubtitle1 = 'cCalendarSettingsSubtitle1'.tr;
  static String cCalendarSettingsSubtitle2 = 'cCalendarSettingsSubtitle2'.tr;
  static String cCalendarSettingsSubtitle3 = 'cCalendarSettingsSubtitle3'.tr;
  static String cCalendarSettingsTime = 'cCalendarSettingsTime'.tr;
  static String cCalendarSettingsAdd = 'cCalendarSettingsAdd'.tr;
  static String cCalendarSettingsHint1 = 'cCalendarSettingsHint1'.tr;
  static String cCalendarSettingsHint2 = 'cCalendarSettingsHint2'.tr;
  static String cCalendarSettingsNoon = 'cCalendarSettingsNoon'.tr;
  static String cCalendarSettingsSwicthContent =
      'cCalendarSettingsSwicthContent'.tr;
  static String cCalendarSettingsCounter1 = 'cCalendarSettingsCounter1'.tr;
  static String cCalendarSettingsCounter2 = 'cCalendarSettingsCounter2'.tr;

  //Consultant working routine
  static String cWorkingRoutineTitle = 'cWorkingRoutineTitle'.tr;
  static String cWorkingRoutineWorkingHours = 'cWorkingRoutineWorkingHours'.tr;
  static String cWorkingRoutineRepeat = 'cWorkingRoutineRepeat'.tr;
  static String cWorkingRoutineHint = 'cWorkingRoutineHint'.tr;
  static String cWorkingRoutineDelete = 'cWorkingRoutineDelete'.tr;

  //Consultantlunch break
  static String cRoutineBreakTitle = 'cRoutineBreakTitle'.tr;
  static String cRoutineBreakWorkingHours = 'cRoutineBreakWorkingHours'.tr;
  static String cRoutineBreakRepeat = 'cRoutineBreakRepeat'.tr;
  static String cRoutineBreakHint = 'cRoutineBreakHint'.tr;
  static String cRoutineBreakDelete = 'cRoutineBreakDelete'.tr;

  //Consultant calender meeting hours
  static String cCalenderMeetingHoursAllDay = 'cCalenderMeetingHoursAllDay'.tr;
  static String cCalenderCancel = 'cCalenderCancel'.tr;

  //common notifications
  static String notificationsTitle = 'notificationsTitle'.tr;
  static String notificationsNotFound = 'notificationsNotFound'.tr;
}
