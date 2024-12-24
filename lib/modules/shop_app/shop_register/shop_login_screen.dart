import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/shop_app/cubit/login/LoginCubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/modules/shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/models/response_model.dart';
import 'package:shop_app/shared/local/cache_helper.dart';

import '../../../shared/components/widget_main.dart';
import '../cubit/login/login_state.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.responseModel.status!) {
              showToastMessage(
                  message: state.responseModel.message.toString(),
                  state: ToastState.success);
              CacheHelper.saveData(key: 'token',value: state.responseModel.data!.token);
              print('token is ${state.responseModel.data!.token}');
              Future.delayed(Duration(seconds: 1));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopLayout()));
            } else {
              showToastMessage(
                  message: state.responseModel.message.toString(),
                  state: ToastState.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'login now to browse our hot offers ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter email !';
                        }
                      },
                      label: 'Email ',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    defaultFormFiled(
                        controller: passwordController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          //  return 'please enter password !';
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        isPressed:
                            LoginCubit.get(context).changePasswordVisibility,
                        label: 'password',
                        prefix: Icons.lock,
                        suffix: LoginCubit.get(context).suffixIcon),
                    SizedBox(
                      height: 16,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadState,
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          color: Colors.blueAccent,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not Have account ?'),
                        defaultTextButton(function: () {}, text: 'SignUp')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
