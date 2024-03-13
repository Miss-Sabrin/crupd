import 'package:crupd/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController=new TextEditingController();
  TextEditingController ageController=new TextEditingController();
  TextEditingController locationController=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Text('Employee',style: TextStyle(fontSize: 24,
          color: Colors.blue,
          fontWeight: FontWeight.bold
          ),),
          Text('Form',style: TextStyle(fontSize: 24,
          color: Colors.amber,
          fontWeight: FontWeight.bold
          ),)
        ],),
        
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,top: 20,right: 20),
        
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name',style: 
              TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24
              
              ),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: 
                TextField(
                  controller: nameController,
                  decoration: InputDecoration
                  (border: InputBorder.none,
                  hintText: 'enter name'),

                ),

              ),
              SizedBox(height: 20.0,),
               Text('Age',style: 
              TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24
              
              ),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: 
                TextField(
                  controller: ageController,
                  decoration: InputDecoration
                  (border: InputBorder.none,
                  hintText: 'enter age'),

                ),

              ),
              SizedBox(height: 20.0,),
               Text('Location',style: 
              TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24
              
              ),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: 
                TextField(
                  controller: locationController,
                  decoration: InputDecoration
                  (border: InputBorder.none,
                  hintText: 'enter location'),

                ),

              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(onPressed: () async{
                  String Id=randomAlphaNumeric(10);

                  Map<String ,dynamic>employeInfoMap={
                    "Name":nameController.text,
                    "Age":ageController.text,
                    "Location":locationController.text
                  };
                  await DatabaseMethos().addEmployeDetails(employeInfoMap, Id).then((value) {
                    Fluttertoast.showToast(
        msg: "Employee Details has been uploaded succsefullay",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

                  });
                },
                 child: Text('Add',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                 ),)),
              )
            ],
          )
          

        
      ),

    );
  }
}