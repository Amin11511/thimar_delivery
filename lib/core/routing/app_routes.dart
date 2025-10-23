import 'package:flutter/widgets.dart';
import 'package:thimar_driver/features/auth/register/view/register_view.dart';
import '../../features/about_app/view/about_app_view.dart';
import '../../features/about_app/view/complain_view.dart';
import '../../features/about_app/view/contact_view.dart';
import '../../features/about_app/view/fqs_view.dart';
import '../../features/about_app/view/terms_view.dart';
import '../../features/auth/forget_password/view/forget_password_view.dart';
import '../../features/auth/login/view/login_view.dart';
import '../../features/auth/new_password/new_password_view.dart';
import '../../features/auth/verify_code/view/verify_view.dart';
import '../../features/layout/view/bottom_nav_bar_layout.dart';
import '../../features/order_details/view/order_details_view.dart';
import '../../features/profile/cubit/profile_cubit.dart';
import '../../features/profile/view/profile_edit_data_view.dart';
import '../../features/splash/view/splash_view.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.splash;

  AppRoutes._internal();

  Map<String, Widget Function(BuildContext)> appRoutes = {
    NamedRoutes.splash: (c) => const SplashView(),
    NamedRoutes.login: (c) => const LoginView(),
    NamedRoutes.register: (c) => const RegisterView(),
    NamedRoutes.forgetPasswordView: (c) => ForgetPasswordView(),
    NamedRoutes.newPasswordView: (c) {
      final args = ModalRoute.of(c)!.settings.arguments as Map<String, dynamic>;
      return NewPasswordView(
        phone: args['phone'] as String,
        code: args['code'] as String,
      );
    },
    NamedRoutes.verifiedView: (c) {
      final args = ModalRoute.of(c)!.settings.arguments as Map<String, dynamic>;
      return VerifiedView(
        phone: args['phone'] as String,
        isActiveAccount: args['isActiveAccount'] as bool,
      );
    },
    NamedRoutes.bottomNavBarLayout: (c) => BottomNavBarLayout(),
    NamedRoutes.orderDetails: (c) {
      final args = ModalRoute.of(c)!.settings.arguments;
      return OrderDetailsView(orderId: args as int);
    },
    NamedRoutes.profileEditDataView: (c) {
      final cubit = ModalRoute.of(c)!.settings.arguments as ProfileCubit;
      return ProfileEditDataView(profileCubit: cubit);
    },
    NamedRoutes.aboutAppView: (c) => AboutAppView(),
    NamedRoutes.fqsView: (c) => FqsView(),
    NamedRoutes.termsView: (c) => TermsView(),
    NamedRoutes.complainView: (c) => ComplainView(),
    NamedRoutes.contactView: (c) => ContactView(),
  };
}