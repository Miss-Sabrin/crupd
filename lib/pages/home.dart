
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crupd/pages/employe.dart';
import 'package:crupd/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController=new TextEditingController();
  TextEditingController ageController=new TextEditingController();
  TextEditingController locationController=new TextEditingController();
  Stream? EmployeStream;

  getontheload()async{
   EmployeStream= await DatabaseMethos().getEmployeDetails();
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getontheload();
    super.initState();
  }

  Widget allEmployeDetails(){
    return StreamBuilder(
      stream: EmployeStream, 
      builder: (context,AsyncSnapshot snapshot){
        return snapshot.hasData
        ?ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds=snapshot.data.docs[index];
            return 
             Container(
              margin: EdgeInsets.only(bottom: 20),
               child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name: "+ds[ "Name"],
                          style: TextStyle(color: Colors.blue,
                          fontSize: 20,fontWeight: FontWeight.bold),),
                                GestureDetector(
                                  onTap: (){
                                    nameController.text=ds["Name"];
                                    ageController.text=ds["Age"];
                                    locationController.text=ds["Location"]; 
                                    EditEmployeeDetails(ds["Name"]);
                                  },
                                  
                                  child: Icon(Icons.edit,color: Colors.orange,)),

                        ],
                      ),

                    Text("Age: "+ds["Age"],style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                 Text("Location: "+ds["Location"],style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),)
               
               
               
                    ],
                     
                  ),
                ),
                           ),
             );
 
          }
        )
        :Container();
        
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Employee()));
      },
      child: Icon(Icons.add),
      ),
      appBar: AppBar(
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Text('Flutter',style: TextStyle(fontSize: 24,
          color: Colors.blue,
          fontWeight: FontWeight.bold
          ),),
          Text('Firebase',style: TextStyle(fontSize: 24,
          color: Colors.amber,
          fontWeight: FontWeight.bold
          ),)
        ],),
        
      ),
      body:
       Container(
        margin:const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
        child: Column(
          children: [
            Expanded(child: allEmployeDetails()),
                    ],
        ),
       )


    );
  }
  
  Future EditEmployeeDetails(String id)=> showDialog(
    context: context, builder: (context)=>AlertDialog(
      content: Container(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
        Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel),
              
            ),
            SizedBox(width: 60.0,),
             Text('Edit',style: TextStyle(fontSize: 24,
          color: Colors.blue,
          fontWeight: FontWeight.bold
          ),),
          Text('Details',style: TextStyle(fontSize: 24,
          color: Colors.amber,
          fontWeight: FontWeight.bold
          ),)
            
          ],
        ),
        SizedBox(height: 20,),
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
                child: ElevatedButton(
                  onPressed: () async{
                    Map<String,dynamic>updateInfo={
                      "Name":nameController.text,
                      "Age":ageController.text,
                      "Location":locationController.text,
                    };
                    await DatabaseMethos().updateEmployeDetail(id, updateInfo).then((value) =>
                     Navigator.pop(context));
                  }, 
                child: Text('update')),
              )
      ],),


      ),


  ));
}