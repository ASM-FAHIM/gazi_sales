import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/colors.dart';
import '../../widget/big_text.dart';

class OutletsLocScreen extends StatefulWidget {
  const OutletsLocScreen({Key? key}) : super(key: key);

  @override
  State<OutletsLocScreen> createState() => OutletsLocScreenState();
}

class OutletsLocScreenState extends State<OutletsLocScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng vataraThana = LatLng(23.797462, 90.424059);
  static const LatLng labAidHospital = LatLng(23.794072, 90.412832);
  static const LatLng unitedHospital = LatLng(23.804821, 90.415609);
  static const LatLng bracBank = LatLng(23.796742, 90.413697);
  static const LatLng jamunaAmusementPark = LatLng(23.813037, 90.422067);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          title: BigText(text: "Outlet locations", color: AppColor.defWhite, size: 25,),
        ),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: vataraThana,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: MarkerId("Lab-Aid-Hospital"),
              position: vataraThana,
              infoWindow: InfoWindow(title: 'Alam Motors'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            ),
            Marker(
              markerId: MarkerId("Destination"),
              position: labAidHospital,
              infoWindow: InfoWindow(title: 'Lucky Autos'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
            Marker(
              markerId: MarkerId("United-Hospital"),
              position: unitedHospital,
              infoWindow: InfoWindow(title: 'M/S Din Enterprise'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            ),
            Marker(
              markerId: MarkerId("Brac-Bank"),
              position: bracBank,
              infoWindow: InfoWindow(title: 'Uttara Traders'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ),
          },
        )
    );
  }
}