import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}


// get data from api as Map<String, dynamic>
Future <Map<String,dynamic>> get_data() async{

  print('hhhh');
  final http.Response response = await http.get('http://api.openweathermap.org/data/2.5/find?q=cairo,EG&appid=2584a1f3df4ceafb4138e5b16bea0970');


  if(response.statusCode == 200){
   // print (response.body);

    final Map<String,dynamic> parse = json.decode(response.body);
    //print (parse['list']);
    return  parse['list'][0]['main'] ;   // lma bn3ml parse el list b number , object b string asm el object
    //final list = json.decode(parse['list'].toString());
   // print(list['main']);

  }else{
    print('eroor');
  }
}



  class _home extends State<home>{

  Future <Map <String,dynamic>> future ;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = get_data();

  }


  
  @override
  Widget build(BuildContext context) {


  return Scaffold(

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Image.network("https://i.pinimg.com/originals/3d/1c/e3/3d1ce3fb1985505ba88e01e525a8f841.gif"),

        FutureBuilder <Map<String,dynamic>>(
            future: future,
            builder: (context,snapshot){
             if(snapshot.hasData){
               print('ok');
               return  temp_info(snapshot.data);
             }else {
               return Container();
             }
            }
        ),

      ],
    ),
  );

  }

  // show api data at the screen
  Widget temp_info(Map <String,dynamic> snap){
     return Column(

       crossAxisAlignment: CrossAxisAlignment.start,

       children: [
         SizedBox(height: 20,),
         Text(" Tempreture     : "+snap['temp'].toString()+' F'
          ,style: TextStyle(color: Colors.black,fontSize: 30),
         textAlign: TextAlign.left,),
         SizedBox(height: 20,),
         Text(" Tempreture min : "+snap['temp_min'].toString()+" F"
           ,style: TextStyle(color: Colors.black,fontSize: 30),
           textAlign: TextAlign.left,),
         SizedBox(height: 20,),
         Text(" Tempreture max : "+snap['temp_max'].toString()+' F'
           ,style: TextStyle(color: Colors.black,fontSize: 30),
           textAlign: TextAlign.left,),
         SizedBox(height: 20,),
         Text("  pressure       : "+snap['pressure'].toString()
           ,style: TextStyle(color: Colors.black,fontSize: 30),
           textAlign: TextAlign.left,),
       ],
     );
  }


  }

