import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/utils/colors_manager.dart';
import 'package:note_app/core/utils/txt_style.dart';
import 'package:note_app/core/widgets/app_button.dart';
import 'package:note_app/core/widgets/app_txt_field.dart';
import 'package:note_app/features/Auth/logic/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:ColorsManager.foreground ,content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sign Up Successfully',style: TxtStyle.scoundryStyle,),
              Icon(Icons.check_circle,color: ColorsManager.scoundry,)

            ],
          )
          )
          );
        }else if(state is AuthError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state.errorMsg,style: TxtStyle.scoundryStyle,),
              Icon(Icons.error,color: ColorsManager.scoundry,),

            ],
          )));

        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 16,
                  children: [
                    SizedBox(height: 32,),
            
                    Center(child: Text('Create New Account',style: TxtStyle.font24WhiteBold,)),
                    SizedBox(height: 128,),
                    CustomTextFormField(label: 'Email', hintText: 'example@gmail.com',controller: emailController,keyboardType: TextInputType.emailAddress,),
                    CustomTextFormField(label: 'Password', hintText: 'Enter Your Password',controller: passController,keyboardType: TextInputType.name,obscureText: true,),
            
                    AppButton(buttonWidth: 312, txt: (state is AuthLoading) ?'Loading....!': 'Sign up', onPress: (){
                      context.read<AuthCubit>().signUp(userEmail: emailController.text, userPass:passController.text);
                    }),
            
            
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
