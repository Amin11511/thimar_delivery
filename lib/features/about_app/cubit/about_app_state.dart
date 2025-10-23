import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/about_app/models/about_app_model.dart';
import 'package:thimar_driver/features/about_app/models/complain_model.dart';
import 'package:thimar_driver/features/about_app/models/contact_model.dart';
import 'package:thimar_driver/features/about_app/models/fqs_model.dart';
import 'package:thimar_driver/features/about_app/models/terms_model.dart';

class AboutAppState {
  final RequestState getAboutAppState;
  final String aboutAppMsg;
  final ErrorType aboutAppErrorType;
  final AboutAppModel? aboutAppModel;

  final RequestState termsState;
  final String termsMsg;
  final ErrorType termsErrorType;
  final TermsModel?  termsModel;

  final RequestState contactUsState;
  final String contactUsMsg;
  final ErrorType contactUsErrorType;
  final ContactModel? contactModel;


  final RequestState complainState;
  final String complainMsg;
  final ErrorType complainErrorType;
  final ComplaintModel? complainModel;

  final RequestState faqState;
  final String faqMsg;
  final ErrorType faqErrorType;
  final FqsModel? fqsModel;

  AboutAppState({
    this.getAboutAppState = RequestState.initial,
    this.aboutAppMsg = '',
    this.aboutAppErrorType = ErrorType.none,
    this.aboutAppModel,
    this.termsState = RequestState.initial,
    this.termsMsg = '',
    this.termsErrorType = ErrorType.none,
    this.termsModel,
    this.contactUsState = RequestState.initial,
    this.contactUsMsg = '',
    this.contactUsErrorType = ErrorType.none,
    this.contactModel,
    this.complainState = RequestState.initial,
    this.complainMsg = '',
    this.complainErrorType = ErrorType.none,
    this.complainModel,
    this.faqState = RequestState.initial,
    this.faqMsg = '',
    this.faqErrorType = ErrorType.none,
    this.fqsModel,
  });
  AboutAppState copyWith({
    RequestState? getAboutAppState,
    String? aboutAppMsg,
    ErrorType? aboutAppErrorType,
    AboutAppModel? aboutAppModel,
    RequestState? termsState,
    String? termsMsg,
    ErrorType? termsErrorType,
    TermsModel? termsModel,
    RequestState? contactUsState,
    String? contactUsMsg,
    ErrorType? contactUsErrorType,
    ContactModel? contactModel,
    RequestState? complainState,
    String? complainMsg,
    ErrorType? complainErrorType,
    ComplaintModel? complainModel,
    RequestState? faqState,
    String? faqMsg,
    ErrorType? faqErrorType,
    FqsModel? fqsModel,
  }) =>
      AboutAppState(
        getAboutAppState: getAboutAppState ?? this.getAboutAppState,
        aboutAppMsg: aboutAppMsg ?? this.aboutAppMsg,
        aboutAppErrorType: aboutAppErrorType ?? this.aboutAppErrorType,
        aboutAppModel: aboutAppModel ?? this.aboutAppModel,
        termsState: termsState ?? this.termsState,
        termsMsg: termsMsg ?? this.termsMsg,
        termsErrorType: termsErrorType ?? this.termsErrorType,
        termsModel: termsModel ?? this.termsModel,
        contactUsState: contactUsState ?? this.contactUsState,
        contactUsMsg: contactUsMsg ?? this.contactUsMsg,
        contactUsErrorType: contactUsErrorType ?? this.contactUsErrorType,
        contactModel: contactModel ?? this.contactModel,
        complainState: complainState ?? this.complainState,
        complainMsg: complainMsg ?? this.complainMsg,
        complainErrorType: complainErrorType ?? this.complainErrorType,
        complainModel: complainModel ?? this.complainModel,
        faqState: faqState ?? this.faqState,
        faqMsg: faqMsg ?? this.faqMsg,
        faqErrorType: faqErrorType ?? this.faqErrorType,
        fqsModel: fqsModel ?? this.fqsModel,
      );


}