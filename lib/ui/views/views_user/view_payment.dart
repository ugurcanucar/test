import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/core/utils/content_keys.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_payment.dart';
import 'package:terapizone/ui/models/packages_model.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_html_content.dart';
import 'package:terapizone/ui/views/views_user/view_add_invoice.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewPayment extends StatelessWidget {
  final PackagesModel packageModel;
  const ViewPayment({Key? key, required this.packageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerPayment(packageId: packageModel.id!));

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.light,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand.withOpacity(.92),
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : Scaffold(
                key: c.scaffoldKey,
                backgroundColor: UIColor.wildSand.withOpacity(.92),
                appBar: AppBar(
                  backgroundColor: UIColor.wildSand,
                  elevation: 0,
                  leadingWidth: 65, //padding+icon width + back title
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  leading: GetBackButton(title: UIText.back),
                  title: TextBasic(
                    text: UIText.terapizone,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerPayment c = Get.find();

    return Container(
      width: double.infinity,
      color: UIColor.wildSand,
      height: Get.height * .95,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
            //payment summary title
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: TextBasic(
                text: UIText.paymentSummary,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //payment summary container
            _getPaymentSummary(),
            /* _getCoupon(),
            //bill info title
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6),
              child: TextBasic(
                text: UIText.paymentBill,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),

            //bill info container
            _getBillInfo(), */
            //card info title
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, bottom: 6),
              child: TextBasic(
                text: UIText.paymentInfo,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //card info container
            _getCardInfo(),
            //user agreement acceptance
            _getPaymentAggreement(),
            const SizedBox(height: 10),
            //paymnet button
            Obx(() => ButtonBasic(
                  buttonText: UIText.paymentButton,
                  bgColor: !c.busy ? UIColor.azureRadiance : UIColor.osloGray,
                  textColor: UIColor.white,
                  onTap: () => !c.busy ? c.payment() : null,
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(UIPath.iyzico),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPaymentAggreement() {
    final ControllerPayment c = Get.find();

    return Column(
      children: [
        //preliminary Contract
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
                    text: UIText.paymentAgreementText1,
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
                    text: UIText.paymentAgreementText3,
                    style: TextStyle(
                      color: UIColor.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
              ),
            )),
        //distance Sales Agreement
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
                      text: UIText.paymentAgreementText2,
                      style: TextStyle(
                        color: UIColor.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => ViewHtmlContent(
                            contentKey: ContentKey.distanceSalesAgreement))),
                  TextSpan(
                    text: UIText.paymentAgreementText3,
                    style: TextStyle(
                      color: UIColor.tuna.withOpacity(.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
              ),
            )),
        //save my card
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
                    text: UIText.paymentAgreementText4,
                    style: TextStyle(
                      color: UIColor.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
              ),
            )),
        //3d secure payment
        Obx(() => CheckboxListTile(
              value: c.checkboxValue4,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => c.setCheckBox4(value),
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

  Widget _getPaymentSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.only(top: 8),
      decoration: whiteDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //therapy chat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBasic(
                      text: packageModel.name!,
                      fontSize: 17,
                    ),
                    TextBasic(
                      text: packageModel.text!,
                      color: UIColor.tuna.withOpacity(.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TextBasic(
                  text: '${packageModel.price!} TL',
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
                text: UIText.paymentDiscount,
                fontSize: 17,
              ),
              const TextBasic(
                text: '96 TL',
                fontSize: 17,
              ),
            ],
          ), 
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),*/
          //Amount to be paid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextBasic(
                text: UIText.paymentTotal,
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
  Widget _getCoupon() {
    final ControllerPayment c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 10, bottom: 6),
          child: TextBasic(
            text: UIText.paymentCoupon,
            color: UIColor.tuna.withOpacity(.6),
            fontSize: 13,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 20),
          width: Get.width,
          decoration: whiteDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.dialog(AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      content: Container(
                        height: Get.height / 3.5,
                        width: Get.width * .8,
                        decoration: BoxDecoration(
                          color: UIColor.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextBasic(
                                text: UIText.paymentAddCoupon,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: _getTextField(
                                  null,
                                  UIText.paymentCouponCode,
                                  c.couponController,
                                  c.focusCoupon),
                            ),
                            const Spacer(),
                            Divider(
                                color: UIColor.tuna.withOpacity(.38),
                                height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: TextBasic(
                                        text: UIText.textCancel,
                                        color: UIColor.azureRadiance,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                SizedBox(
                                  height: 44,
                                  child: VerticalDivider(
                                    color: UIColor.tuna.withOpacity(.38),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: null,
                                    child: TextBasic(
                                        text: UIText.textOK,
                                        color: UIColor.azureRadiance,
                                        fontSize: 17,
                                        textAlign: TextAlign.center),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )));
                },
                child: TextBasic(
                  text: UIText.paymentAddCoupon,
                  color: UIColor.azureRadiance,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _getBillInfo() {
    final ControllerPayment c = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: whiteDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //nickname
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => c.setRadioButton(index),
                        child: TextBasic(
                          text: UIText.paymentNickname,
                          fontSize: 17,
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: 24,
                          height: 24,
                          child: Radio(
                              groupValue: c.groupValue,
                              value: index,
                              onChanged: (value) => c.setRadioButton(value)),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
                ],
              );
            },
          ),

          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
          //add bill inof

          InkWell(
            onTap: () {
              viewAddInvoice();
            },
            child: TextBasic(
              text: UIText.paymentAddBillInfo,
              color: UIColor.azureRadiance,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCardInfo() {
    final ControllerPayment c = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: whiteDecoration(),
      child: Form(
        key: c.formKey,
        autovalidateMode: c.autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }

  Widget _getTextField(String? title, String hint,
      TextEditingController controller, FocusNode node,
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
        if (title != null)
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
}
