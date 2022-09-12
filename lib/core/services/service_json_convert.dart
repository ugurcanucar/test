import 'package:terapizone/ui/models/active_appointments_model.dart';
import 'package:terapizone/ui/models/appointment_join_model.dart';
import 'package:terapizone/ui/models/availability_list_client_model.dart';
import 'package:terapizone/ui/models/availability_list_therapist_model.dart';
import 'package:terapizone/ui/models/card_storage_model.dart';
import 'package:terapizone/ui/models/chat_detail_model.dart';
import 'package:terapizone/ui/models/chat_list_model.dart';
import 'package:terapizone/ui/models/content_model.dart';
import 'package:terapizone/ui/models/disease_model.dart';
import 'package:terapizone/ui/models/gender_model.dart';
import 'package:terapizone/ui/models/get_changing_reason_model.dart';
import 'package:terapizone/ui/models/is_new_client_accepting_model.dart';
import 'package:terapizone/ui/models/list_test_scrore_model.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/match_disease_list_model.dart';
import 'package:terapizone/ui/models/my_profile_model.dart';
import 'package:terapizone/ui/models/my_therapist_model.dart';
import 'package:terapizone/ui/models/notification_model.dart';
import 'package:terapizone/ui/models/packages_model.dart';
import 'package:terapizone/ui/models/past_appointments_model.dart';
import 'package:terapizone/ui/models/post_auth_change_password_model.dart';
import 'package:terapizone/ui/models/purchased_packages_model.dart';
import 'package:terapizone/ui/models/response_auth_login_model.dart';
import 'package:terapizone/ui/models/response_auth_register_model.dart';
import 'package:terapizone/ui/models/routinebreak_list_model.dart';
import 'package:terapizone/ui/models/test_list_model.dart';
import 'package:terapizone/ui/models/test_questions_model.dart';
import 'package:terapizone/ui/models/therapist_get_diseases_model.dart';
import 'package:terapizone/ui/models/therapist_list_model.dart';
import 'package:terapizone/ui/models/threapist_detail_model.dart';
import 'package:terapizone/ui/models/workschedule_day_plan_model.dart';
import 'package:terapizone/ui/models/workschedule_model.dart';
import 'package:terapizone/ui/models/workschedule_setting_model.dart';

