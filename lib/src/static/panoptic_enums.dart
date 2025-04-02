import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

enum ButtonType {
  primary,
  secondary,
  accent,
  bordered,
  unselected,
}

enum ButtonPosition {
  left,
  right,
  center,
  na,
}

enum FocusActionType {
  done,
  next,
  previous,
}

enum DisplayMode {
  deviceDefault,
  slideOver,
  bottomSheet,
  dialogBox,
}

enum LoginType {
  email,
  mobile,
}

enum ChipType {
  small,
  large,
  filter,
}

enum LoadingType {
  circular,
  linear,
  animated;

  const LoadingType();
  static LoadingType fromContext(BuildContext context) {
    return PanopticExtension.getDeviceType(context) == DeviceType.small ? LoadingType.circular : LoadingType.linear;
  }
}

enum DeviceType {
  small,
  large,
}

enum ToastType {
  success,
  error,
  warning,
  info,
}

enum TooltipDirection {
  top,
  bottom,
  left,
  right,
}

enum DateTimePickerType {
  date,
  time,
  datetime,
}

enum DateType {
  year,
  month,
  day,
  hour,
  minute,
}

enum SearchType {
  students('students'),
  parents('parents'),
  staff('staff'),
  groups('groups'),
  msUsers('Microsoft users'),
  openApply('OpenApply'),
  musicStudent('music students'),
  subjectSet('subject sets'),
  books('books'),
  unsplash('Unsplash'),
  ;

  final String description;

  const SearchType(this.description);

  @override
  String toString() => description;

  String toFirstLetterUpperCase() {
    return description[0].toUpperCase() + description.substring(1);
  }
}

enum OptionsOrientation {
  horizontal,
  vertical,
  wrap,
  auto,
}

enum ControlAffinity {
  leading,
  trailing,
}

enum Days {
  @JsonValue(1)
  aMonday(1, 'A', 'Monday'),
  @JsonValue(2)
  aTuesday(2, 'A', 'Tuesday'),
  @JsonValue(3)
  aWednesday(3, 'A', 'Wednesday'),
  @JsonValue(4)
  aThursday(4, 'A', 'Thursday'),
  @JsonValue(5)
  aFriday(5, 'A', 'Friday'),
  @JsonValue(6)
  aSaturday(6, 'A', 'Saturday'),
  @JsonValue(7)
  bMonday(7, 'B', 'Monday'),
  @JsonValue(8)
  bTuesday(8, 'B', 'Tuesday'),
  @JsonValue(9)
  bWednesday(9, 'B', 'Wednesday'),
  @JsonValue(10)
  bThursday(10, 'B', 'Thursday'),
  @JsonValue(11)
  bFriday(11, 'B', 'Friday'),
  @JsonValue(12)
  bSaturday(12, 'B', 'Saturday');

  final String week;
  final String day;
  final int value;

  const Days(this.value, this.week, this.day);

  @override
  String toString() => '$week $day';
}

enum Periods {
  @JsonValue(0)
  period1(1, 'Period 1'),
  @JsonValue(1)
  period2(2, 'Period 2'),
  @JsonValue(2)
  period3(3, 'Period 3'),
  @JsonValue(3)
  period4(4, 'Period 4'),
  @JsonValue(4)
  period5(5, 'Period 5'),
  @JsonValue(5)
  period6(6, 'Period 6'),
  @JsonValue(6)
  period7(7, 'Period 7');

  final int value;
  final String printedValue;
  const Periods(this.value, this.printedValue);

  @override
  String toString() => printedValue;
}

enum FreePeriodsGroupingType { none, week, day, period }

enum FreePeriodsPage {
  @JsonValue(0)
  day('By Day/Period'),
  @JsonValue(1)
  house('By House');

  final String printedValue;
  const FreePeriodsPage(this.printedValue);

  @override
  String toString() => printedValue;
}

enum AppointmentRequestDecision {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  accepted,
  @JsonValue(2)
  rejected,
}

enum TicketStatus {
  @JsonValue(2)
  open,
  @JsonValue(3)
  pending,
  @JsonValue(4)
  resolved,
  @JsonValue(5)
  closed,
  @JsonValue(6)
  reopened,
  @JsonValue(7)
  scheduled,
  @JsonValue(8)
  withThirdParty,
  @JsonValue(9)
  pendingChildTickets,
  @JsonValue(10)
  changePending,
  @JsonValue(11)
  changeInProgress;
}

