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
import 'package:terapizone/ui/models/post_card_storage_model.dart';
import 'package:terapizone/ui/models/purchased_packages_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerSubscription extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getPurcahesedPackageList();
    await getCardStorageList();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<PurchasedPackageModel> _packagesList =
      <PurchasedPackageModel>[].obs;

  final RxList<CardStorageModel> _cardStorageList = <CardStorageModel>[].obs;
  final RxBool _valueRenew = false.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<PurchasedPackageModel> get packagesList => _packagesList;

  List<CardStorageModel> get cardStorageList => _cardStorageList;

  bool get valueRenew => _valueRenew.value;
  Future<void> getPurcahesedPackageList() async {
    setBusy(true);
    ResponseData<List<PurchasedPackageModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.purchasedPackages);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) _packagesList.value = response.data;
      update();
    } else {
      Utilities.showToast(response.message!);
    }
  }

  setValue(bool value) {
    _valueRenew.value = value;
  }

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

  //delete saved card
  Future<void> deleteCard(String id) async {
    setBusy(true);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.delete,
        endpoint: Endpoint.deleteCardStorage(id: id));
    setBusy(false);
    Get.back();
    if (response.success) {
      await getCardStorageList().then((value) =>
          Utilities.showDefaultDialogConfirm(
              title: UIText.textSuccess,
              content: UIText.textDeleteCardSuccess,
              onConfirm: () => Get.back()));
    } else {
      Utilities.showToast(response.message!);
    }
  }

  /* Add new Card */
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late PaymentCard _paymentCard;

  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;
  PaymentCard get paymentCard => _paymentCard;

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
}
