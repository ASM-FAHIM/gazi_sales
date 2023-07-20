import 'package:get/get.dart';
import '../../sales/databaseHelper/login_repo.dart';
import '../view/production_processing_screen.dart';

class ProcessController extends GetxController{
  RxBool isDone = false.obs;
  List userWiseBusiness = [];

  Future<void> getBusinessList() async {
    try {
      isDone(true);
      userWiseBusiness = await LoginRepo().getFromBusinessTable();
      isDone(false);
      print('------user wise business List : $userWiseBusiness');
    } catch (error) {
      isDone(false);
      print('There are some issue: $error');
    }
  }

  //change image by business
  changeImage(String statusdemo) {
    switch (statusdemo) {
      case "Gazi Group":
        return "assets/images/logo/100000.png";

      case "GAZI SINKS":
        return "assets/images/logo/400060.png";

      case "GAZI DOORS":
        return "assets/images/logo/400070.png";

      case "GAZI TANKS":
        return "assets/images/logo/400080.png";

      case "GAZI PIPES":
        return "assets/images/logo/400090.png";

      default:
        return "assets/images/logo/100000.png";
    }
  }

  RxString pZid = ''.obs;
  void saveInfo(String zid){
    pZid.value = zid;
    Get.to(()=> ProductionProcessScreen());
  }
}