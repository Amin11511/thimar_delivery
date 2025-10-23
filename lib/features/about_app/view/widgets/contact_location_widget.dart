import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar_driver/features/about_app/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_loading_indicator_widget.dart';
import '../../cubit/about_app_cubit.dart';
import '../../cubit/about_app_state.dart';
import 'contact_custom_row.dart';

class ContactLocationWidget extends StatefulWidget {
  const ContactLocationWidget({super.key});

  @override
  State<ContactLocationWidget> createState() => _ContactLocationWidgetState();
}

class _ContactLocationWidgetState extends State<ContactLocationWidget> {
  var myMarkers = HashSet<Marker>();
  late BitmapDescriptor customMarker;

  getCustomMarker() async {
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
    return BlocBuilder<AboutAppCubit, AboutAppState>(
      builder: (context, state) {
        return state.contactUsState == RequestState.loading
            ? const AppLoadingIndicatorWidget()
            : state.contactUsState == RequestState.error
            ? Center(child: Text(state.contactUsMsg))
            : state.contactUsState == RequestState.done &&
            state.contactModel != null
            ? setupSuccess(state.contactModel!)
            : const SizedBox.shrink();
      },
    );
  }

  Widget setupSuccess(ContactModel data) {
    final double lat = double.tryParse(data.data?.lat.toString() ?? "") ?? 0.0;
    final double lng = double.tryParse(data.data?.lng.toString() ?? "") ?? 0.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 250.h,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 18.4746,
            ),
            onMapCreated: (controller) {
              setState(() {
                myMarkers.add(
                  Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(title: data.data?.location),
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
        verticalSpace(10),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: ElevatedButton.icon(
            onPressed: () => _openInGoogleMaps(lat, lng),
            icon: Image.asset(
              AppAssets.locationImage,
              width: 25.w,
              height: 25.h,
            ),
            label: Text(
              "أعرض الموقع فى خرائط جوجل",
              style: AppStyles.font16GreenBold,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              backgroundColor: AppColors.lighterGreenColor,
            ),
          ),
        ),
        Positioned(
          bottom: -40.h,
          left: 16.w,
          right: 16.w,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  ContactCustomRow(
                    title: data.data?.location ?? "",
                    iconPath: AppAssets.solidCallingIconImage,
                  ),
                  if ((data.data?.phone ?? "").isNotEmpty) verticalSpace(8),
                  if ((data.data?.phone ?? "").isNotEmpty)
                    ContactCustomRow(
                      title: data.data?.phone ?? "",
                      iconPath: AppAssets.solidCallingIconImage,
                    ),
                  if ((data.data?.email ?? "").isNotEmpty) verticalSpace(8),
                  if ((data.data?.email ?? "").isNotEmpty)
                    ContactCustomRow(
                      title: data.data?.email ?? "",
                      iconPath: AppAssets.messageIconImage,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}