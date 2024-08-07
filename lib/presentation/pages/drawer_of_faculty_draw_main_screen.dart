import 'package:flutter/material.dart';
import 'package:nricse/data/data_source/data.dart';
// Import the theme colors

class DrawerOfFacultyDrawMainScreen extends StatelessWidget {
  const DrawerOfFacultyDrawMainScreen({
    super.key,
    required this.changeUpdate,
    required this.currentScreen,
  });

  final Function(int) changeUpdate;
  final int currentScreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Drawer(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: mainThemeColor),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Adjust padding if necessary
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    foregroundImage: AssetImage("assets/images/teacher.png"),
                    radius: 50,
                  ),
                  Text(
                    "Faculty",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
                    child: Column(
                      children: [
                        ...listContentDrawerForFaculty.map((e) {
                          int index = listContentDrawerForFaculty.indexOf(e);
                          if (index != 1) {
                            return InkWell(
                              onTap: () {
                                changeUpdate(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ListTile(
                                  tileColor: mainThemeColor.withOpacity(
                                      currentScreen == index ? 0.8 : 0.3),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  title: Text(
                                    e.toString(),
                                    style: TextStyle(
                                        color: currentScreen == index
                                            ? Colors.white
                                            : Colors.black38),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: mainThemeColor.withOpacity(0.3),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    e.toString(),
                                  ),
                                  collapsedShape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  textColor: currentScreen == index
                                      ? Colors.white
                                      : Colors.black38,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ...listOfAcademics.map((e) {
                                            int academicIndex =
                                                listOfAcademics.indexOf(e);
                                            int overallIndex = listContentDrawerForFaculty.length + academicIndex;
                                            return InkWell(
                                              onTap: () {
                                                changeUpdate(overallIndex);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 2,
                                                    bottom: 2,
                                                    top: 2),
                                                child: ListTile(
                                                  tileColor: mainThemeColor
                                                      .withOpacity(currentScreen ==
                                                              overallIndex
                                                          ? 0.8
                                                          : 0.3),
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  title: Text(
                                                    e.toString(),
                                                    style: TextStyle(
                                                        color: currentScreen ==
                                                                overallIndex
                                                            ? Colors.white
                                                            : Colors.black38),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }).toList()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
