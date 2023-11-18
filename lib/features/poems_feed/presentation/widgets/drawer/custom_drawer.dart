import 'package:flutter/material.dart';
import 'package:poetlum/features/poems_feed/presentation/pages/home/poems_feed.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_checkbox_tile.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_header.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_search_buttond.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_textfield.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _numberOfLinesController = TextEditingController();
  final TextEditingController _resultCountController = TextEditingController();

  @override
  Widget build(BuildContext context) => Drawer(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          const CustomDrawerHeader(),

          CustomTextField(hintText: 'Author', controller: _authorController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Title', controller: _titleController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Number of lines', isNumberInput: true, controller: _numberOfLinesController),
          const CustomSpacer(heightFactor: 0.04),

          CustomTextField(hintText: 'Result count', isNumberInput: true, controller: _resultCountController),
          const CustomSpacer(heightFactor: 0.04),

          const CustomCheckboxTile(),
          const CustomSpacer(heightFactor: 0.04),

          CustomSearchButton(
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
