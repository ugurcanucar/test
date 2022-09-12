import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/card_storage_model.dart';
import 'package:terapizone/ui/models/packages_model.dart';
import 'package:terapizone/ui/models/post_card_storage_model.dart';
import 'package:terapizone/ui/models/post_package_id_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_html_payment.dart';
import 'package:terapizone/ui/views/views_user/view_dashboard.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_payment_success_video_therapy.dart';

class ControllerPaymentVideoTherapy extends BaseController {
  final PackagesModel? packageModel;
  ControllerPaymentVideoTherapy({this.packageModel});
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getCardStorageList();
  }

  //controllers
  final TextEditingController _cardNameController =
      TextEditingController(/* text: 'betl nur' */);
  TextEditingController get cardNameController => _cardNameController;

  final TextEditingController _cardNumberController =
      TextEditingController(/* text: '5309 0500 4774 9983' */);
  TextEditingController get cardNumberController => _cardNumberController;

  final TextEditingController _cardExpiryController =
      TextEditingController(/* text: '12/23' */);
  TextEditingController get cardExpiryController => _cardExpiryController;

  final TextEditingController _cardCvcController =
      TextEditingController(/* text: '123' */);
  TextEditingController get cardCvcController => _cardCvcController;
  final focusCardName = FocusNode();
  final focusCardNumber = FocusNode();
  final focusCardExpiry = FocusNode();
  final focusCardCvc = FocusNode();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool _nicknameRadioValue = false.obs;

  late PaymentCard _paymentCard;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final RxBool _checkboxValue = false.obs; // preliminary Contract switch
  final RxBool _checkboxValue2 = false.obs; //distance Sales Agreement switch
  final RxBool _checkboxValue3 = false.obs; //3d secure payment switch

  final RxInt _groupValue = 0.obs;
  final RxList<CardStorageModel> _cardStorageList = <CardStorageModel>[].obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  bool get nicknameRadioValue => _nicknameRadioValue.value;
  PaymentCard get paymentCard => _paymentCard;
  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;
  bool get checkboxValue => _checkboxValue.value;
  bool get checkboxValue2 => _checkboxValue2.value;
  bool get checkboxValue3 => _checkboxValue3.value;

  int get groupValue => _groupValue.value;
  List<CardStorageModel> get cardStorageList => _cardStorageList;

  //get saved cards
  Future<void> getCardStorageList() async {
    setBusy(true);
    ResponseData<CardStorageModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.allCardStorage);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) _cardStorageList.value = response.data;
      update();
    } else {
      Utilities.showToast(response.message!);
    }
  }

//save card
  void saveCard() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      PostCardStorageModel postitem = PostCardStorageModel(
        cardAlias: _cardCvcController.text,
        cardHoldername: _cardNameController.text,
        cardNumber: _cardNumberController.text.replaceAll(' ', ''),
        expireMonth: _cardExpiryController.text.split('/').first,
        expireYear: '20' + _cardExpiryController.text.split('/').last,
      );
      setBusy(true);

      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint: Endpoint.postCardStorage, body: postitem.toJson());
      setBusy(false);

      if (response.success) {
        await getCardStorageList().then((value) => Get.back());
        _cardCvcController.clear();
        _cardNameController.clear();
        _cardNumberController.clear();
        cardExpiryController.clear();
      } else {
        Utilities.showToast(response.message!);
      }
    }
  }

  void payment() async {
    if (!_checkboxValue.value) {
      Utilities.showToast(UIText.toastPreliminaryContract);
      return;
    } else if (!_checkboxValue2.value) {
      Utilities.showToast(UIText.toastDistanceSalesAgreement);
      return;
    } else if (_cardStorageList.isEmpty) {
      Utilities.showToast(UIText.toastPaymentAddCard);
      return;
    } else {
      //3d secure payment
      if (_checkboxValue3.value) {
        await payWith3D();
      }
      //not 3d secure payment
      else if (!_checkboxValue3.value) {
        await regularPay();
      }
    }
  }

  //pay with saved card (not 3d)
  Future<void> regularPay() async {
    PostPackageIdModel postitem =
        PostPackageIdModel(packageId: packageModel!.id);
    setBusy(true);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.payWithCard(
            cardId: _cardStorageList[_groupValue.value].id!),
        body: postitem.toJson());
    setBusy(false);

    if (response.success) {
      Get.offAll(() => const ViewDashboard());
      viewPaymentSuccessVideoTherapy(packageModel!.numberOfVideos.toString());
    } else {
      Utilities.showToast(response.message ?? '');
    }
  }

  //pay 3d secure with saved card
  Future<void> payWith3D() async {
    PostPackageIdModel postitem =
        PostPackageIdModel(packageId: packageModel!.id);
    setBusy(true);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.payWith3DRegisteredCard(
            cardId: _cardStorageList[_groupValue.value].id!),
        body: postitem.toJson());
    setBusy(false);

    if (response.success && response.message != null) {
      Get.off(() => ViewHtmlPayment(html: response.message!));
    } else {
      Utilities.showToast(response.message ?? '');
    }
  }

  setNicknameRadioButton(value) {
    _nicknameRadioValue.value = value;
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

  setRadioButton(ind) {
    _groupValue.value = ind;
  }
}
