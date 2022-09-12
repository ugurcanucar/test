import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/core/utils/content_keys.dart';
import 'package:terapizone/ui/controllers/controllers_user/controllers_video_therapy/controller_payment_video_therapy.dart';
import 'package:terapizone/ui/models/packages_model.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_html_content.dart';
import 'package:terapizone/ui/views/views_user/view_add_invoice.dart';
import 'package:terapizone/ui/views/views_user/view_payment.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewPaymentVideoTherapy({required PackagesModel packageModel}) {
  // ignore: unused_local_variable
  final c = Get.put(ControllerPaymentVideoTherapy(packageModel: packageModel));
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body(packageModel);
      });
}

Widget _body(PackagesModel packageModel) {
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);
  final ControllerPaymentVideoTherapy c = Get.find();

  return AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.fastOutSlowIn,
    padding: EdgeInsets.only(bottom: viewInsets.bottom),
    child: Container(
      width: double.infinity,
      color: UIColor.mercury,
      height: Get.height * .95,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: UIColor.wildSand.withOpacity(.92),
                height: 10,
                width: Get.width),
            _getAppBar(),
            //payment summary title
            _getPaymentSummaryTitle(),
            //payment summary container
            _getPaymentSummary(packageModel),
            const SizedBox(height: 20),
            //bill info title
            //_getBillTitle(),
            //bill info container
            //_getBillInfo(),
            //payment method title
            _getPaymentMethodTitle(),
            _getPaymentMethods(),
            //user agreement acceptance
            _getPaymentAggreement(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () =>
                      Get.off(() => ViewPayment(packageModel: packageModel)),
                  child: TextBasic(
                    text: UIText.paymentVideoTherapyBtn3,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: UIColor.azureRadiance,
                    underline: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            //payment button
            Obx(
              () => ButtonBasic(
                buttonText: UIText.paymentVideoTherapyBtn1,
                bgColor: c.cardStorageList.isNotEmpty && !c.busy
                    ? UIColor.azureRadiance
                    : UIColor.osloGray,
                textColor: UIColor.white,
                onTap: () => c.busy ? null : c.payment(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(UIPath.iyzico),
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar _getAppBar() {
  return AppBar(
    backgroundColor: UIColor.wildSand.withOpacity(.92),
    elevation: 0,
    leadingWidth: 65, //padding+icon width + back title
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: GetBackButton(title: UIText.back),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}

Padding _getPaymentSummaryTitle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 20),
    child: TextBasic(
      text: UIText.paymentVideoTherapySummary,
      color: UIColor.tuna.withOpacity(.6),
      fontSize: 13,
    ),
  );
}

Widget _getPaymentSummary(PackagesModel packageModel) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    margin: const EdgeInsets.only(top: 8),
    decoration: whiteDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //vide therapy
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBasic(
                    text: UIText.paymentVideoTherapy,
                    fontSize: 17,
                  ),
                  TextBasic(
                    text: '${packageModel.text}',
                    color: UIColor.tuna.withOpacity(.6),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Flexible(
              child: TextBasic(
                text: '${packageModel.price} TL',
                fontSize: 17,
              ),
            ),
          ],
        ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
        //discount
        /*  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: UIText.paymentVideoTherapyDiscount,
              fontSize: 17,
            ),
            const TextBasic(
              text: '96 TL',
              fontSize: 17,
            ),
          ],
        ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 16), */
        //Amount to be paid
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: UIText.paymentVideoTherapyTotal,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            TextBasic(
              text: '${packageModel.price!} TL',
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    ),
  );
}

// ignore: unused_element
Padding _getBillTitle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, bottom: 6),
    child: TextBasic(
      text: UIText.paymentVideoTherapyBill,
      color: UIColor.tuna.withOpacity(.6),
      fontSize: 13,
    ),
  );
}