enum Provider {
  @JsonValue(0)
  linkedId,
  @JsonValue(1)
  msLearn,
}

enum UserType {
  @JsonValue(0)
  student,
  @JsonValue(1)
  parent,
  @JsonValue(2)
  staffMember,
  @JsonValue(3)
  unknown,
  @JsonValue(4)
  newJoiner,
  @JsonValue(5)
  guardian,
  @JsonValue(6)
  newParent,
  @JsonValue(7)
  leaver;
}

enum ContactListType {
  @JsonValue(1)
  year('Year', PanopticIcons.students),
  @JsonValue(2)
  house('House', PanopticIcons.house),
  @JsonValue(3)
  seniorHouse('Senior House', PanopticIcons.seniorhouse),
  @JsonValue(0)
  none('None', PanopticIcons.torin);

  final String printedName;
  final PanopticIcons icon;
  const ContactListType(this.printedName, this.icon);

  @override
  String toString() => printedName;
}

enum SendMethod {
  @JsonValue(0)
  doNotSend,
  @JsonValue(1)
  email,
  @JsonValue(2)
  notification,
  @JsonValue(3)
  emailAndNotification,
  @JsonValue(4)
  text
}

enum InterruptionLevel {
  @JsonValue(0)
  active(0),
  @JsonValue(1)
  passive(1),
  @JsonValue(2)
  timeSensitive(2),
  @JsonValue(3)
  critical(3);

  const InterruptionLevel(this.value);
  final int value;
}

enum TrackingFrequency {
  @JsonValue(0)
  onePerDay,
  @JsonValue(1)
  twoPerDay,
  @JsonValue(2)
  useInterval;
}

enum ConditionStatus {
  @JsonValue(0)
  archived,
  @JsonValue(2)
  active;
}

enum ConditionAccess {
  @JsonValue(0)
  medicalCentreOnly,
  @JsonValue(1)
  houseStaffAndMedicalCentre,
  @JsonValue(2)
  allAcademicStaff;
}

enum PreferenceType {
  @JsonValue(0)
  allEvening,
  @JsonValue(1)
  coreEvening,
  @JsonValue(2)
  earlyEvening,
  @JsonValue(3)
  lateEvening,
  @JsonValue(4)
  forcedAllEvening;
}

enum StudentType {
  @JsonValue(0)
  mis,
  @JsonValue(1)
  openApply;
}

enum IssuedByType {
  @JsonValue(0)
  self,
  @JsonValue(1)
  medicalCentre,
  @JsonValue(2)
  housemaster,
  @JsonValue(3)
  matron,
  @JsonValue(4)
  otherStaff,
}

enum StepType {
  @JsonValue(0)
  subjectSet,
  @JsonValue(1)
  tutor,
  @JsonValue(2)
  house,
  @JsonValue(3)
  individual;
}

enum RewardType {
  @JsonValue(0)
  commendation,
  @JsonValue(1)
  distinction,
  none;
}

enum AdminPermission {
  @JsonValue(1)
  notify,
  @JsonValue(2)
  rescind,
  @JsonValue(4)
  typeFilter,
  @JsonValue(8)
  categoryFilter;
}

enum LoadProcedures {
  @JsonValue(1)
  houseReasonSubject,
  @JsonValue(2)
  allSubjects,
  @JsonValue(4)
  userSubjects,
  @JsonValue(8)
  allHouses,
  @JsonValue(16)
  userHouses;
}

enum SanctionAttendance {
  @JsonValue(0)
  notAttended('Not Yet Attended'),
  @JsonValue(1)
  attended('Attended'),
  @JsonValue(2)
  both('Attended and Not Attended');

  final String printedValue;

  const SanctionAttendance(this.printedValue);
}

enum SanctionCategory {
  @JsonValue(0)
  all('School and House Sanctions'),
  @JsonValue(1)
  school('School Sanctions'),
  @JsonValue(2)
  house('House Sanctions');

  final String printedValue;

  const SanctionCategory(this.printedValue);

  @override
  String toString() => printedValue;
}

enum SanctionFormEditPermissions {
  @JsonValue(1)
  sanctionType,
  @JsonValue(2)
  subject,
  @JsonValue(4)
  reason,
  @JsonValue(8)
  studentNotified,
  @JsonValue(16)
  detentionDate,
  @JsonValue(32)
  attendanceCertified;
}

