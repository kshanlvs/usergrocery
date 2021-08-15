import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/modules/home/bindings/home_binding.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      
      initialRoute: AppPages.INITIAL,
      initialBinding: HomeBinding(),
      // initialRoute: Routes.PAYMENT_PAGE,
      getPages: AppPages.routes,
    ),
  );
}



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
  
//   @override 
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
//   late GoogleMapController _controller;
//   Location _location = Location();

//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) { 
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 1),
//           ),
//       );
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height:500,
//         width: 500,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  
// }

