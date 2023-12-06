import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone_demo/src/core/assistants/request_assistants.dart';
import 'package:uber_clone_demo/src/core/globle/global.dart';
import 'package:uber_clone_demo/src/core/keys/map_keys.dart';
import 'package:uber_clone_demo/src/features/auth/model/user_model.dart';
import 'package:uber_clone_demo/src/features/main/model/directions.dart';

class AssistantsMethods{

static void readCurrentUserOnlineInfo()async{

currentUser=firebaseAuth.currentUser;
DatabaseReference userRef=FirebaseDatabase.instance.ref().child('user').child(currentUser!.uid);

userRef.once().then((snap){
  if(snap.snapshot.value!=null){
    userModelCurrentInfo=UserModel.fromSnapshot(snap.snapshot);
  }
});
}


static Future<String> searchAddressForGeographicCoOrdinates(Position position,context)async{

  String apiURl="http://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$mapKey";

  String humanReadableAddress="";
var requestResponse=await RequestAssistants.receiveResponse(apiURl);

if(requestResponse !="Error Occurred !Failed. No Response."){

  humanReadableAddress=requestResponse['result'][0]['formatted_address'];

  Directions userPickUpAddress=Directions();
  userPickUpAddress.locationLatitude=position.latitude;
  userPickUpAddress.locationLongitude=position.longitude;
  userPickUpAddress.locationName=humanReadableAddress;

}

  return humanReadableAddress;

}


}