enum SchoolReportsViewerMode {
  subjectSet('Set'),
  tutorGroup('Tutor Group'),
  teacher('Teacher'),
  student('Student');

  final String printedValue;

  const SchoolReportsViewerMode(this.printedValue);

  @override
  String toString() => printedValue;
}

enum ReportSummaryType {
  @JsonValue(0)
  report('Report'),
  @JsonValue(1)
  term('Term'),
  @JsonValue(2)
  year('Year');

  final String printedValue;

  const ReportSummaryType(this.printedValue);

  @override
  String toString() => printedValue;
}

enum EmailGroups {
  @JsonValue(0)
  medicalCentre,
  @JsonValue(1)
  housemaster,
  @JsonValue(2)
  matron,
  @JsonValue(3)
  parents;
}

enum StockSupply {
  @JsonValue(0)
  medicalCentre,
  @JsonValue(1)
  house;
}

enum MarkGradeType {
  @JsonValue(0)
  mark,
  @JsonValue(1)
  grade;
}

/// (0) All = All reports
/// (1) Ready = Reports which have at least one step created
/// (2) Open = Reports which are not in draft but not published
/// (3) Published = Reports which have been published
enum ReportType {
  @JsonValue(0)
  all,
  @JsonValue(1)
  ready,
  @JsonValue(2)
  open,
  @JsonValue(3)
  published;
}

enum AsafUserType {
  @JsonValue(0)
  drama,
  @JsonValue(1)
  science,
  @JsonValue(2)
  admin,
  @JsonValue(3)
  normal,
}

enum AsafCommentType {
  @JsonValue(0)
  drama,
  @JsonValue(1)
  science,
  @JsonValue(2)
  interview,
}

enum ApprovalsType {
  @JsonValue(0)
  formsThatRequireApproving,
  @JsonValue(1)
  formsThatUserApprovedAlready,
  @JsonValue(2)
  closedForms,
}

enum OversightType {
  limitedOversight,
  fullOversight,
  noOversight,
}

enum ApiVersion {
  v0,
  v2,
  v3,
  external,
}

enum AttendeeType {
  @JsonValue(0)
  invited,
  @JsonValue(1)
  waitlist,
  @JsonValue(2)
  attending,
  @JsonValue(3)
  notAttending,
  @JsonValue(4)
  attended,
  @JsonValue(5)
  notAttended,
}

enum MessageType {
  @JsonValue(0)
  reminder,
  @JsonValue(1)
  thankYou,
}

enum SignupType {
  @JsonValue(0)
  event,
  @JsonValue(1)
  session,
  @JsonValue(2)
  oneSession,
}

enum PhotoType {
  @JsonValue(0)
  none,
  @JsonValue(1)
  unsplash,
  @JsonValue(2)
  upload,
}

enum QuestionType {
  @JsonValue(0)
  text,
  @JsonValue(1)
  number,
  @JsonValue(2)
  date,
  @JsonValue(3)
  time,
  @JsonValue(4)
  dateTime,
  @JsonValue(5)
  multipleChoice,
  @JsonValue(6)
  checkBox,
  @JsonValue(7)
  dropdown,
  @JsonValue(8)
  fileUpload,
}

enum ScienceSubject {
  biology,
  chemistry,
  physics,
}

enum ChangeStatus {
  @JsonValue(0)
  draft('Draft'),
  @JsonValue(1)
  planning('Planning'),
  @JsonValue(2)
  awaitingApproval('Awaiting Approval'),
  @JsonValue(3)
  pendingWork('Pending Work'),
  @JsonValue(4)
  inProgress('In Progress'),
  @JsonValue(5)
  pendingRelease('Pending Release'),
  @JsonValue(6)
  released('Released');

  final String printedValue;

  const ChangeStatus(this.printedValue);

  @override
  String toString() => printedValue;
}

enum ChangeApproverStatus {
  @JsonValue(0)
  pending('Pending'),
  @JsonValue(1)
  checked('Checked'),
  @JsonValue(2)
  approved('Approved'),
  @JsonValue(3)
  approvedWithComments('Approved with Comments'),
  @JsonValue(4)
  changesRequested('Changes Requested'),
  @JsonValue(5)
  rejected('Rejected');

  final String printedValue;

  const ChangeApproverStatus(this.printedValue);

  @override
  String toString() => printedValue;
}
