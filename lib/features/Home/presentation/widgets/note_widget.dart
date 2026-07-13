
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/CreateNote/presentation/screens/create_note_screen.dart';
import 'package:note_app/features/Home/logic/home_cubit.dart';

import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/txt_style.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        } else if (state is HomeSuccess) {
          return SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: state.note.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNoteScreen(note: state.note[index],)));
                    },
                    child: Container(
                      width: 390,
                      height:80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsManager.foreground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.note[index].headline,
                                  style: TxtStyle.noteTxtStyle,


                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<HomeCubit>().deleteNote(state.note[index].id!);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: ColorsManager.scoundry,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(

                                  child: Text(
                                    state.note[index].description,
                                    style: TxtStyle.noteTxtStyle,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${state.note[index].createAt.toDate().hour}:${state.note[index].createAt.toDate().minute}",
                                  style: TxtStyle.noteTxtStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.errorMsg, style: TxtStyle.primaryStyle));
        }
        return SizedBox();
      },
    );
  }
}