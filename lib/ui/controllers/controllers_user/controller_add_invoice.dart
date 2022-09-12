import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerAddInvoice extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers personal
  final TextEditingController _pNameSurnameController = TextEditingController();
  TextEditingController get pNameSurnameController => _pNameSurnameController;

  final TextEditingController _pIdentityController = TextEditingController();
  TextEditingController get pIdentityController => _pIdentityController;

  final TextEditingController _pAddressController = TextEditingController();
  TextEditingController get pAddressController => _pAddressController;

  final TextEditingController _pcityController = TextEditingController();
  TextEditingController get pCityController => _pcityController;
  final TextEditingController _pDistrictController = TextEditingController();
  TextEditingController get pDistrictController => _pDistrictController;

  final pFocusNameSurname = FocusNode();
  final pFocusIdentity = FocusNode();
  final pFocusAddress = FocusNode();
  final pFocusCity = FocusNode();
  final pFocusDistrict = FocusNode();

  //controllers company
  final TextEditingController _cTitleController = TextEditingController();
  TextEditingController get cTitleController => _cTitleController;

  final TextEditingController _cTaxNoController = TextEditingController();
  TextEditingController get cTaxNoController => _cTaxNoController;

  final TextEditingController _cTaxAdministrationController =
      TextEditingController();
  TextEditingController get cTaxAdministrationController =>
      _cTaxAdministrationController;

  final TextEditingController _cAddressController = TextEditingController();
  TextEditingController get cAddressController => _cAddressController;

  final TextEditingController _ccityController = TextEditingController();
  TextEditingController get ccityController => _ccityController;

  final TextEditingController _cDistrictController = TextEditingController();
  TextEditingController get cDistrictController => _cDistrictController;

  final cFocusTitle = FocusNode();
  final cFocusTaxNo = FocusNode();
  final cFocusTaxAdministration = FocusNode();
  final cFocusAddress = FocusNode();
  final cFocusCity = FocusNode();
  final cFocusDistrict = FocusNode();
  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _pFormKey =
      GlobalKey<FormState>(); //personal form key
  final GlobalKey<FormState> _cFormKey =
      GlobalKey<FormState>(); // company form key

  AutovalidateMode _pAutoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode _cAutoValidateMode = AutovalidateMode.disabled;

  final RxInt _groupValue = 0.obs; //selected plan

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  GlobalKey get pFormKey => _pFormKey;
  GlobalKey get cFormKey => _cFormKey;

  AutovalidateMode get pautoValidateMode => _pAutoValidateMode;
  AutovalidateMode get cAutoValidateMode => _cAutoValidateMode;

  int get groupValue => _groupValue.value;

  setRadioButton(ind) {
    _groupValue.value = ind;
  }

  void savePersonalInvoice() async {
    if (!_pFormKey.currentState!.validate()) {
      _cAutoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      inspect("hata burda");

      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      log('swnw');
    }
  }

  void saveCompanyInvoice() async {
    if (!_cFormKey.currentState!.validate()) {
      _pAutoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      inspect("hata burda");

      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      log('swnw');
    }
  }
}
