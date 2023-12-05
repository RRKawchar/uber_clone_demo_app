import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone_demo/src/features/auth/model/user_model.dart';

final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

User? currentUser;

UserModel? userModelCurrentInfo;