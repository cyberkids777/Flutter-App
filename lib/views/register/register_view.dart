import 'package:dsw_52804/utils/base_assets.dart';
import 'package:dsw_52804/utils/base_colors.dart';
import 'package:dsw_52804/utils/base_strings.dart';
import 'package:dsw_52804/views/login/login_view.dart';
import 'package:dsw_52804/views/widgets/basic_text_form_field.dart';
import 'package:dsw_52804/views/widgets/basic_text_styles.dart';
import 'package:flutter/material.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Image.asset(BaseAssets.elipse)
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: CustomColors.purpleColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              BasicSignInText(BaseStrings.signUp),
              Form(
                child: Column(
                  children: [
                    BasicTextFormField(
                      controller: _nameController,
                      hintText: BaseStrings.fullName,
                      prefixIcon: BaseAssets.userIcon,
                    ),
                    BasicTextFormField(
                      controller: _emailController,
                      hintText: BaseStrings.hintTextEmail,
                      prefixIcon: BaseAssets.emailIcon,
                    ),
                     BasicTextFormField(
                      controller: _passwordController,
                      hintText: BaseStrings.hintTextPassword,
                      prefixIcon: BaseAssets.padlockIcon,
                    ),
                     BasicTextFormField(
                      controller: _passwordController,
                      hintText: BaseStrings.confirmPassword,
                      prefixIcon: BaseAssets.padlockIcon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.lightPurpleColor,
                          ),
                          child: const Text(
                            BaseStrings.signUp,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 140),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              BaseStrings.haveAccount,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomColors.purpleColor,
                              ),
                            ),
                            Text(
                              BaseStrings.signInText,
                              style:  TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
