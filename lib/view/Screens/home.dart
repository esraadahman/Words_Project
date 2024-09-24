import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';
import 'package:flutter_application_1/view/widgets/add/addword_dialog.dart';
import 'package:flutter_application_1/view/widgets/add/colorWidget.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/filter_dialog_button.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/language_filter.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/wordsWidget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                size.width(20),
                const LanguageFilterWidget(),
                const Spacer(),
                const FilterDialogButton(),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            size.height(10),
            SizedBox(
                height: MediaQuery.sizeOf(context).height * .85,
                child: Wordswidget()),
          ],
        ),
      ),
      floatingActionButton: _getfloatactionbutton(context),
    );
  }

  FloatingActionButton _getfloatactionbutton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddWordDialog(),
        );
      },
      backgroundColor: ColorManager.white,
      child: const Icon(
        Icons.add,
        color: ColorManager.black,
      ),
    );
  }
}
