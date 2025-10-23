import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar_driver/features/order_details/models/order_details_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';

class OrderDetailsAddressWidget extends StatefulWidget {
  final OrderDetailsModel data;

  const OrderDetailsAddressWidget({super.key, required this.data});

  @override
  State<OrderDetailsAddressWidget> createState() =>
      _OrderDetailsAddressWidgetState();
}

class _OrderDetailsAddressWidgetState extends State<OrderDetailsAddressWidget> {
  var myMarkers = HashSet<Marker>();
  late BitmapDescriptor customMarker;

  Future<void> getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/location_mark.png',
      mipmaps: true,
      bundle: rootBundle,
    );
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
  }

  void _openInGoogleMaps(double lat, double lng) async {
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.data.data;
    final double lat =
        double.tryParse(order?.address?.lat.toString() ?? "") ?? 0.0;
    final double lng =
        double.tryParse(order?.address?.lng.toString() ?? "") ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(12),
        Text("عنوان التوصيل", style: AppStyles.font16GreenBold),
        verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order?.address?.type ?? "",
                    style: AppStyles.font16GreenMedium,
                  ),
                  verticalSpace(8),
                  Text(
                    order?.address?.location ?? "",
                    style: AppStyles.font16DarkerGrayLight,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(8),
                  Text(
                    order?.address?.description ?? "",
                    style: AppStyles.font16DarkerGrayLight,
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () => _openInGoogleMaps(lat, lng),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 15.0,
                        ),
                        onMapCreated: (controller) {
                          setState(() {
                            myMarkers.add(
                              Marker(
                                markerId: const MarkerId("1"),
                                position: LatLng(lat, lng),
                                infoWindow: InfoWindow(
                                  title: order?.address?.location,
                                ),
                                icon: customMarker,
                              ),
                            );
                          });
                        },
                        markers: myMarkers,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 32.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}