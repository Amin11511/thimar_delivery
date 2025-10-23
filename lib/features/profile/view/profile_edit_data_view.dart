import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/features/profile/cubit/profile_cubit.dart';
import 'package:thimar_driver/features/profile/models/profile_data_model.dart';
import 'package:thimar_driver/features/profile/view/widgets/edit_profile_car_form.dart';
import 'package:thimar_driver/features/profile/view/widgets/edit_profile_driver_form.dart';
import '../../../core/services/image_picker_services.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../../core/widgets/app_custom_botton.dart';
import '../cubit/profile_state.dart';

class ProfileEditDataView extends StatefulWidget {
  final ProfileCubit profileCubit;

  const ProfileEditDataView({super.key, required this.profileCubit});

  @override
  State<ProfileEditDataView> createState() => _ProfileEditDataViewState();
}

class _ProfileEditDataViewState extends State<ProfileEditDataView>
    with SingleTickerProviderStateMixin {
  ProfileCubit get profileCubit => widget.profileCubit;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    profileCubit.getProfileData();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return AppCustomButton(
                isLoading: state.getProfileRequestState == RequestState.loading,
                textButton: "تعديل البيانات",
                onPressed: () {
                  profileCubit.updateProfile().then((value) {
                    pushBack();
                    setState(() {});
                  });
                },
              );
            },
          ),
        ),
        appBar: AppCustomAppBar(appBarTitle: "البيانات الشخصية"),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return state.getProfileRequestState == RequestState.loading
                ? const Center(child: CircularProgressIndicator())
                : state.getProfileRequestState == RequestState.error
                ? Center(child: Text(state.msg))
                : state.profileDataModel != null
                ? setupSuccess(state.profileDataModel!)
                : const SizedBox();
          },
        ),
      ),
    );
  }

  Widget setupSuccess(ProfileDataModel data) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(16),
                // الصورة الشخصية
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      profileCubit.personalImage != null
                          ? Image.file(
                        File(profileCubit.personalImage!.path),
                        height: 71.h,
                        width: 76.w,
                        fit: BoxFit.cover,
                      )
                          : CachedNetworkImage(
                        imageUrl: data.data?.image ?? "",
                        height: 71.h,
                        width: 76.w,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () async {
                            _showPickImageDialog(context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: AppColors.blackColor,
                            size: 30.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(8),
                // اسم المستخدم
                Text(
                  data.data?.fullname ?? "",
                  style: AppStyles.font16GreenBold,
                ),
                verticalSpace(4),
                // رقم المستخدم
                Text(
                  "+${data.data?.phone ?? ''}",
                  textDirection: TextDirection.ltr,
                  style: AppStyles.font16GreenMedium,
                ),
                verticalSpace(16),
                // تاب البيانات الشخصية + بيانات السيارة
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 55.h,
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lighterGreenColor,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: "البيانات الشخصية"),
                            Tab(text: "بيانات السيارة"),
                          ],
                          labelColor: AppColors.whiteColor,
                          unselectedLabelColor: AppColors.grayColor,
                          automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 3.0,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.primaryColor,
                          ),
                          indicatorColor: AppColors.primaryColor,
                          labelStyle: AppStyles.font16WhiteBold,
                          unselectedLabelStyle: AppStyles.font20BlackMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocProvider.value(
            value: profileCubit,
            child: SingleChildScrollView(
              child: EditProfileDriverFrom(
                profileCubit: profileCubit,
                data: data,
              ),
            ),
          ),
          BlocProvider.value(
            value: profileCubit,
            child: SingleChildScrollView(
              child: EditProfileCarForm(cubit: profileCubit, data: data),
            ),
          ),
        ],
      ),
    );
  }

  void _showPickImageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: AppColors.primaryColor,
                ),
                title: Text("التقاط صورة بالكاميرا"),
                onTap: () async {
                  final imageFile = await ImagePickerService().pickImage(
                    source: ImageSource.camera,
                  );
                  if (imageFile != null) {
                    profileCubit.updateSelectedImages(imageFile as XFile);
                    setState(() {});
                  }
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
                title: Text("اختيار من المعرض"),
                onTap: () async {
                  final XFile? imageFile = await ImagePickerService().pickImage(
                    source: ImageSource.camera,
                  );
                  if (imageFile != null) {
                    profileCubit.updateSelectedImages(imageFile); // pass XFile directly
                    setState(() {}); // refresh UI
                  }
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}