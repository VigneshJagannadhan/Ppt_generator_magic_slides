import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/shared/snackbars/general_snackbar.dart';
import 'package:indian_app_guy/core/utils/app_validators.dart';
import 'package:indian_app_guy/features/Auth/presentation/providers/auth_provider.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_textform_field.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String route = '/authScreen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auth.isLogin ? 'Login' : 'Register',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 30.h),
                  if (!auth.isLogin)
                    CustomTextFormField(
                      label: "Name",
                      controller: _nameController,
                      validator: (value) => AppValidators.validateName(value),
                    ),
                  if (!auth.isLogin) SizedBox(height: 10.h),
                  CustomTextFormField(
                    label: "Email",
                    controller: _emailController,
                    validator: (value) => AppValidators.validateEmail(value),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFormField(
                    label: "Password",
                    controller: _passwordController,
                    validator: (value) {
                      return auth.isLogin
                          ? AppValidators.validateLoginPassword(value)
                          : AppValidators.validateRegistrationPassword(value);
                    },
                  ),
                  SizedBox(height: 10.h),
                  PrimaryElevatedButton(
                    isLoading: auth.isLoading,
                    label: auth.isLogin ? "Login" : "Register",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        auth.setLoading(true);
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        String name = _nameController.text.trim();
                        auth.isLogin
                            ? await auth.login(
                              context: context,
                              email: email,
                              password: password,
                            )
                            : await auth.register(
                              context: context,
                              email: email,
                              password: password,
                              data: {"name": name},
                            );
                        auth.setLoading(false);
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _formKey.currentState?.reset();
                          auth.toggleLoginMode();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            auth.isLogin
                                ? 'Do not have an account?'
                                : 'Already have an account?',
                          ),
                        ),
                      ),

                      InkWell(
                        onTap:
                            () => showGeneralSnackbar(
                              context: context,
                              errorMessage: 'Feature inprogress!',
                            ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text('Forgot Password?'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
