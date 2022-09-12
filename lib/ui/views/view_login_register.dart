import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/extensions.dart';
import 'package:terapizone/core/utils/content_keys.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/controllers/message_signal_controller.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uifont.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_html_content.dart';
import 'package:terapizone/ui/views/views_ForgotPswrd/view_forgot_password.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

class ViewLoginRegister extends StatelessWidget {
  const ViewLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerLoginRegister c = Get.find();

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.light,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.mercury,
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : DefaultTabController(
                length: 2,
                initialIndex: c.tabIndex,
                child: Scaffold(
                  key: c.scaffoldKey,
                  appBar: AppBar(
                    backgroundColor: UIColor.mercury,
                    elevation: 0,
                    leadingWidth: 40,
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: GetBackButton(),
                    ),
                    centerTitle: true,
                    title: Container(
                      decoration: BoxDecoration(
                        color: UIColor.jumbo.withOpacity(.12),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TabBar(
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: UIColor.white),
                          indicatorPadding: const EdgeInsets.all(0),
                          labelColor: UIColor.black,
                          labelStyle: TextStyle(
                              fontSize: 13, fontFamily: UIFont.regular),
                          unselectedLabelColor: UIColor.black,
                          unselectedLabelStyle: const TextStyle(fontSize: 13),
                          onTap: (value) => c.setTabIndex(value),
                          tabs: <Widget>[
                            getTab(UIText.loginRegisterTab1),
                            getTab(UIText.loginRegisterTab2),
                          ],
                        ),
                      ),
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                  ),
                  backgroundColor: UIColor.mercury,
                  body: getBody(),
                ),
              )),
      ),
    );
  }

  Widget getTab(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Tab(
        text: title,
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TabBarView(children: [
        bodyLogin(),
        bodyRegister(),
      ]),
    );
  }

  Widget bodyLogin() {
    final ControllerLoginRegister c = Get.find();

    return Container(
      color: UIColor.mercury,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            //login title
            TextBasic(
              text: UIText.loginRegisterTitle1,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 20),
            /*   ButtonBasic(
              buttonText: UIText.loginWithFacebook,
              bgColor: UIColor.sanMarino,
              textColor: UIColor.white,
              prefixIcon: SvgPicture.asset(UIPath.facebook),
              onTap: null,
            ),
            const SizedBox(height: 10),

            ButtonBasic(
              buttonText: UIText.loginWithGoogle,
              bgColor: UIColor.cinnabar,
              textColor: UIColor.white,
              prefixIcon: SvgPicture.asset(UIPath.google),
              onTap: null,
            ),
            const SizedBox(height: 10),

            ButtonBasic(
              buttonText: UIText.loginWithApple,
              bgColor: UIColor.black,
              textColor: UIColor.white,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(UIPath.apple),
              ),
              onTap: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextBasic(
                text: UIText.loginRegisterOr,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ), */
            //login form
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: UIColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Form(
                    key: c.loginKeyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //email textfield
                        getTextField(
                            title: UIText.loginEmail,
                            hint: UIText.loginHintEmail,
                            controller: c.loginEmailController,
                            focusNode: c.focusLoginEmail,
                            obscureText: false,
                            requestFocus: c.focusLoginPassword),
                        Divider(color: UIColor.tuna.withOpacity(.38)),
                        //password textfield
                        getTextField(
                            title: UIText.loginPswrd,
                            hint: UIText.loginHintPswrd,
                            controller: c.loginPasswordController,
                            focusNode: c.focusLoginPassword,
                            requestFocus: FocusNode(),
                            obscureText: c.loginObscureText,
                            suffixIcon: TextButton(
                                onPressed: () =>
                                    c.setObscureTextLogin(!c.loginObscureText),
                                child: SvgPicture.asset(UIPath.eye))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //
                ButtonBorder(
                  buttonText: UIText.loginButton1,
                  borderColor: UIColor.transparent,
                  textColor: UIColor.azureRadiance,
                  onTap: () => Get.to(() => const ViewForgotPassword()),
                ),
                const SizedBox(height: 16),
                //login button
                ButtonBorder(
                  buttonText: "Giriş",
                  borderColor: UIColor.azureRadiance,
                  textColor: UIColor.azureRadiance,
                  onTap: () => c.login(c.loginEmailController.text,
                      c.loginPasswordController.text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyRegister() {
    final ControllerLoginRegister c = Get.find();

    return Container(
      color: UIColor.mercury,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            //register title
            TextBasic(
              text: UIText.loginRegisterTitle2,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 20),
            /*   ButtonBasic(
              buttonText: UIText.registerWithFacebook,
              bgColor: UIColor.sanMarino,
              textColor: UIColor.white,
              prefixIcon: SvgPicture.asset(UIPath.facebook),
              onTap: null,
            ),
            const SizedBox(height: 10),

            ButtonBasic(
              buttonText: UIText.registerWithGoogle,
              bgColor: UIColor.cinnabar,
              textColor: UIColor.white,
              prefixIcon: SvgPicture.asset(UIPath.google),
              onTap: null,
            ),
            const SizedBox(height: 10),

            ButtonBasic(
              buttonText: UIText.registerWithApple,
              bgColor: UIColor.black,
              textColor: UIColor.white,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(UIPath.apple),
              ),
              onTap: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextBasic(
                text: UIText.loginRegisterOr,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ), */
            //register form
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: UIColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Form(
                    key: c.registerKeyForm,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //nickname textfield
                          getTextField(
                            title: UIText.registerNickname,
                            hint: UIText.registerHintNickname,
                            controller: c.registerNicknameController,
                            focusNode: c.focusRegisterNickname,
                            obscureText: false,
                            requestFocus: c.focusRegisterPhone,
                          ),
                          Divider(color: UIColor.tuna.withOpacity(.38)),
                          //phone textfield
                          getTextField(
                            title: UIText.registerPhone,
                            hint: UIText.registerHintPhone,
                            controller: c.registerPhoneController,
                            focusNode: c.focusRegisterPhone,
                            obscureText: false,
                            requestFocus: c.focusRegisterEmail,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [PhoneNumberFormatter()],
                          ),
                          Divider(color: UIColor.tuna.withOpacity(.38)),
                          //email textfield
                          getTextField(
                            title: UIText.registerEmail,
                            hint: UIText.registerHintEmail,
                            controller: c.registerEmailController,
                            focusNode: c.focusRegisterEmail,
                            obscureText: false,
                            requestFocus: c.focusRegisterPassword,
                            isEmail: true,
                          ),
                          Divider(color: UIColor.tuna.withOpacity(.38)),
                          //password textfield
                          getTextField(
                            title: UIText.registerPswrd,
                            hint: UIText.registerHintPswrd,
                            controller: c.registerPasswordController,
                            focusNode: c.focusRegisterPassword,
                            requestFocus: FocusNode(),
                            obscureText: c.registerObscureText,
                            suffixIcon: TextButton(
                              onPressed: () => c.setObscureTextRegister(
                                  !c.registerObscureText),
                              child: SvgPicture.asset(UIPath.eye),
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(height: 32),
                //register button
                ButtonBorder(
                    buttonText: UIText.registerButton1,
                    borderColor: UIColor.azureRadiance,
                    textColor: UIColor.azureRadiance,
                    onTap: () => c.registerFormApprove()),
                const SizedBox(height: 20),
                TextBasic(
                  text: UIText.registerButton2_1 + '\n',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: UIColor.tuna.withOpacity(.6),
                ),
                // user agreement

                CheckboxListTile(
                  value: c.checkboxUserAgreement,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) => c.setCheckBoxUserAgreement(value),
                  contentPadding: EdgeInsets.zero,
                  checkColor: UIColor.white,
                  selectedTileColor: UIColor.azureRadiance,
                  title: RichTextBasic(textAlign: TextAlign.left, texts: [
                    TextSpan(
                        text: UIText.registerButton2_2,
                        style: TextStyle(
                          color: UIColor.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => ViewHtmlContent(
                              contentKey: ContentKey.userAgreement))),
                    TextSpan(
                      text: UIText.registerButton2_4,
                      style: TextStyle(
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
                // personal data protection policy
                CheckboxListTile(
                  value: c.checkboxKVKK,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) => c.setCheckboxKVKK(value),
                  contentPadding: EdgeInsets.zero,
                  checkColor: UIColor.white,
                  selectedTileColor: UIColor.azureRadiance,
                  title: RichTextBasic(textAlign: TextAlign.left, texts: [
                    TextSpan(
                        text: UIText.registerButton2_3,
                        style: TextStyle(
                          color: UIColor.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() =>
                              ViewHtmlContent(contentKey: ContentKey.kvkk))),
                    TextSpan(
                      text: UIText.registerButton2_4,
                      style: TextStyle(
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
                //lighting text
                CheckboxListTile(
                  value: c.checkboxLightning,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) => c.setCheckboxLightning(value),
                  contentPadding: EdgeInsets.zero,
                  checkColor: UIColor.white,
                  selectedTileColor: UIColor.azureRadiance,
                  title: RichTextBasic(textAlign: TextAlign.left, texts: [
                    TextSpan(
                        text: UIText.registerButton3_1,
                        style: TextStyle(
                          color: UIColor.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => ViewHtmlContent(
                              contentKey: ContentKey.clarificationText))),
                    TextSpan(
                      text: UIText.registerButton2_4,
                      style: TextStyle(
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      {required String title,
      String? hint,
      required TextEditingController controller,
      required FocusNode focusNode,
      required FocusNode requestFocus,
      required bool obscureText,
      Widget? suffixIcon,
      bool? enabled,
      bool isPicker = false,
      bool isEmail = false,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title
          Expanded(
            flex: 1,
            child: TextBasic(
              text: title,
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
          ),
          //textformfield
          Expanded(
            flex: 3,
            child: LoginTextField(
              enabled: enabled,
              controller: controller,
              focusNode: focusNode,
              requestFocus: requestFocus,
              obscureText: obscureText,
              hint: hint,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: (t) {
                if (t != null) {
                  if (t.isEmpty) {
                    return UIText.loginValidator;
                  } else if (isEmail && t.isNotEmpty && !t.isValidEmail()) {
                    return UIText.registerEmailValidator;
                  } else {
                    return null;
                  }
                }
              },
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
