import 'package:dsw_52804/utils/base_assets.dart';
import 'package:dsw_52804/utils/base_colors.dart';
import 'package:dsw_52804/utils/base_strings.dart';
import 'package:dsw_52804/views/notes/note_view.dart';
import 'package:dsw_52804/views/register/register_view.dart';
import 'package:dsw_52804/views/widgets/basic_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../db/notes_database.dart';
import '../../utils/auth_service.dart';
import '../widgets/basic_text_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    if (isLoggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NotesPage(),
        ),
      );
    }
  }


  Future<void> _validateAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      if (email == FakeCredentials.email &&
          password == FakeCredentials.password) {
        await AuthService.saveLoginState(email);
        if (mounted) {
          NotesDatabase.instance.readAllNotes();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NotesPage(),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 62),
              Image.asset(BaseAssets.logo),
              BasicSignInText(BaseStrings.signInText),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    BasicTextFormField(
                      hintText: BaseStrings.hintTextEmail,
                      prefixIcon: BaseAssets.userIcon,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return BaseStrings.email;
                        }
                        return null;
                      },
                    ),
                    BasicTextFormField(
                      isPasswordField: true,
                      hintText: BaseStrings.hintTextPassword,
                      prefixIcon: BaseAssets.padlockIcon,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      child: _forgotPasswordText(BaseStrings.forgotPasswordText),
                      onTap: () {
                        const snackBar = SnackBar(content: Text("Doesn't work"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.lightPurpleColor,
                  ),
                  child: const Text(
                    BaseStrings.signInText,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _validateAndSubmit(context),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        BaseStrings.createAccountText,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.purpleColor,
                        ),
                      ),
                      Text(
                        BaseStrings.signUp,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.purpleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _forgotPasswordText(String text) {
  return Container(
    alignment: Alignment.centerRight,
    width: double.infinity,
    padding: const EdgeInsets.only(top: 20, bottom: 40),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: CustomColors.purpleColor,
      ),
    ),
  );
}
