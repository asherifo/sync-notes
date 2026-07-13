
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/utils/colors_manager.dart';
import 'package:note_app/features/Auth/logic/auth_cubit.dart';
import 'package:note_app/features/Auth/presentation/screens/login_screen.dart';
import 'package:note_app/features/Home/logic/home_cubit.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../CreateNote/presentation/screens/create_note_screen.dart';
import '../widgets/note_widget.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNotes(),
      child: Scaffold(
        backgroundColor: ColorsManager.primary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              spacing: 32,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(buttonWidth: 164, txt: "Add Note", onPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => CreateNoteScreen()));
                    }),
                    AppButton(buttonWidth: 164, txt: "Logout", onPress: () {
                      context.read<AuthCubit>().logout();
                      if(context.mounted){
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context)=>LoginScreen()),
                                (route)=>false);
                      }
                    }),
                  ],
                ),
                NoteWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}