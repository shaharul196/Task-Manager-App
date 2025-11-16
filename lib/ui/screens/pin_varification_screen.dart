import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import '../../data/models/reset_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widget/centered_circular_progress_indicator.dart';
import '../widget/screen_background.dart';
import '../widget/snackbar_massage.dart';
import 'change_password.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});
  final String email;

  static const String name = '/pin-verification';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _pinVerifyOTPinProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'A 6 digits OTP has been sent to your email address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),

                  PinCodeTextField(
                    length: 6,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.green,
                      inactiveColor: Colors.grey,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEController,
                    appContext: context,
                  ),

                  SizedBox(height: 16),
                  Visibility(
                    visible: _pinVerifyOTPinProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Text('Verity'),
                    ),
                  ),
                  SizedBox(height: 32),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: " Have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _verifyOTP();
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  Future<void> _verifyOTP() async {
    _pinVerifyOTPinProgress = true;
    if(mounted) setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urlss.getVerifyOTPUrl(widget.email,_otpTEController.text,),
    );

    if(!mounted) return;

    if (response.isSuccess) {
      final String data = response.body!["data"];
      ResetModel.otp = _otpTEController.text;
      _otpTEController.clear();
      if(mounted) {
        Navigator.pushNamed(context, ChangePasswordScreen.name);
      }
    } else {
      _otpTEController.clear();
      if (mounted) {
        showSnackBarMassage(context, response.errorMassage!);
      }
    }
    _pinVerifyOTPinProgress = false;
    setState(() {});
  }

  //TODO pin verification
  // Future<void> _verifyOTP() async {
  //   _pinVerifyOTPinProgress = true;
  //   if (mounted) setState(() {});
  //
  //   NetworkResponse response = await NetworkCaller.getRequest(
  //     url: Urlss.getVerifyOTPUrl(widget.email, _otpTEController.text),
  //   );
  //
  //   if (!mounted) return;
  //
  //   _pinVerifyOTPinProgress = false;
  //   setState(() {});
  //
  //   if (response.isSuccess) {
  //     ResetModel.otp = _otpTEController.text;
  //     _otpTEController.clear(); // safe because mounted checked
  //     showSnackBarMassage(context, response.body!['data']);
  //     Navigator.pushNamed(context, ChangePasswordScreen.name);
  //   } else {
  //     _otpTEController.clear(); // safe because mounted checked
  //     showSnackBarMassage(context, response.errorMassage!);
  //   }
  // }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
