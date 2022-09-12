import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_payment_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_html_payment.dart';
import 'package:terapizone/ui/views/views_user/view_payment_success.dart';

class ControllerPayment extends BaseController {
  final String packageId;
  ControllerPayment({required this.packageId});

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    log(packageId);
    setBusy(false);
  }

  //controllers

  final TextEditingController _cardNameController = TextEditingController();
  TextEditingController get cardNameController => _cardNameController;

  final TextEditingController _cardNumberController = TextEditingController();
  TextEditingController get cardNumberController => _cardNumberController;

  final TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController get cardExpiryController => _cardExpiryController;

  final TextEditingController _cardCvcController = TextEditingController();
  TextEditingController get cardCvcController => _cardCvcController;
  final TextEditingController _couponController = TextEditingController();
  TextEditingController get couponController => _couponController;
  final focusCardName = FocusNode();
  final focusCardNumber = FocusNode();
  final focusCardExpiry = FocusNode();
  final focusCardCvc = FocusNode();
  final focusCoupon = FocusNode();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt _groupValue = 0.obs;
  late PaymentCard _paymentCard;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final RxBool _checkboxValue = false.obs; // preliminary Contract switch
  final RxBool _checkboxValue2 = false.obs; //distance Sales Agreement switch
  final RxBool _checkboxValue3 = false.obs; // save my card switch
  final RxBool _checkboxValue4 = false.obs; //3d secure payment switch

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get groupValue => _groupValue.value;
  PaymentCard get paymentCard => _paymentCard;
  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;
  bool get checkboxValue => _checkboxValue.value;
  bool get checkboxValue2 => _checkboxValue2.value;
  bool get checkboxValue3 => _checkboxValue3.value;
  bool get checkboxValue4 => _checkboxValue4.value;

  setRadioButton(ind) {
    _groupValue.value = ind;
  }

  setCheckBox(value) {
    _checkboxValue.value = value;
  }

  setCheckBox2(value) {
    _checkboxValue2.value = value;
  }

  setCheckBox3(value) {
    _checkboxValue3.value = value;
  }

  setCheckBox4(value) {
    _checkboxValue4.value = value;
  }

  void payment() async {
    if (!_checkboxValue.value) {
      Utilities.showToast(UIText.toastPreliminaryContract);
      return;
    } else if (!_checkboxValue2.value) {
      Utilities.showToast(UIText.toastDistanceSalesAgreement);
      return;
    } else {
      //3d secure pay
      if (_checkboxValue4.value) {
        await payWith3D();
      }
      //pay without 3d
      else {
        await regularPay();
      }
    }
  }

  //pay without 3c
  Future<void> regularPay() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      Utilities.showToast(UIText.toastRedSign);
    } else {
      PostPaymentModel postitem = PostPaymentModel(
        cardAlias: '',
        cardHoldername: _cardNameController.text,
        cardNumber: _cardNumberController.text.replaceAll(' ', ''),
        expireMonth: _cardExpiryController.text.split('/').first,
        expireYear: '20' + _cardExpiryController.text.split('/').last,
        cvc: _cardCvcController.text,
        saveCard: _checkboxValue3.value,
      );
      setBusy(true);
      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint: Endpoint.payWithoutCard(packageId: packageId),
          body: postitem.toJson());
      setBusy(false);

      if (response.success) {
        Get.offAll(() => const ViewPaymentSuccess());
      } else {
        Utilities.showToast(response.message ?? '');
      }
    }
  }

  //pay with 3d
  Future<void> payWith3D() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      Utilities.showToast(UIText.toastRedSign);
    } else {
      PostPaymentModel postitem = PostPaymentModel(
        cardAlias: '',
        cardHoldername: _cardNameController.text,
        cardNumber: _cardNumberController.text.replaceAll(' ', ''),
        expireMonth: _cardExpiryController.text.split('/').first,
        expireYear: '20' + _cardExpiryController.text.split('/').last,
        cvc: _cardCvcController.text,
        saveCard: _checkboxValue3.value,
      );
      setBusy(true);
      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint: Endpoint.payWith3D(packageId: packageId),
          body: postitem.toJson());
      setBusy(false);

      if (response.success && response.message != null) {
        Get.to(() => ViewHtmlPayment(html: response.message!));
      } else {
        Utilities.showToast(response.message ?? '');
      }
    }
  }
}
