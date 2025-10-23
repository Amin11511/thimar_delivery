import 'package:get_it/get_it.dart';
import 'package:thimar_driver/features/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:thimar_driver/features/auth/login/cubit/login_cubit.dart';
import 'package:thimar_driver/features/auth/register/cubit/register_cubit.dart';
import '../../features/about_app/cubit/about_app_cubit.dart';
import '../../features/auth/new_password/cubit/new_password_cubit.dart';
import '../../features/auth/verify_code/cubit/verify_code_cubit.dart';
import '../../features/home/cubit/home_cubit.dart';
import '../../features/notifications/cubit/notifications_cubit.dart';
import '../../features/order_details/cubit/order_details_cubit.dart';
import '../../features/orders/cubit/orders_cubit.dart';
import '../../features/profile/cubit/profile_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(() => RegisterCubit());
    sl.registerFactory(() => ForgetPasswordCubit());
    sl.registerFactory(() => VerifiCodeCubit());
    sl.registerFactory(() => HomeCubit());
    sl.registerFactory(() => OrderDetailsCubit());
    sl.registerFactory(() => OrdersCubit());
    sl.registerFactory(() => ProfileCubit());
    sl.registerFactory(() => AboutAppCubit());
    sl.registerFactory(() => NewPasswordCubit());
    sl.registerFactory(() => NotificationsCubit());
  }
}