Widget _getPaymentAggreement() {
  final ControllerPaymentVideoTherapy c = Get.find();

  return Column(
    children: [
      //preliminary Contract switch
      Obx(() => CheckboxListTile(
            value: c.checkboxValue,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => c.setCheckBox(value),
            contentPadding: EdgeInsets.zero,
            checkColor: UIColor.white,
            selectedTileColor: UIColor.azureRadiance,
            title: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: RichTextBasic(textAlign: TextAlign.left, texts: [
                TextSpan(
                  text: UIText.paymentVideoTherapyAgreement1,
                  style: TextStyle(
                    color: UIColor.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => ViewHtmlContent(
                        contentKey: ContentKey.preliminaryContract)),
                ),
                TextSpan(
                  text: UIText.paymentVideoTherapyAgreement3,
                  style: TextStyle(
                    color: UIColor.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          )),
      //distance Sales Agreement switch
      Obx(() => CheckboxListTile(
            value: c.checkboxValue2,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => c.setCheckBox2(value),
            contentPadding: EdgeInsets.zero,
            checkColor: UIColor.white,
            selectedTileColor: UIColor.azureRadiance,
            title: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: RichTextBasic(textAlign: TextAlign.left, texts: [
                TextSpan(
                    text: UIText.paymentVideoTherapyAgreement2,
                    style: TextStyle(
                      color: UIColor.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(() => ViewHtmlContent(
                          contentKey: ContentKey.distanceSalesAgreement))),
                TextSpan(
                  text: UIText.paymentVideoTherapyAgreement3,
                  style: TextStyle(
                    color: UIColor.tuna.withOpacity(.6),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          )),
      //3d secure payment switch
      Obx(() => CheckboxListTile(
            value: c.checkboxValue3,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => c.setCheckBox3(value),
            contentPadding: EdgeInsets.zero,
            checkColor: UIColor.white,
            selectedTileColor: UIColor.azureRadiance,
            title: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: RichTextBasic(textAlign: TextAlign.left, texts: [
                TextSpan(
                  text: UIText.paymentAgreementText5,
                  style: TextStyle(
                    color: UIColor.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          )),
    ],
  );
}

// ignore: unused_element
Widget _getBillInfo() {
  final ControllerPaymentVideoTherapy c = Get.find();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: whiteDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //nickname
        GestureDetector(
          onTap: () => c.setNicknameRadioButton(!c.nicknameRadioValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextBasic(
                text: UIText.paymentVideoTherapyNickname,
                fontSize: 17,
              ),
              Obx(() => SizedBox(
                    width: 24,
                    height: 24,
                    child: c.nicknameRadioValue
                        ? Icon(Icons.radio_button_checked,
                            color: UIColor.azureRadiance)
                        : Icon(Icons.radio_button_off,
                            color: UIColor.azureRadiance),
                  )),
            ],
          ),
        ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
        //add bill info
        InkWell(
          onTap: () {
            Navigator.pop(Get.context!);
            viewAddInvoice();
          },
          child: TextBasic(
            text: UIText.paymentVideoTherapyAddBillInfo,
            color: UIColor.azureRadiance,
            fontSize: 17,
          ),
        ),
      ],
    ),
  );
}

Padding _getPaymentMethodTitle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 20, bottom: 6),
    child: TextBasic(
      text: UIText.paymentVideoTherapyMethod,
      color: UIColor.tuna.withOpacity(.6),
      fontSize: 13,
    ),
  );
}

Widget _getPaymentMethods() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: whiteDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<ControllerPaymentVideoTherapy>(
          init: ControllerPaymentVideoTherapy(),
          initState: (_) {},
          builder: (c) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: c.cardStorageList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBasic(
                                  text: c.cardStorageList[index].cardBankName!,
                                  fontSize: 17,
                                  textAlign: TextAlign.left,
                                ),
                                TextBasic(
                                  text:
                                      '${c.cardStorageList[index].binNumber}••••',
                                  fontSize: 12,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          Obx(() => SizedBox(
                                width: 24,
                                height: 24,
                                child: Radio(
                                    groupValue: c.groupValue,
                                    value: index,
                                    onChanged: (value) =>
                                        c.setRadioButton(value)),
                              )),
                        ],
                      ),
                      Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
                    ],
                  );
                });
          },
        ),
        //add new card
        InkWell(
          onTap: () {
            addNewCard();
          },
          child: TextBasic(
            text: UIText.paymentVideoTherapyAddCard,
            color: UIColor.azureRadiance,
            fontSize: 17,
          ),
        ),
      ],
    ),
  );
}

Widget _getCardInfo() {
  final ControllerPaymentVideoTherapy c = Get.find();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: whiteDecoration(),
    child: Form(
      key: c.formKey,
      autovalidateMode: c.autoValidateMode,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextBasic(
                text: UIText.paymentVideoTherapyAddCard,
                color: UIColor.azureRadiance,
                fontSize: 17,
              ),
            ),
            //card holder name
            _getTextField(
              UIText.paymentCardName,
              UIText.paymentCardNameHint,
              c.cardNameController,
              c.focusCardName,
              onFieldSubmitted: (val) =>
                  FocusScope.of(Get.context!).requestFocus(c.focusCardNumber),
              validate: CardUtils.validateNotEmpty,
            ),
            const SizedBox(height: 6),
            //card number
            _getTextField(
              UIText.paymentCardNumber,
              UIText.paymentCardNumberHint,
              c.cardNumberController,
              c.focusCardNumber,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter()
              ],
              onFieldSubmitted: (val) =>
                  FocusScope.of(Get.context!).requestFocus(c.focusCardExpiry),
              validate: CardUtils.validateCardNum,
              onSaved: (value) {
                c.paymentCard.number = CardUtils.getCleanedNumber(value!);
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 6),
            //expiry date & cvc
            Row(
              children: [
                //expiry date
                Expanded(
                  child: _getTextField(
                    UIText.paymentCardExpiry,
                    UIText.paymentCardExpiryHint,
                    c.cardExpiryController,
                    c.focusCardExpiry,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardMonthInputFormatter()
                    ],
                    onFieldSubmitted: (val) => FocusScope.of(Get.context!)
                        .requestFocus(c.focusCardCvc),
                    validate: CardUtils.validateDate,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value!);
                      c.paymentCard.month = expiryDate[0];
                      c.paymentCard.year = expiryDate[1];
                    },
                  ),
                ),
                const SizedBox(width: 10),
                //cvc
                Expanded(
                  child: _getTextField(
                    UIText.paymentCardCvc,
                    UIText.paymentCardCvcHint,
                    c.cardCvcController,
                    c.focusCardCvc,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    onFieldSubmitted: (val) =>
                        FocusScope.of(Get.context!).requestFocus(FocusNode()),
                    validate: CardUtils.validateCVV,
                    onSaved: (value) {
                      c.paymentCard.cvv = int.parse(value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //add card button

            Obx(() => ButtonBasic(
                buttonText: UIText.paymentVideoTherapyBtn2,
                bgColor: !c.busy ? UIColor.azureRadiance : UIColor.osloGray,
                textColor: UIColor.white,
                onTap: () => !c.busy ? c.saveCard() : null)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

Widget _getTextField(
    String title, String hint, TextEditingController controller, FocusNode node,
    {List<TextInputFormatter>? inputFormatters,
    Function(String?)? onFieldSubmitted,
    String? Function(String?)? validate,
    Function(String?)? onChanged,
    Function(String?)? onSaved,
    TextInputType? keyboardType}) {
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
        keyboardType: keyboardType,
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

addNewCard() {
  Get.bottomSheet(
    _getCardInfo(),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
  );
}
