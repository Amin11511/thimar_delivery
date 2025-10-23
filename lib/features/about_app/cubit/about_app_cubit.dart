import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import 'package:thimar_driver/features/about_app/models/about_app_model.dart';
import 'package:thimar_driver/features/about_app/models/complain_model.dart';
import 'package:thimar_driver/features/about_app/models/complain_request_body.dart';
import 'package:thimar_driver/features/about_app/models/contact_model.dart';
import 'package:thimar_driver/features/about_app/models/fqs_model.dart';
import 'package:thimar_driver/features/about_app/models/terms_model.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/enums.dart';
import 'about_app_state.dart';

class AboutAppCubit extends Cubit<AboutAppState> {
  AboutAppCubit() : super(AboutAppState());
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> getAboutApp() async {
    emit(state.copyWith(getAboutAppState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.aboutAppEP,
    );
    if (result.success) {
      final model = result.data != null
          ? AboutAppModel.fromJson(result.data)
          : null;
      emit(
        state.copyWith(
          getAboutAppState: RequestState.done,
          aboutAppModel: model,
        ),
      );
    } else {
      emit(
        state.copyWith(
          getAboutAppState: RequestState.error,
          aboutAppMsg: result.msg,
          aboutAppErrorType: result.errType,
        ),
      );
    }
  }

  //terms
  Future<void> getTerms() async {
    emit(state.copyWith(termsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.termsEP);
    if (result.success) {
      final model = result.data != null
          ? TermsModel.fromJson(result.data)
          : null;
      emit(state.copyWith(termsState: RequestState.done, termsModel: model));
    } else {
      emit(
        state.copyWith(
          termsState: RequestState.error,
          termsMsg: result.msg,
          termsErrorType: result.errType,
        ),
      );
    }
  }

  //contact
  Future<void> getContact() async {
    emit(state.copyWith(contactUsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.contactEP,
    );
    if (result.success) {
      final model = result.data != null
          ? ContactModel.fromJson(result.data)
          : null;
      emit(
        state.copyWith(contactUsState: RequestState.done, contactModel: model),
      );
    } else {
      emit(
        state.copyWith(
          contactUsState: RequestState.error,
          contactUsMsg: result.msg,
          contactUsErrorType: result.errType,
        ),
      );
    }
  }

  //complaints
  Future<void> sendComplaints() async {
    emit(state.copyWith(complainState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.contactEP,
      body: ComplainRequestBody(
        name: nameController.text,
        phone: phoneController.text,
        title: titleController.text,
        content: contentController.text,
      ).toJson(),
    );
    if (result.success) {
      final model = result.data != null
          ? ComplaintModel.fromJson(result.data)
          : null;

      emit(
        state.copyWith(
          complainState: RequestState.done,
          complainMsg: result.msg,
          complainModel: model,
        ),
      );
      FlashHelper.showToast(result.msg);
      pushBack();
      nameController.clear();
      phoneController.clear();
      titleController.clear();
      contentController.clear();
      formKey.currentState?.reset();
    } else {
      emit(
        state.copyWith(
          complainState: RequestState.error,
          complainMsg: result.msg,
          complainErrorType: result.errType,
        ),
      );
    }
  }

  Future<void> getFqs() async {
    emit(state.copyWith(faqState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.faqsEP);
    if (result.success) {
      final model = result.data != null ? FqsModel.fromJson(result.data) : null;
      emit(state.copyWith(faqState: RequestState.done, fqsModel: model));
    } else {
      emit(
        state.copyWith(
          faqState: RequestState.error,
          faqMsg: result.msg,
          faqErrorType: result.errType,
        ),
      );
    }
  }
}