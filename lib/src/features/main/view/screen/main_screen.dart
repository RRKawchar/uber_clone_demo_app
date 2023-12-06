import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart'as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone_demo/src/core/asset/app_assets.dart';
import 'package:uber_clone_demo/src/core/assistants/assistants_methods.dart';
import 'package:uber_clone_demo/src/core/keys/map_keys.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LatLng? pickLocation;
  loc.Location location =loc.Location();
  String? _address;



  final Completer<GoogleMapController> controllerGoogleMap =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.816325206953113, 90.41217462635029),
    zoom: 14.4746,
  );

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();



  double searchContainerHeight = 220;
  double waitingResponseFromDriverHeightContainer = 0;
  double assignDriverContainerHeight = 0;

  Position? userCurrentPosition;

  var geoLocation = Geolocator();
  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circlesSet = {};

  String userName = "";
  String userEmail = "";

  bool openNavigationDrawer = true;
  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;


  locationUserPosition()async{

    Position cPosition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition=cPosition;
    LatLng latLngPosition=LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition= CameraPosition(target: latLngPosition,zoom: 15);

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress= await AssistantsMethods.searchAddressForGeographicCoOrdinates(userCurrentPosition!, context);

    print("This is our address : $humanReadableAddress");



  }


  getAddressFromLatLng()async{
    try{
      GeoData data=await Geocoder2.getDataFromCoordinates(
          latitude: pickLocation!.latitude,
          longitude: pickLocation!.longitude,
          googleMapApiKey: mapKey,
      );
      setState(() {
        _address=data.address;
      });
    }catch(e){
      print(e);
    }
  }

  checkIfLocationPermissionAllowed()async{

    _locationPermission=await Geolocator.requestPermission();


    if(_locationPermission==LocationPermission.denied){
      _locationPermission=await Geolocator.requestPermission();

    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfLocationPermissionAllowed();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              polylines: polylineSet,
              markers: markerSet,
              circles: circlesSet,
              onMapCreated: (GoogleMapController controller){
                controllerGoogleMap.complete(controller);
                newGoogleMapController=controller;

                setState(() {

                });

                locationUserPosition();
              },
              onCameraMove: (CameraPosition position){
                if(pickLocation !=position.target){
                  setState(() {
                    pickLocation=position.target;
                  });
                }
              },
              onCameraIdle: (){
                getAddressFromLatLng();
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: Image.asset(AppAssets.pickIcon,height: 45,width: 45,),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white
                ),
                child: Text(_address??"Set Your PickUpLocation",overflow: TextOverflow.visible,softWrap: true,style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
