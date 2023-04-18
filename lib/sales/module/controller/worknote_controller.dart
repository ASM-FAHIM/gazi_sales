import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../databaseHelper/worknote_repo.dart';

class WorkNoteController extends GetxController{

  TextEditingController textController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  List<Map<String, dynamic>> workList = [];
  RxBool isLoading = false.obs;


  Future<void> getWorkLists(String tsoId) async{
    isLoading(true);
    final data = await WorkNoteRepo().getNotes(tsoId);
    workList = data;
    print('Worklist is : $workList');
    isLoading(false);
  }

  Future<void> addNotes(String tsoId, String note, String subTitle) async{
    await WorkNoteRepo().insertNote(tsoId,note, subTitle, date.value);
    getWorkLists(tsoId);
    print('--------${workList.length}');
  }

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = DateTime.now().toString().obs;
  updateDate(DateTime dateTime){
    date.value = dateTime.toString();
  }

  Future<void> updateNotes(int id, String tsoId, String updateNote, String updateNoteSubtitle) async{
    await WorkNoteRepo().updateNote(id, updateNote, updateNoteSubtitle, date.value);
    getWorkLists(tsoId);
    print('--------${workList.length}');
  }


  Future<void> deleteNotes(int id, String tsoId) async{
    await WorkNoteRepo().deleteNote(id);
    getWorkLists(tsoId);
    print('--------${workList.length}');
  }
}