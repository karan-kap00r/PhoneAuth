import 'package:flutter/material.dart';
import 'package:flutter_fire/services/phone_auth.dart';
import 'package:flutter_fire/widgets/custom_button.dart';
import 'package:flutter_fire/widgets/custom_text_field.dart';

class OTPConfirmationPage extends StatefulWidget {
  final String phoneNo;

  const OTPConfirmationPage({Key? key, required this.phoneNo})
      : super(key: key);

  @override
  _OTPConfirmationPageState createState() => _OTPConfirmationPageState();
}

class _OTPConfirmationPageState extends State<OTPConfirmationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String phoneNo;
  String verificationIdFinal = "";
  FocusNode _blankFocusNode = FocusNode();
  late PhoneAuth phoneAuth;
  late String _otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNo = widget.phoneNo;
    phoneAuth = PhoneAuth(phoneNo: widget.phoneNo);
    phoneAuth.verifyPhone(context).whenComplete((){
      setState(() {});
    });
  }

  String? numberCountValidator(value, int requiredCount) {
    if (value.length < requiredCount || value.length > requiredCount) {
      return "Invalid";
    } else {
      _formKey.currentState?.save();
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightPiece = MediaQuery.of(context).size.height / 10;
    var widthPiece = MediaQuery.of(context).size.width / 10;
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: SafeArea(
        child: GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
        FocusScope.of(context).requestFocus(_blankFocusNode);
    },
    child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(widthPiece / 2),
          child:
              SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child: buildOTPsentText(),
            ),
            Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child: showRegisteredMobileNumber(),
            ),
            Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child: buildEnterOTPText(),
            ),
            Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child: otpInputFieldConfig(),
            ),
            Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child:CustomButton(
                  text: 'Proceed',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      phoneAuth.signInWithPhoneNumber(
                          verificationIdFinal, _otp, context);
                    }
                  }, textColor: null, buttonColor: null,
                ),
            ),
          ]),
              ),
        ),
    ),
        ),
      ),
    );
  }

  CustomTextField otpInputFieldConfig() {
    return CustomTextField(
      hintText: 'Your otp here',
      maxLength: 6,
      prefixText: null,
      onChanged: ((value) {
        _otp = value;
      }),
      inputType: TextInputType.number,
      onSaved: ((value) {
        _otp = value!;
      }),
      validator: (value) => numberCountValidator(value, 6),
      maxLines: null,
      initialValue: null,
    );
  }

  buildOTPsentText() {
    return Text(
      'Verify the otp sent to this number',
      style: TextStyle(fontSize: 22),
    );
  }

  showRegisteredMobileNumber() {
    return Text(widget.phoneNo,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22));
  }

  buildEnterOTPText() {
    return Text('Enter OTP');
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    // startTimer();
  }
}

