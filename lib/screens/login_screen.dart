import 'package:flutter/material.dart';
import 'package:storage/constants.dart';
import 'package:storage/screens/home_screen.dart';
import 'package:storage/widgets/custom_button.dart';
import 'package:storage/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Center(
          child: Container(
            width: 230,
            height: 100,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kLightColor, width: 2)),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: SizedBox(
                height: 70,
                width: 70,
                child: Image.asset('assets/images/auth.png'),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 2,
          width: MediaQuery.sizeOf(context).height / 2,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'اسم المستخدم',
                      style: labelStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                CustomTextFormField(
                  hintText: 'الاسم',
                  textInputType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person),
                  controller: nameController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'كلمة المرور',
                      style: labelStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                CustomTextFormField(
                  hintText: 'كلمة المرور',
                  textInputType: TextInputType.text,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.password_outlined),
                  controller: passwordController,
                ),
                CustomizedButtonWithBorder(
                  tittle: 'تسجيل الدخول',
                  isLoading: isLoading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      if (nameController.text == 'admin' &&
                          passwordController.text == 'admin') {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else {
                        await showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (context) => const AlertDialog(
                            icon:
                                Icon(Icons.error, color: Colors.red, size: 30),
                            content: Text('حدث خطأ في تسجيل الدخول',
                                style: labelStyle),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
