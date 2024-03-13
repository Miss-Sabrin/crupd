import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethos{

  Future addEmployeDetails(
    Map<String,dynamic> employeInfoMap,String id)async{
      return await FirebaseFirestore.instance
      .collection("Employe")
      .doc(id)
      .set(employeInfoMap);
    }

  

    //todo type of added page flutter firebase

    // Future <Stream<QuerySnapshot>> getEmployeDetails() async{
    //   return   await FirebaseFirestore.instance
    //   .collection("Employe")
    //   .snapshots();
    // }

    Future <Stream <QuerySnapshot>> getEmployeDetails()async{
      return await FirebaseFirestore.instance
      .collection("Employe")
      .snapshots();
    }

    //todo type of update

    Future updateEmployeDetail(String id,Map<String,dynamic> updateInfo)async{
      
      return await FirebaseFirestore.instance
      .collection("Employe")
      .doc(id)
      .update(updateInfo);

    }

    //todo type of delete
   
  
}