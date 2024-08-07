import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/bussiness/usecase/add_faculty_usecase.dart';
import 'package:nricse/data/data_source/firebase_api_for_add_faculty.dart';
import 'package:nricse/data/repository/faculty_data_repository.dart';
import 'package:nricse/presentation/bloc/add_faculty_bloc/add_faculty_bloc.dart';
import 'package:nricse/presentation/pages/add_faculty.dart';
import 'package:nricse/presentation/widgets/Navigating_one_place_to_another_place.dart';

class FloatingBottomButtonFacultyList extends StatelessWidget {
  const FloatingBottomButtonFacultyList({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Hero(
          tag: "fillbutton",
          child: TextButton.icon(
            onPressed: () {
              NavigatingOnePlaceToAnotherPlace().navigatePage(
                  context,
                  BlocProvider(
                    create: (context) => AddFacultyBloc(
                        addFacultyUsecase: AddFacultyUsecase(
                            repository: FacultyRepository(
                                dataSource: FirebaseApiForAddFaculty()))),
                    child: const AddFaculty(),
                  ));
            },
            label: const Text("Faculty"),
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(4),
              backgroundColor:
                  const WidgetStatePropertyAll(Colors.deepPurpleAccent),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
