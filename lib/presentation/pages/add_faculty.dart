
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:nricse/bussiness/entites/faculty_data_entity.dart';
import 'package:nricse/common/custom_snack_bar.dart';
import 'package:nricse/common/data_for_add_faculty.dart';
import 'package:nricse/data/data_source/add_subjects_to_firebase.dart';
import 'package:nricse/presentation/bloc/add_faculty_bloc/add_faculty_bloc.dart';
import 'package:nricse/presentation/bloc/add_faculty_bloc/add_faculty_event.dart';
import 'package:nricse/presentation/bloc/add_faculty_bloc/add_faculty_state.dart';
import 'package:nricse/presentation/widgets/add_faculty_widgets/add_subject_dialog.dart';
import 'package:nricse/presentation/widgets/text_field_for_add_faculty_list.dart';

class AddFaculty extends StatefulWidget {
  const AddFaculty({super.key});

  @override
  State<AddFaculty> createState() => _AddFacultyState();
}

class _AddFacultyState extends State<AddFaculty> {
  final facultyNameController = TextEditingController();
  final facultyEmailController = TextEditingController();
  final facultyNumberController = TextEditingController();
  final previousExperienceController = TextEditingController();
  final subjectController = TextEditingController();
  List<String> allSubjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _loadSubjects() async {
    List<String> subjects = await AddSubjectsToFirebase().retrieveSubjects();
    setState(() {
      allSubjects = subjects;
    });
  }

  @override
  void dispose() {
    subjectController.dispose();
    facultyEmailController.dispose();
    facultyNameController.dispose();
    facultyNumberController.dispose();
    previousExperienceController.dispose();
    selectedSubjects.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Faculty "),
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          _loadSubjects();
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: BlocConsumer<AddFacultyBloc, AddFacultyState>(
              bloc: context.read<AddFacultyBloc>(),
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state == AddFacultyLoading)
                      const CircularProgressIndicator(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldForAddFacultyList(
                          label: "Faculty Name",
                          textEditingController: facultyNameController, obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Email",
                          textEditingController: facultyEmailController, obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Phone Number",
                          textEditingController: facultyNumberController, obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Previous Experience",
                          textEditingController: previousExperienceController, obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (allSubjects.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: MultiSelectDialogField(
                                    items: allSubjects
                                        .map((subject) =>
                                            MultiSelectItem<String>(
                                                subject, subject))
                                        .toList(),
                                    initialValue: selectedSubjects,
                                    listType: MultiSelectListType.CHIP,
                                    onConfirm: (values) {
                                      context.read<AddFacultyBloc>().add(
                                          AddFacultySelectedSubjectsEvent(
                                              subjects:
                                                  List<String>.from(values)));
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      AddSubjectDialog().showAddSubjectDialog(
                                          context,
                                          subjectController,
                                          () => context
                                              .read<AddFacultyBloc>()
                                              .add(AddFacultyAddSubjectEvent(
                                                  subject:
                                                      subjectController.text,
                                                  context: context)));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final isFacultyNameNotNull =
                                    facultyNameController.text.isNotEmpty;
                                final isFacultyEmailNotNull =
                                    facultyEmailController.text.isNotEmpty;
                                final isFacultyNumberMustBeTenCharacters =
                                    facultyNumberController.text.length == 10;
                                final isPreviousExperienceNotNull =
                                    previousExperienceController
                                        .text.isNotEmpty;

                                if (isFacultyNameNotNull &&
                                    isFacultyEmailNotNull &&
                                    isFacultyNumberMustBeTenCharacters &&
                                    isPreviousExperienceNotNull) {
                                  context.read<AddFacultyBloc>().add(
                                        AddFacultyButtonPressed(
                                          context,
                                          facultyEntity: FacultyEntity(
                                            name: facultyNameController.text,
                                            previousExperience: int.parse(
                                                previousExperienceController
                                                    .text),
                                            mobileNumber:
                                                facultyNumberController.text,
                                            mailId: facultyEmailController.text,
                                            subjects: selectedSubjects,
                                          ),
                                        ),
                                      );

                                  facultyEmailController.clear();
                                  facultyNameController.clear();
                                  facultyNumberController.clear();
                                  previousExperienceController.clear();
                                } else {
                                  CustomSnackBar()
                                      .show(context, "Invalid Input");
                                }
                              },
                              child: const Text("Add"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