class JsonConvertService {
  static dynamic getModel<T>(dynamic json) {
    if (T.toString().contains('String')) {
      if (json != null) {
        return json;
      } else {
        return null;
      }
    } else if (T.toString().contains('bool')) {
      if (json != null) {
        return json;
      } else {
        return null;
      }
    } else if (T
        .toString()
        .contains(ResponseAuthRegisterModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ResponseAuthRegisterModel>.from(
                      json.map((x) => ResponseAuthRegisterModel.fromJson(x)))
                  : ResponseAuthRegisterModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(ResponseAuthLoginModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ResponseAuthLoginModel>.from(
                      json.map((x) => ResponseAuthLoginModel.fromJson(x)))
                  : ResponseAuthLoginModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(PostAuthChangePasswordModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<PostAuthChangePasswordModel>.from(
                      json.map((x) => PostAuthChangePasswordModel.fromJson(x)))
                  : PostAuthChangePasswordModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(MainDiseaseModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<MainDiseaseModel>.from(
                      json.map((x) => MainDiseaseModel.fromJson(x)))
                  : MainDiseaseModel.fromJson(json)
              : null;
    } else if (T.toString().contains(GenderModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<GenderModel>.from(
                      json.map((x) => GenderModel.fromJson(x)))
                  : GenderModel.fromJson(json)
              : null;
    } else if (T.toString().contains(DiseaseModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<DiseaseModel>.from(
                      json.map((x) => DiseaseModel.fromJson(x)))
                  : DiseaseModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(TherapistListModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<TherapistListModel>.from(
                      json.map((x) => TherapistListModel.fromJson(x)))
                  : TherapistListModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(TestQuestionsModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<TestQuestionsModel>.from(
                      json.map((x) => TestQuestionsModel.fromJson(x)))
                  : TestQuestionsModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(RoutineBreakListModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<RoutineBreakListModel>.from(
                      json.map((x) => RoutineBreakListModel.fromJson(x)))
                  : RoutineBreakListModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(WorkscheduleModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<WorkscheduleModel>.from(
                      json.map((x) => WorkscheduleModel.fromJson(x)))
                  : WorkscheduleModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(WorkscheduleDayplanModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<WorkscheduleDayplanModel>.from(
                      json.map((x) => WorkscheduleDayplanModel.fromJson(x)))
                  : WorkscheduleDayplanModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(WorkscheduleSettingModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<WorkscheduleSettingModel>.from(
                      json.map((x) => WorkscheduleSettingModel.fromJson(x)))
                  : WorkscheduleSettingModel.fromJson(json)
              : null;
    } else if (T.toString().contains(
        DayAvailabilityListForTherapistModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<DayAvailabilityListForTherapistModel>.from(json.map(
                      (x) => DayAvailabilityListForTherapistModel.fromJson(x)))
                  : DayAvailabilityListForTherapistModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(DayAvailabilityListForClientModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<DayAvailabilityListForClientModel>.from(json.map(
                      (x) => DayAvailabilityListForClientModel.fromJson(x)))
                  : DayAvailabilityListForClientModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(ActiveAppointmentsModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ActiveAppointmentsModel>.from(
                      json.map((x) => ActiveAppointmentsModel.fromJson(x)))
                  : ActiveAppointmentsModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(PastAppointmentsModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<PastAppointmentsModel>.from(
                      json.map((x) => PastAppointmentsModel.fromJson(x)))
                  : PastAppointmentsModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(TherapistDetailModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<TherapistDetailModel>.from(
                      json.map((x) => TherapistDetailModel.fromJson(x)))
                  : TherapistDetailModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(MatchDiseaseListModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<MatchDiseaseListModel>.from(
                      json.map((x) => MatchDiseaseListModel.fromJson(x)))
                  : MatchDiseaseListModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(CardStorageModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<CardStorageModel>.from(
                      json.map((x) => CardStorageModel.fromJson(x)))
                  : CardStorageModel.fromJson(json)
              : null;
    } else if (T.toString().contains(PackagesModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<PackagesModel>.from(
                      json.map((x) => PackagesModel.fromJson(x)))
                  : PackagesModel.fromJson(json)
              : null;
    } else if (T.toString().contains(ChatListModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ChatListModel>.from(
                      json.map((x) => ChatListModel.fromJson(x)))
                  : ChatListModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(ChatDetailModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ChatDetailModel>.from(
                      json.map((x) => ChatDetailModel.fromJson(x)))
                  : ChatDetailModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(MyTherapistModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<MyTherapistModel>.from(
                      json.map((x) => MyTherapistModel.fromJson(x)))
                  : MyTherapistModel.fromJson(json)
              : null;
    } else if (T.toString().contains(MyProfileModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<MyProfileModel>.from(
                      json.map((x) => MyProfileModel.fromJson(x)))
                  : MyProfileModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(PurchasedPackageModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<PurchasedPackageModel>.from(
                      json.map((x) => PurchasedPackageModel.fromJson(x)))
                  : PurchasedPackageModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(AppointmentJoinModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<AppointmentJoinModel>.from(
                      json.map((x) => AppointmentJoinModel.fromJson(x)))
                  : AppointmentJoinModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(GetChangingReasonModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<GetChangingReasonModel>.from(
                      json.map((x) => GetChangingReasonModel.fromJson(x)))
                  : GetChangingReasonModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(ReasonChangingDtoModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ReasonChangingDtoModel>.from(
                      json.map((x) => ReasonChangingDtoModel.fromJson(x)))
                  : ReasonChangingDtoModel.fromJson(json)
              : null;
    } else if (T.toString().contains(ContentModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ContentModel>.from(
                      json.map((x) => ContentModel.fromJson(x)))
                  : ContentModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(IsNewClientAcceptingModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<IsNewClientAcceptingModel>.from(
                      json.map((x) => IsNewClientAcceptingModel.fromJson(x)))
                  : IsNewClientAcceptingModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(TherapistGetDiseasesModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<TherapistGetDiseasesModel>.from(
                      json.map((x) => TherapistGetDiseasesModel.fromJson(x)))
                  : TherapistGetDiseasesModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(UserChosenDiseaseListDtoModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<UserChosenDiseaseListDtoModel>.from(json
                      .map((x) => UserChosenDiseaseListDtoModel.fromJson(x)))
                  : UserChosenDiseaseListDtoModel.fromJson(json)
              : null;
    } else if (T.toString().contains(TestListModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<TestListModel>.from(
                      json.map((x) => TestListModel.fromJson(x)))
                  : TestListModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(ListTestScoreModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ListTestScoreModel>.from(
                      json.map((x) => ListTestScoreModel.fromJson(x)))
                  : ListTestScoreModel.fromJson(json)
              : null;
    } else if (T.toString().contains(ScoreModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<ScoreModel>.from(
                      json.map((x) => ScoreModel.fromJson(x)))
                  : ScoreModel.fromJson(json)
              : null;
    } else if (T
        .toString()
        .contains(NotificationModel().runtimeType.toString())) {
      return json.length == 0
          ? []
          : json != null
              ? json[0] != null
                  ? List<NotificationModel>.from(
                      json.map((x) => NotificationModel.fromJson(x)))
                  : NotificationModel.fromJson(json)
              : null;
    }
  }
}
