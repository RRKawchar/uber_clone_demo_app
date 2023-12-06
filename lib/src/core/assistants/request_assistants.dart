import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistants{

  static Future<dynamic> receiveResponse(String url)async{


    http.Response httpResponse=await http.get(Uri.parse(url));

    try{
      if(httpResponse.statusCode==200){
        String responseData=httpResponse.body;

        var decodeResponseData=jsonDecode(responseData);

        return decodeResponseData;
      }else{

        return "Error Occurred !Failed. No Response.";
      }

    }catch(e){
      return "Error Occurred !Failed. No Response.";
    }
  }


}