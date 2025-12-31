
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/errors/error_cubit.dart';
import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/core/utils/logger.dart';
import 'package:liftup/core/utils/validators.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/core/widgets/custom_textformfield.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_event.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_state.dart';
import 'package:liftup/feature/home/presentation/pages/home_layout_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(  
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
             await SessionManager.saveUserId(state.user.id!);
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeLayoutPage()),);
          } else if (state is AuthFailure) {
            context.read<ErrorCubit>().showError(state.error);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email or username",
                    style: theme.textTheme.labelLarge,
                ),
                SizedBox(height: 5.h),
                CustomTextformfield(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "example@gmail.com",
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                  validation: Validators.validateEmail,
                ),

                SizedBox(height: 20.h,),

                Text(
                  "Password",
                  style: theme.textTheme.labelLarge,
                ),
                SizedBox(height: 5.h),
                CustomTextformfield(
                  controller: _passwordController,
                  isObscureText: true,
                  hintText: "minimum 6 characters",
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                  validation: Validators.validatePassword,
                ),

                SizedBox(height: 15.h,),

                Center(
                  child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: "Forgot Password?",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppLogger.log("forgot password pressed");
                          },
                      ),
                    
                    ],
                  )
                ),
                ),

                SizedBox(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: ElevatedButton(
                    onPressed: isFormValid ? () async {
                      if(_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                            AuthLoginRequested(email, password),
                          );
                      }
                    } 
                    : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFormValid ? Colors.blue : Colors.grey,
                      disabledBackgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ), 
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp
                        ),
                    ),
                    ),
                )
              ],
            )
          ),
          );
        }
      ),
      
      


    );

  }

}