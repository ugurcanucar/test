import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_auth_login_model.dart';
import 'package:terapizone/ui/models/post_device_registration_model.dart';
import 'package:terapizone/ui/models/response_auth_login_model.dart';
import 'package:terapizone/ui/models/response_auth_register_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/post_auth_register_model.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_consultant/view_home.dart';
import 'package:terapizone/ui/views/views_user/view_dashboard.dart';
import 'package:terapizone/ui/views/views_user/view_external_help.dart';
import 'package:terapizone/ui/views/views_user/view_list_consultant.dart';
import 'package:terapizone/ui/views/views_user/view_select_for_who.dart';
import 'package:terapizone/ui/views/views_user/view_select_disease.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';

class TerapizoneUser {
  static ResponseAuthLoginModel? user;
}

class ControllerLoginRegister extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
    String email = GeneralData.getEmail();
    if (email.isNotEmpty) _loginEmailController.text = email;

    String password = GeneralData.getPassword();
    if (password.isNotEmpty) _loginPasswordController.text = password;

    /*  if (_loginEmailController.text.isNotEmpty &&
        _loginPasswordController.text.isNotEmpty) {
      login();
    } */
  }
  /* common */

  //common states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt _tabIndex = 0.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get tabIndex => _tabIndex.value;

  void setTabIndex(int value) => _tabIndex.value = value;

  /* login tab */

  //controllers login
  final TextEditingController _loginEmailController = TextEditingController();
  TextEditingController get loginEmailController => _loginEmailController;

  final TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController get loginPasswordController => _loginPasswordController;

  final focusLoginEmail = FocusNode();
  final focusLoginPassword = FocusNode();

  //states login
  final GlobalKey<FormState> _loginKeyForm = GlobalKey<FormState>();

  final RxBool _loginObscureText = true.obs;
  ResponseAuthLoginModel? _loginModel;

  GlobalKey<FormState> get loginKeyForm => _loginKeyForm;
  bool get loginObscureText => _loginObscureText.value;
  ResponseAuthLoginModel? get loginModel => _loginModel;

  void setObscureTextLogin(bool status) {
    _loginObscureText.value = status;
  }

  Future<void> login(String email, String password) async {
    if (_loginKeyForm.currentState == null || _loginKeyForm.currentState!.validate()) {
      setBusy(true);
      PostAuthLoginModel postitem = PostAuthLoginModel(
        email: email,
        password: password,
      );

      ResponseData<ResponseAuthLoginModel> response =
          await ApiService.apiRequest(Get.context!, ApiMethod.post, endpoint: Endpoint.login, body: postitem.toJson());
      setBusy(false);

      if (response.success && response.data != null) {
        _loginModel = response.data;
        TerapizoneUser.user = _loginModel!;
        GeneralData.setAccessToken(_loginModel!.accessToken!.token!);
        GeneralData.setEmail(email);
        GeneralData.setPassword(password);
        GeneralData.setRefreshToken(_loginModel!.accessToken!.refreshToken!);
        GeneralData.setUserInfo(_loginModel!.user!.id!);

        deviceRegistiration();
        // accountTypeId == 1 -> client
        // accountTypeId == 2 -> therapist
        if (_loginModel!.user!.accountTypeId == 1) {
          if (_loginModel!.isClientTherapist! && _loginModel!.isPurchasedPackage!) {
            Get.offAll(() => const ViewDashboard());
          } else if (!_loginModel!.isClientTherapist!) {
            Get.offAll(
              () => ViewSelectForWho(
                onTap: () => Get.to(
                  () => ViewSelectDisease(
                    onTap: () => Get.to(
                      () => ViewExternalHelp(
                        onTap: () => Get.to(
                          () => const ViewListConsultant(isFromRegister: true),
                        ),
                        isFromRegister: true,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (!_loginModel!.isPurchasedPackage!) {
            Get.offAll(
              () => ViewSelectForWho(
                onTap: () => Get.to(
                  () => ViewSelectDisease(
                    onTap: () => Get.to(
                      () => ViewExternalHelp(
                        onTap: () => Get.to(
                          () => const ViewListConsultant(isFromRegister: true),
                        ),
                        isFromRegister: true,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            Get.offAll(() => const ViewDashboard());
          }
        } else {
          Get.offAll(() => const ViewHome());
        }
      } else {
        Utilities.showToast(UIText.toastLoginIncorrect);
      }
    }
  }
  /* register tab */

  //controllers register
  final TextEditingController _registerNicknameController = TextEditingController();
  TextEditingController get registerNicknameController => _registerNicknameController;

  final TextEditingController _registerPhoneController = TextEditingController();
  TextEditingController get registerPhoneController => _registerPhoneController;

  final TextEditingController _registerCodeController = TextEditingController();
  TextEditingController get registerCodeController => _registerCodeController;

  final TextEditingController _registerEmailController = TextEditingController();
  TextEditingController get registerEmailController => _registerEmailController;

  final TextEditingController _registerPasswordController = TextEditingController();
  TextEditingController get registerPasswordController => _registerPasswordController;

  final focusRegisterNickname = FocusNode();
  final focusRegisterPhone = FocusNode();
  final focusRegisterEmail = FocusNode();
  final focusRegisterPassword = FocusNode();
  final focusCode = FocusNode();

  //states register
  final GlobalKey<FormState> _registerKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerCodeKeyForm = GlobalKey<FormState>();

  final RxBool _registerObscureText = true.obs;
  final RxBool _checkboxUserAgreement = false.obs;
  final RxBool _checkboxKVKK = false.obs;
  final RxBool _checkboxLightning = false.obs;

  GlobalKey<FormState> get registerKeyForm => _registerKeyForm;
  bool get registerObscureText => _registerObscureText.value;
  bool get checkboxUserAgreement => _checkboxUserAgreement.value;
  bool get checkboxKVKK => _checkboxKVKK.value;
  bool get checkboxLightning => _checkboxLightning.value;

  setCheckBoxUserAgreement(value) {
    _checkboxUserAgreement.value = value;
  }

  setCheckboxKVKK(value) {
    _checkboxKVKK.value = value;
  }

  setCheckboxLightning(value) {
    _checkboxLightning.value = value;
  }

  void setObscureTextRegister(bool status) {
    _registerObscureText.value = status;
  }

  void registerFormApprove() async {
    if (_registerKeyForm.currentState == null || _registerKeyForm.currentState!.validate()) {
      if (!_checkboxUserAgreement.value) {
        inspect("hata burda");

        Utilities.showToast(UIText.toastUserAgreement); // accept user agreement
        return;
      } else if (!_checkboxKVKK.value) {
        inspect("hata burda");

        Utilities.showToast(UIText.toastKVKK); // accept kvkk
        return;
      } else if (!_checkboxLightning.value) {
        inspect("hata burda");

        Utilities.showToast(UIText.toastLightningText); // accept lightning
        return;
      }
      await verifyUserPhone(Get.context!);
    }
  }

  Future register() async {
    setBusy(true);
    PostAuthRegisterModel postitem = PostAuthRegisterModel(
      email: _registerEmailController.text,
      password: _registerPasswordController.text,
      nickName: _registerNicknameController.text,
      birthDay: DateTime.now().toIso8601String(),
      gender: 1,
      accountTypeId: 1,
      phone: '+90' + _registerPhoneController.text.replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''),
    );
    ResponseData<ResponseAuthRegisterModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.post, endpoint: Endpoint.register, body: postitem.toJson());
    setBusy(false);
    if (response.success && response.data != null) {
      ResponseAuthRegisterModel r = response.data;
      GeneralData.setEmail(_registerEmailController.text);
      GeneralData.setPassword(_registerPasswordController.text);
      if (r.token != null) GeneralData.setAccessToken(r.token!);
      deviceRegistiration();
      Get.offAll(
        () => ViewSelectForWho(
          onTap: () => Get.to(
            () => ViewSelectDisease(
              onTap: () => Get.to(
                () => ViewExternalHelp(
                  onTap: () => Get.to(
                    () => const ViewListConsultant(isFromRegister: true),
                  ),
                  isFromRegister: true,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  Future verifyUserPhone(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: '+90' + _registerPhoneController.text.replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Get.back();

          try {
            UserCredential result = await _auth.signInWithCredential(credential);

            User? user = result.user;
            if (user != null) {
              await register();
            } else {
              inspect("hata burda");

              Utilities.showToast(UIText.toastPhoneAuthFailed); //phone verifaction failed
            }
          } on FirebaseAuthException catch (e) {
            String msg = e.message ?? '';
            inspect("hata burda");

            Utilities.showToast(UIText.toastPhoneAuthFailed + ' ' + msg);
            log(msg);
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          inspect("hata burda");

          Utilities.showToast(exception.message ?? '');
          log(exception.message ?? '');
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          Get.bottomSheet(
            Material(
              child: Wrap(
                children: [
                  Container(
                    color: UIColor.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Form(
                            key: _registerCodeKeyForm,
                            child: TextFormField(
                              controller: _registerCodeController,
                              cursorColor: UIColor.azureRadiance,
                              focusNode: focusCode,
                              onFieldSubmitted: (t) => FocusScope.of(context).requestFocus(FocusNode()),
                              style: TextStyle(fontSize: 13, color: UIColor.black),
                              validator: (t) {
                                if (t != null) {
                                  if (t.isEmpty) {
                                    return UIText.loginValidator;
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: UIText.registerCodeDialogTitle,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: UIColor.frenchGray)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: UIColor.azureRadiance)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: UIColor.redOrange)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: UIColor.redOrange)),
                              ),
                            ),
                          ),
                        ),
                        ButtonBorder(
                            buttonText: UIText.textOK,
                            borderColor: UIColor.azureRadiance,
                            textColor: UIColor.azureRadiance,
                            onTap: () async {
                              if (_registerKeyForm.currentState == null ||
                                  _registerCodeKeyForm.currentState!.validate()) {
                                Get.back();
                                try {
                                  final code = _registerCodeController.text.trim();
                                  AuthCredential credential =
                                      PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                                  UserCredential result = await _auth.signInWithCredential(credential);

                                  User? user = result.user;

                                  if (user != null) {
                                    await register();
                                  } else {
                                    inspect("hata burda");

                                    Utilities.showToast(UIText.toastPhoneAuthFailed); //phone verifaction failed
                                  }
                                } on FirebaseAuthException catch (e) {
                                  String msg = e.message ?? '';
                                  inspect("hata burda");

                                  Utilities.showToast(UIText.toastPhoneAuthFailed + ' ' + msg);
                                  log(msg);
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isScrollControlled: true,
          );
        },
        codeAutoRetrievalTimeout: (String codeAutoRetrievalTimeout) {
          inspect("hata burda");

          Utilities.showToast(codeAutoRetrievalTimeout);
        });
  }

  void deviceRegistiration() async {
    String macAddress = '';

    PostDeviceRegistrationModel postitem = PostDeviceRegistrationModel(
      macAddress: macAddress,
      fcmToken: GeneralData.getFCMToken(),
      platform: Platform.isAndroid ? 'Android' : 'iOS',
      ipAddress: "",
      latitude: 0,
      longitude: 0,
    );
    await ApiService.apiRequest(Get.context!, ApiMethod.post,
        endpoint: Endpoint.deviceRegistration, body: postitem.toJson());
  }
}
