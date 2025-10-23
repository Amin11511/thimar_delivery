import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/profile/models/update_profile_model.dart';

import '../models/profile_data_model.dart';

class ProfileState {
  final RequestState getProfileRequestState;
  final String msg;
  final ErrorType errorType;
  final ProfileDataModel? profileDataModel;

  final RequestState updateProfileRequestState;
  final String updateMsg;
  final ErrorType updateErrorType;
  final UpdateProfileModel? updateProfileDataModel;

  ProfileState({
    this.getProfileRequestState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.profileDataModel,
    this.updateProfileRequestState = RequestState.initial,
    this.updateMsg = '',
    this.updateErrorType = ErrorType.none,
    this.updateProfileDataModel,
  });

  ProfileState copyWith({
    RequestState? getProfileRequestState,
    String? msg,
    ErrorType? errorType,
    ProfileDataModel? profileDataModel,
    RequestState? updateProfileRequestState,
    String? updateMsg,
    ErrorType? updateErrorType,
    UpdateProfileModel? updateProfileDataModel,
    RequestState? updateImageRequestState,
  }) {
    return ProfileState(
      getProfileRequestState:
      getProfileRequestState ?? this.getProfileRequestState,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      profileDataModel: profileDataModel ?? this.profileDataModel,
      updateProfileRequestState:
      updateProfileRequestState ?? this.updateProfileRequestState,
      updateMsg: updateMsg ?? this.updateMsg,
      updateErrorType: updateErrorType ?? this.updateErrorType,
      updateProfileDataModel:
      updateProfileDataModel ?? this.updateProfileDataModel,
    );
  }
}