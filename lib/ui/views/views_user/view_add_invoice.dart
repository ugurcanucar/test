import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_add_invoice.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewAddInvoice() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerAddInvoice());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body();
      });
}

Widget _body() {
  final ControllerAddInvoice c = Get.find();

  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);

  return AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.fastOutSlowIn,
    padding: EdgeInsets.only(bottom: viewInsets.bottom),
    child: Container(
      width: double.infinity,
      color: UIColor.mercury,
      height: Get.height * .95,
      child: SingleChildScrollView(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: UIColor.wildSand.withOpacity(.92),
                    height: 10,
                    width: Get.width),
                AppBar(
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  elevation: 0,
                  leadingWidth: 90, //padding+icon width + cancel title
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => c.groupValue == 0
                          ? c.savePersonalInvoice()
                          : c.saveCompanyInvoice(),
                      child: TextBasic(
                        text: UIText.save,
                        color: UIColor.azureRadiance,
                        fontSize: 17,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  leading: GetBackButton(title: UIText.addInvoiceCancel),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),

                const SizedBox(height: 30),

                //radio buttons
                _getRadioButtons(),
                c.groupValue == 0
                    ? _getPersonalInvoice()
                    : _getCompanyInvoice(),
              ],
            )),
      ),
    ),
  );
}

Widget _getRadioButtons() {
  final ControllerAddInvoice c = Get.find();
  return Container(
    decoration: whiteDecoration(),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: UIText.addInvoicePerson,
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
            Obx(() => SizedBox(
                  width: 24,
                  height: 24,
                  child: Radio(
                      groupValue: c.groupValue,
                      value: 0,
                      onChanged: (value) => c.setRadioButton(value)),
                )),
          ],
        ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: UIText.addInvoiceCompany,
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
            Obx(() => SizedBox(
                  width: 24,
                  height: 24,
                  child: Radio(
                      groupValue: c.groupValue,
                      value: 1,
                      onChanged: (value) => c.setRadioButton(value)),
                )),
          ],
        ),
      ],
    ),
  );
}

Widget _getPersonalInvoice() {
  final ControllerAddInvoice c = Get.find();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //bill info title
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 30),
        child: TextBasic(
          text: UIText.addInvoiceInfo,
          color: UIColor.tuna.withOpacity(.6),
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 6),
      //invoice form
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: whiteDecoration(),
        child: Form(
            key: c.pFormKey,
            autovalidateMode: c.pautoValidateMode,
            child: Column(
              children: [
                const SizedBox(height: 10),
                _getTextField(
                  UIText.addInvoiceNameSurname,
                  UIText.addInvoiceNameSurnameHint,
                  c.pNameSurnameController,
                  c.pFocusNameSurname,
                  onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                      .requestFocus(c.pFocusIdentity),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                _getTextField(
                  UIText.addInvoiceIdentity,
                  UIText.addInvoiceIdentityHint,
                  c.pIdentityController,
                  c.pFocusIdentity,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(Get.context!).requestFocus(c.pFocusAddress),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                _getTextField(
                  UIText.addInvoiceAddress,
                  UIText.addInvoiceAddressHint,
                  c.pAddressController,
                  c.pFocusAddress,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(Get.context!).requestFocus(c.pFocusCity),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _getTextField(
                        UIText.addInvoiceCity,
                        UIText.addInvoiceCityHint,
                        c.pCityController,
                        c.pFocusCity,
                        onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                            .requestFocus(c.pFocusDistrict),
                        validate: CardUtils.validateNotEmpty,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _getTextField(
                        UIText.addInvoiceDistrict,
                        UIText.addInvoiceDistrictHint,
                        c.pDistrictController,
                        c.pFocusDistrict,
                        onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                            .requestFocus(FocusNode()),
                        validate: CardUtils.validateNotEmpty,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),

      const SizedBox(height: 6),
    ],
  );
}

Widget _getCompanyInvoice() {
  final ControllerAddInvoice c = Get.find();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //bill info title
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 30),
        child: TextBasic(
          text: UIText.addInvoiceInfo,
          color: UIColor.tuna.withOpacity(.6),
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 6),
      //invoice form
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: whiteDecoration(),
        child: Form(
            key: c.cFormKey,
            autovalidateMode: c.cAutoValidateMode,
            child: Column(
              children: [
                const SizedBox(height: 10),
                _getTextField(
                  UIText.addInvoiceTitleWork,
                  UIText.addInvoiceTitleWorkHint,
                  c.cTitleController,
                  c.cFocusTitle,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(Get.context!).requestFocus(c.cFocusTaxNo),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                _getTextField(
                  UIText.addInvoiceTaxNo,
                  UIText.addInvoiceTaxNoHint,
                  c.cTaxNoController,
                  c.cFocusTaxNo,
                  onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                      .requestFocus(c.cFocusTaxAdministration),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                _getTextField(
                  UIText.addInvoiceTaxAdministration,
                  UIText.addInvoiceTaxAdministrationHint,
                  c.cTaxAdministrationController,
                  c.cFocusTaxAdministration,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(Get.context!).requestFocus(c.cFocusAddress),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                _getTextField(
                  UIText.addInvoiceAddress,
                  UIText.addInvoiceAddressHint,
                  c.cAddressController,
                  c.cFocusAddress,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(Get.context!).requestFocus(c.cFocusCity),
                  validate: CardUtils.validateNotEmpty,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _getTextField(
                        UIText.addInvoiceCity,
                        UIText.addInvoiceCityHint,
                        c.ccityController,
                        c.cFocusCity,
                        onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                            .requestFocus(c.cFocusDistrict),
                        validate: CardUtils.validateNotEmpty,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _getTextField(
                        UIText.addInvoiceDistrict,
                        UIText.addInvoiceDistrictHint,
                        c.cDistrictController,
                        c.cFocusDistrict,
                        onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                            .requestFocus(FocusNode()),
                        validate: CardUtils.validateNotEmpty,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),

      const SizedBox(height: 6),
    ],
  );
}

Widget _getTextField(
    String title, String hint, TextEditingController controller, FocusNode node,
    {List<TextInputFormatter>? inputFormatters,
    Function(String?)? onFieldSubmitted,
    String? Function(String?)? validate,
    Function(String?)? onChanged,
    Function(String?)? onSaved}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextBasic(
        text: title,
        fontSize: 17,
      ),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        focusNode: node,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        onSaved: onSaved,
        cursorColor: UIColor.azureRadiance,
        validator: validate,
        style: TextStyle(fontSize: 13, color: UIColor.black),
        decoration: InputDecoration(
          hintText: hint,
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
    ],
  );
}
