import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/CreateNote/logic/create_note_cubit.dart';
import 'package:note_app/features/Home/presentation/screens/home_screen.dart';

import '../../../../core/model/note_model.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/txt_style.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_txt_field.dart';


class CreateNoteScreen extends StatelessWidget {
  final NoteModel? note;
  CreateNoteScreen({super.key, this.note});

  TextEditingController headlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    headlineController.text =note?.headline ??'';
    descriptionController.text =note?.description ??'';

    return BlocProvider(
      create: (context) => CreateNoteCubit(),
      child: Scaffold(
        backgroundColor: ColorsManager.primary,
        body: BlocConsumer<CreateNoteCubit, CreateNoteState>(
          listener: (context, state) {
            if (state is CreateNoteSuccess) {
            //  Navigator.push(
            //    context,
             //   MaterialPageRoute(builder: (context) => HomeScreen()),
              //);
            } else if (state is CreateNoteError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Error State")));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31.0,vertical: 31),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon:Icon(Icons.arrow_back_ios,color: ColorsManager.scoundry) ),
                        ],
                      ),
                      SizedBox(height: 32,),

                      Text( note==null ? "Create Your Note! " : "Update Your Note! ", style: TxtStyle.font24WhiteBold),
                      SizedBox(height: 16,),

                      CustomTextFormField(
                        label: "HeadLine",
                        hintText: "Enter Headline",
                        controller: headlineController,
                      ),
                      CustomTextFormField(
                        label: "Description",
                        hintText: "Enter Note Details",
                        controller: descriptionController,
                        validator: (a) {
                          if (headlineController.text == "") {
                            return 'Please Enter Your Description';
                          }
                          return 'Please Enter Your Description';
                        } ),
                      SizedBox(
                        height: 64,
                      ),
                      AppButton(
                        buttonWidth: 312,
                        txt:  note==null ? "Create" : "Update",
                        onPress: () {
                          if(note==null){
                            context.read<CreateNoteCubit>().createNote(
                              NoteModel(
                                headline: headlineController.text,
                                description: descriptionController.text,
                                createAt: Timestamp.now(),
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                id: "",
                              ),
                            );
                          }else{
                            context.read<CreateNoteCubit>().updateNote(
                              NoteModel(
                                id: note!.id,
                                headline: headlineController.text,
                                description: descriptionController.text,
                                createAt: Timestamp.now(),
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              ),
                            );
                          }
                          
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen(),));
                        },
                      ),
                      AppButton(
                        buttonWidth: 312,
                        txt: "Select Media",
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}