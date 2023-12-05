import 'package:firebase_database/firebase_database.dart';
import 'package:uber_clone_demo/src/core/globle/global.dart';
import 'package:uber_clone_demo/src/features/auth/model/user_model.dart';

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


}