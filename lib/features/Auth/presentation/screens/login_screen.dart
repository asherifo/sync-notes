import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/utils/colors_manager.dart';
import 'package:note_app/core/utils/txt_style.dart';
import 'package:note_app/core/widgets/app_button.dart';
import 'package:note_app/core/widgets/app_txt_field.dart';
import 'package:note_app/features/Auth/logic/auth_cubit.dart';
import 'package:note_app/features/Auth/presentation/screens/sign_up_screen.dart';
import 'package:note_app/features/Home/presentation/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

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
          Text('Login Successfully',style: TxtStyle.scoundryStyle,),
          Icon(Icons.check_circle,color: ColorsManager.scoundry,)

        ],
      )
      )
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }else if(state is AuthError){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(state.errorMsg,maxLines: 5,style: TxtStyle.scoundryStyle,),
          Icon(Icons.error,color: ColorsManager.scoundry,),

        ],
      )));

    }
  },
  builder: (context, state) {
    return Scaffold(
        backgroundColor: ColorsManager.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  SizedBox(height: 32,),

                  Center(child: Text('Hi, Welcome Back! ',style: TxtStyle.font24WhiteBold,)),
                  SizedBox(height: 128,),
                  CustomTextFormField(label: 'Email', hintText: 'example@gmail.com',controller: emailController,keyboardType: TextInputType.emailAddress,),
                  CustomTextFormField(label: 'Password', hintText: 'Enter Your Password',controller: passController,keyboardType: TextInputType.name,obscureText: true,),

                  AppButton(buttonWidth: 312, txt: (state is AuthLoading) ?'Loading....!': 'Login', onPress: (){
                    context.read<AuthCubit>().login(userEmail: emailController.text, userPass:passController.text);
                  }),

                  SizedBox(height: 16,),

                  AppButton(buttonWidth: 312, txt:(state is AuthLoading)? 'Loading....!':'Sign in With Google', onPress: ()async{
                   await context.read<AuthCubit>().loginWithGoogle();
                   print('SIIIIIIIIIIIIIIIIIIIIIIII');
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  }),

                  SizedBox(height: 70,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Don’t have an account ?',style: TxtStyle.scoundryStyle,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          },
                          child: Text('Sign Up',style: TxtStyle.scoundryStyle,),
                        ),

                    ],),
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
