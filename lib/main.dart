import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/hive_constant.dart';
import 'package:flutter_application_1/model/word_type_adapter.dart';
import 'package:flutter_application_1/test/personAdaptor.dart';
import 'package:flutter_application_1/test/testScreen.dart';
import 'package:flutter_application_1/view/Screens/home.dart';
import 'package:flutter_application_1/view/Style/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  /****  adaptor call */
  Hive.registerAdapter(WordTypeAdapter());
  // open box
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WriteDataCubit(),
          ),
          BlocProvider(
            create: (context) => ReadDataCubit()..getWords(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getAppTheme(),
          home: const Home(),
          //testScreen(),
        ));
  }
}
