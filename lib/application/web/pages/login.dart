import 'package:dream/application/web/pages/partial/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController codeController = TextEditingController(text: "");
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const HeaderWidget(),
        const SizedBox(height: 16),
        Container(
            width: 1024,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: 240,
                height: 48,
                child: Focus(
                    child: TextField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        hintText: '请输入邮箱',
                        hintStyle: const TextStyle(fontSize: 14),
                        contentPadding: const EdgeInsets.only(left: 8, top: 4),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(240, 240, 240, 100),
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      controller: emailController,
                    ),
                    onFocusChange: (hasFocus) {
                      setState(() {
                        errorMessage = emailController.text.isNotEmpty &&
                                !isEmail(emailController.text)
                            ? "邮箱格式有误"
                            : "";
                      });
                    }),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: 160,
                height: 48,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    hintText: '请输入验证码',
                    hintStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.only(left: 8, top: 4),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(240, 240, 240, 100),
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  controller: codeController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(100, 32)),
                  onPressed: () async {
                    if (!isEmail(emailController.text)) {
                      return;
                    }
                    debugPrint(
                        "--> ${emailController.text} ${codeController.text}");
                  },
                  child: const Text(
                    "登录",
                    style: TextStyle(fontSize: 14, height: 1),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(errorMessage,
                        style: const TextStyle(color: Colors.red)))
            ]))
      ],
    );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}
