// ignore_for_file: avoid_print

import 'package:datos_03/helpers/user_preference.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreference userPreference = UserPreference();
  await userPreference.initPrefers();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameControler = TextEditingController();
  final surnameControler = TextEditingController();
  final ageControler = TextEditingController();

  List<String> myMusic = [];

  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    UserPreference userPreference = UserPreference();

    nameControler.text = userPreference.name;
    surnameControler.text = userPreference.surname;
    ageControler.text = userPreference.age.toString();

    myMusic = userPreference.favoriteMusic;

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("app para guardar datos 03")),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameControler,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4), hintText: "Nombre"),
              onChanged: (String value) {
                setState(() {
                  userPreference.name = value;
                });
              },
            ),
            TextField(
              controller: surnameControler,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4), hintText: "Apellido"),
              onChanged: (String value) {
                setState(() {
                  userPreference.surname = value;
                });
              },
            ),
            TextField(
              controller: ageControler,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4), hintText: "Edad"),
              onChanged: (String value) {
                try {
                  setState(() {
                    userPreference.age = int.parse(value);
                  });
                } catch (e) {
                  print("error en la conversion");
                }
              },
            ),
            DropdownButton(
                value: userPreference.married,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    child: Text("Casado"),
                    value: true,
                  ),
                  DropdownMenuItem(
                    child: Text("Soltero"),
                    value: false,
                  )
                ],
                onChanged: (bool? value) {
                  print(value);
                  setState(() {
                    userPreference.married = value!;
                  });
                }),
            musicCheckbox(),
            const Spacer(),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  nameControler.text = "";
                  surnameControler.text = "";
                  ageControler.text = "";
                  myMusic = [];
                  userPreference.clean();
                  setState(() {});
                },
                child:
                    const Text("reset", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    ));
  }

  Widget musicCheckbox() {
    final music = ['rock', 'pop', 'clasica', 'remix'];

    return Column(
      children: music
          .map(
            (m) => CheckboxListTile(
                title: Text(m),
                secondary: Icon(Icons.music_note_sharp),
                value: userPreference.favoriteMusic.contains(m),
                onChanged: (_) {
                  if (!myMusic.contains(m)) {
                    myMusic.add(m);
                  } else {
                    myMusic.remove(m);
                  }
                  userPreference.favoriteMusic = myMusic;
                  setState(() {});
                  print(userPreference.favoriteMusic);
                }),
          )
          .toList(),
    );
  }
}
