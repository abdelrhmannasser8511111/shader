import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shader/controller/bloc.dart';
import 'package:shader/controller/responsiveUiController.dart';
import 'package:shader/model/moshtry.dart';
import 'package:shader/model/resala.dart';
import 'package:shader/view/screens/mainPageItems/main1page.dart';
import 'package:shader/view/screens/mainPageItems/main2page.dart';
import 'package:shader/view/screens/mainPageItems/main3page.dart';
import 'package:shader/view/widget/sideBarItemWidget.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'controller/dataRepo.dart';
import 'controller/dbController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

 await SqlHelper.chekDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // brightness: Brightness.dark,
          // primaryColor: Colors.transparent,
          ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar'), // English
        // Spanish
      ],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  setstatefunc() => setState(() {});

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            mainOpenPageforSideBar == 1
                ? Main1page()
                : mainOpenPageforSideBar == 2
                    ? Main2page()
                    : Main3page(),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.black,
            ),
            //Color(0xffeff3f2)
            Container(
              color: Color(0xffeff3f2),
              width: screenWidth * 0.1,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  SideBarItemWidget(
                      name: 'الصفحة الرئيسية',
                      iconshape: Icons.home_outlined,
                      screenNumb: 1,
                      vcallback: setstatefunc),
                  SideBarItemWidget(
                    name: 'الفواتير',
                    iconshape: Icons.view_list_outlined,
                    screenNumb: 2,
                    vcallback: setstatefunc,
                  ),
                  SideBarItemWidget(
                      name: 'تقارير سريعة',
                      iconshape: Icons.equalizer_outlined,
                      screenNumb: 3,
                      vcallback: setstatefunc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
