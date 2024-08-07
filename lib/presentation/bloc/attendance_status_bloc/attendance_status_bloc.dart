import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/bussiness/usecase/retrieve_students_for_attendance_usecase.dart';
import 'package:nricse/common/attendance_student_list.dart';
import 'package:nricse/common/data.dart';
import 'package:nricse/common/data_for_attendance_status.dart';
import 'package:nricse/common/data_for_take_attendance.dart';
import 'package:nricse/data/data_source/retrieve_batch_data.dart';
import 'package:nricse/data/data_source/retrieve_section_data.dart';
import 'package:nricse/data/data_source/retrive_faculty_subjects.dart';
import 'package:nricse/presentation/bloc/attendance_status_bloc/attendance_status_event.dart';
import 'package:nricse/presentation/bloc/attendance_status_bloc/attendance_status_state.dart';

class AttendanceStatusBloc
    extends Bloc<AttendanceStatusEvent, AttendanceStatusState> {
  final RetrieveStudentsForAttendanceUsecase
      retrieveStudentsForAttendanceUsecase;
  AttendanceStatusBloc({required this.retrieveStudentsForAttendanceUsecase})
      : super(AttendanceStatusInitialState()) {
    on<AttendanceStatusInitialEvent>(attendanceStatusInitialEvent);
    on<AttendanceStatusPickDateTimeEvent>(attendanceStatusPickDateTimeEvent);
    on<AttendanceStatusRetrieveStudentEvent>(
        attendanceStatusRetrieveStudentEvent);
        on<AttendanceStatusUpdateUiEvent>(attendanceStatusUpdateUiEvent);
  }

  FutureOr<void> attendanceStatusInitialEvent(
      AttendanceStatusInitialEvent event,
      Emitter<AttendanceStatusState> emit) async {
    seletedBatch = "";
    seletedSection = "";
    listOfStudents = [];
    emit(AttendanceStatusRetrieveingStudentLoadingState());
    if (listOfBatch.isEmpty && listOfSections.isEmpty) {
      listOfBatch = await RetrieveBatchData().retrieveBatch(event.context);
      listOfSections =
          await RetrieveSectionData().retrieveSection(event.context);
      listOfSubjects = await RetrieveFacultySubjects().getSubjectsForFaculty(
          firebaseAuth.currentUser!.email!, event.context);
    }
    emit(AttendanceStatusRetrieveingStudentLoadedState());
    emit(AttendanceStatusUpdateUIState());
  }

  FutureOr<void> attendanceStatusPickDateTimeEvent(
      AttendanceStatusPickDateTimeEvent event,
      Emitter<AttendanceStatusState> emit) {
    selectedDateTime = event.dateTime;
    emit(AttendanceStatusUpdateUIState());
  }

  FutureOr<void> attendanceStatusRetrieveStudentEvent(
      AttendanceStatusRetrieveStudentEvent event,
      Emitter<AttendanceStatusState> emit) async {
    emit(AttendanceStatusRetrieveingStudentLoadingState());
    listOfStudents = await retrieveStudentsForAttendanceUsecase.retrieve(
      event.context,
      event.batch,
      event.section,
    );
    emit(AttendanceStatusRetrieveingStudentLoadedState());
  }

  FutureOr<void> attendanceStatusUpdateUiEvent(AttendanceStatusUpdateUiEvent event, Emitter<AttendanceStatusState> emit) {
     emit(AttendanceStatusUpdateUIState());
  }
}
