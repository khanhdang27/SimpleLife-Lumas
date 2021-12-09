import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ClientPinCodeScreen extends StatefulWidget {
  dynamic arguments = Get.arguments;

  @override
  _ClientPinCodeScreenState createState() => _ClientPinCodeScreenState();
}

class _ClientPinCodeScreenState extends State<ClientPinCodeScreen> {
  ClientController controller = Get.find<ClientController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKeyOTP = GlobalKey<FormState>();
  var verificationCode = '';
  var isLoading = false;

  @override
  void initState() {
    signUp();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKeyOTP,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                    color: AppColor.blackPrimary,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: Image.asset(
                  AppAsset.authen,
                  width: 130,
                ),
              ),
              Text(
                'sendOtp'.tr + ':',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: AppColor.blackPrimary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  '(+852)' + widget.arguments['phone'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: AppFont.wBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {},
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: AppFont.wMedium,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: AppColor.pinkPrimary,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldWidth: 50,
                    fieldHeight: 50,
                    borderRadius: BorderRadius.circular(15),
                    activeColor: AppColor.pinkPrimary,
                    selectedColor: AppColor.pinkPrimary,
                    inactiveColor: AppColor.blackMain,
                  ),
                  onCompleted: (otpCode) async {
                    if (_formKeyOTP.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await _auth
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationCode, smsCode: otpCode.toString()))
                            .then((user) async => {
                                  //sign in was success
                                  if (user != null)
                                    {
                                      if (widget.arguments['signup'])
                                        {
                                          controller.signUp(
                                            name: widget.arguments['name'],
                                            username: widget.arguments['username'],
                                            email: widget.arguments['email'],
                                            phone: widget.arguments['phone'],
                                            password: widget.arguments['password'],
                                          ),
                                        }
                                      else
                                        {
                                          controller.forgotPass(
                                            phone: widget.arguments['phone'],
                                            password: widget.arguments['password'],
                                            confirm: widget.arguments['confirm'],
                                          ),
                                        },
                                      setState(() {
                                        isLoading = false;
                                      }),
                                    }
                                })
                            // ignore: return_of_invalid_type_from_catch_error
                            .catchError((error) => {
                                  Get.snackbar('otpIncorrect'.tr, 'pleaseOtp'.tr,
                                      backgroundColor: AppColor.silverMain,
                                      duration: Duration(seconds: 3)),
                                  setState(() {
                                    isLoading = false;
                                  }),
                                });
                        setState(() {
                          isLoading = true;
                        });
                      } catch (e) {
                        Get.snackbar('error'.tr, 'pleaseTryAgain'.tr,
                            backgroundColor: AppColor.silverMain, duration: Duration(seconds: 3));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    var phoneNumber = '+852' + widget.arguments['phone'];
    print(phoneNumber);

    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        //auto code complete (not manually)
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
              if (user != null)
                {
                  if (widget.arguments['signup'])
                    {
                      controller.signUp(
                        name: widget.arguments['name'],
                        username: widget.arguments['username'],
                        email: widget.arguments['email'],
                        phone: widget.arguments['phone'],
                        password: widget.arguments['password'],
                      ),
                    }
                  else
                    {
                      controller.forgotPass(
                        phone: widget.arguments['phone'],
                        password: widget.arguments['password'],
                        confirm: widget.arguments['confirm'],
                      ),
                    },
                  setState(() {
                    isLoading = false;
                  }),
                }
            });
      },
      verificationFailed: (FirebaseAuthException error) {
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Get.snackbar('otpTimeout'.tr, 'pleaseTryAgain'.tr,
        //     backgroundColor: AppColor.silverMain, duration: Duration(seconds: 3));
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );

    await verifyPhoneNumber;
  }
}
