import 'package:ebandhu/di.dart';
import 'package:ebandhu/features/auth/auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  List<MapEntry<String, Map<IconData, Map<String, Function>>>> sections = [
    MapEntry("General", {
      Icons.person: {
        "Edit Profile": () {
          print("object");
        },
      },
      Icons.password: {"Change Password": () {}},
    }),
    MapEntry("Preferencess", {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: sections.length + 1,
        itemBuilder: (context, sectionIndex) {
          if (sectionIndex < sections.length) {
            final sectionTitle = sections[sectionIndex].key;
            final tiles = sections[sectionIndex].value.entries.toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    sectionTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...tiles.map((tileEntry) {
                  final icon = tileEntry.key;
                  final labelAction = tileEntry.value.entries.first;
                  final label = labelAction.key;
                  final action = labelAction.value;

                  return ListTile(
                    tileColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                    leading: Icon(icon),
                    title: Text(label),
                    onTap: () => action(),
                  );
                }),
              ],
            );
          } else {
            return ListTile(
              tileColor:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
              textColor: Colors.red,
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                sl<AuthBloc>().add(LogoutEvent());
              },
            );
          }
        },
      ),
    );
  }
}
