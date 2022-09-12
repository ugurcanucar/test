import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/services/service_payment.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_subscription.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
//import 'package:terapizone/ui/views/views_user/view_purchase_history.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewSubscription() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerSubscription());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Obx(() => c.busy ? const ActivityIndicator() : _body());
      });
}

Widget _body() {
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);
  final ControllerSubscription c = Get.find();

  return ViewBase(
    statusbarBrightness: SystemUiOverlayStyle.light,
    child: AnimatedPadding(
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
              AppBar(
                backgroundColor: UIColor.wildSand.withOpacity(.92),
                elevation: 0,
                leadingWidth: 40,
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: GetBackButton(),
                ),
                title: TextBasic(
                  text: UIText.subscriptionTitle,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
              //plan title
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 6, top: 38),
                child: TextBasic(
                  text: UIText.subscriptionPlan,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 13,
                ),
              ),
              //price info & start date & end date & auto renew
              if (c.packagesList.isNotEmpty)
                GetBuilder<ControllerSubscription>(
                  init: ControllerSubscription(),
                  initState: (_) {},
                  builder: (c) {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        width: Get.width,
                        decoration: whiteDecoration(),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            _getPriceContainer(),
                            _getLine(
                              title: UIText.subscriptionStartDate,
                              isDivider: true,
                              widget: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child: TextBasic(
                                  text: c.packagesList[0].packageStartDate !=
                                          null
                                      ? ChronosService.getDateSlash(
                                          c.packagesList[0].packageStartDate!)
                                      : '-',
                                  color: UIColor.tuna.withOpacity(.6),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            _getLine(
                              title: UIText.subscriptionEndDate,
                              isDivider: true,
                              widget: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                child: TextBasic(
                                  text: c.packagesList[0].packageEndDate != null
                                      ? ChronosService.getDateSlash(
                                          c.packagesList[0].packageEndDate!)
                                      : '-',
                                  color: UIColor.tuna.withOpacity(.6),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            /*  _getLine(
                                          title: UIText.subscriptionRenew,
                                          isDivider: true,
                                          widget: CupertinoSwitch(
                                            value: c.valueRenew,
                                            onChanged: (bool value) {
                                              c.setValue(value);
                                            },
                                          ),
                                        ), */
                          ],
                        ));
                  },
                ),
              //saved cards title
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 6, top: 38),
                child: TextBasic(
                  text: UIText.subscriptionCards,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 13,
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  width: Get.width,
                  decoration: whiteDecoration(),
                  alignment: Alignment.center,
                  child: Column(children: [
                    GetBuilder<ControllerSubscription>(
                      init: ControllerSubscription(),
                      initState: (_) {},
                      builder: (cntrl) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cntrl.cardStorageList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _getCard(
                                  '${cntrl.cardStorageList[index].cardBankName}',
                                  '${cntrl.cardStorageList[index].binNumber}••••',
                                  cntrl.cardStorageList[index].id!);
                            });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(_getCardInfo());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 11, top: 11),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextBasic(
                            text: UIText.subscriptionAddCard,
                            color: UIColor.azureRadiance,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(height: 30),
              //purchase history & edit invoice details
              /*    Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  width: Get.width,
                  decoration: whiteDecoration(),
                  alignment: Alignment.center,
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => viewPurchaseHistory(),
                      child: _getLine(
                        title: UIText.purchaseHistoryTitle,
                        isDivider: true,
                        widget: SvgPicture.asset(
                          UIPath.right,
                          width: 10,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    _getLine(
                      title: UIText.subscriptionEditInvoice,
                      widget: SvgPicture.asset(
                        UIPath.right,
                        width: 10,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ])),
           */
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _getPriceContainer() {
  final ControllerSubscription c = Get.find();

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(UIPath.chat, width: 48, height: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBasic(
                        text: c.packagesList[0].packageName!,
                        fontSize: 17,
                      ),
                      TextBasic(
                        text: c.packagesList[0].packageText!,
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: TextBasic(
              text: c.packagesList[0].packagePrice!.toString() + ' TL',
              fontSize: 17,
            ),
          ),
        ],
      ),
      Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
    ],
  );
}

Widget _getCard(String cardName, String cardNumber, String id) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.credit_card, size: 64),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(
                  text: cardName,
                  fontSize: 17,
                ),
                TextBasic(
                  text: cardNumber,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: 24,
            onPressed: () async {
              final ControllerSubscription c = Get.find();
              Utilities.showDefaultDialogConfirmCancel(
                  title: UIText.textSure,
                  content: UIText.textDeleteCardWarning,
                  onConfirm: () async {
                    await c.deleteCard(id);
                  },
                  onCancel: () => Get.back());
            },
            icon: Icon(
              Icons.close,
              color: UIColor.redOrange,
            ),
          ),
          /*  SvgPicture.asset(
            UIPath.more,
            width: 10,
            height: 24,
            fit: BoxFit.scaleDown,
          ), */
        ],
      ),
      Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
    ],
  );
}

Widget _getLine({
  required String title,
  bool? isDivider = false,
  Widget? widget,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBasic(
            text: title,
            fontSize: 17,
          ),
          if (widget != null) widget
        ],
      ),
      if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
    ],
  );
}

Widget _getCardInfo() {
  final ControllerSubscription c = Get.find();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13),
      color: UIColor.abbey,
    ),
    child: Form(
      key: c.formKey,
      autovalidateMode: c.autoValidateMode,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
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
                buttonText: UIText.subscriptionAddCard,
                bgColor: !c.busy ? UIColor.azureRadiance : UIColor.osloGray,
                textColor: UIColor.white,
                onTap: () => !c.busy ? c.saveCard() : null)),
          ],
        ),
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
