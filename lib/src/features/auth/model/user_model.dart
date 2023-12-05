import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? phone;
  String? name;
  String? id;
  String? email;
  String? address;

  UserModel({

    this.phone,
    this.name,
    this.id,
    this.email,
    this.address
});

  UserModel.fromSnapshot(DataSnapshot snapshot){
    phone=(snapshot.value as dynamic)['phone'];
    name=(snapshot.value as dynamic)['name'];
    id=snapshot.key;
    email=(snapshot.value as dynamic)['email'];
    address=(snapshot.value as dynamic)['address'];
  }
}
