import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_textfield.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

class CollectionBottomSheetContent extends StatelessWidget {
  CollectionBottomSheetContent({super.key, required this.poems});

  final List<PoemEntity>? poems;
  final TextEditingController _collectionNameController = TextEditingController();
  final MultiSelectController<PoemEntity> _selectController = MultiSelectController();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height / 1.15,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        const CustomSpacer(heightFactor: 0.05),
        const _TitleTextWidget(),
        const CustomSpacer(heightFactor: 0.05),
        _CollectionNameInputWidget(controller: _collectionNameController),
        const CustomSpacer(heightFactor: 0.05),
        _PoemSelectionWidget(controller: _selectController, poems: poems),
        const CustomSpacer(heightFactor: 0.05),
        _CreateButtonWidget(
          collectionName: _collectionNameController.text, 
          selectController: _selectController,
        ),
        TextButton(onPressed: (){
          print(_selectController.selectedOptions.length);
          print(_selectController.selectedOptions.map((e) => e.value!).toList());
        }, child: Text('check'))
      ],
    ),
  );
}

class _TitleTextWidget extends StatelessWidget {
  const _TitleTextWidget();

  @override
  Widget build(BuildContext context) => const Text(
      'Create a collection',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
}

class _CollectionNameInputWidget extends StatelessWidget {
  const _CollectionNameInputWidget({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => CustomTextField(hintText: 'Collection name', controller: controller);
}

class _PoemSelectionWidget extends StatelessWidget {
  const _PoemSelectionWidget({required this.controller, this.poems});

  final MultiSelectController<PoemEntity> controller;
  final List<PoemEntity>? poems;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width / 1.35,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.35,
        child: MultiSelectDropDown(
          borderRadius: 4,
          borderWidth: 1.5,
          backgroundColor: Colors.transparent,
          hint: 'Select a poem to add',
          controller: controller,
          onOptionSelected: (selectedOptions) {},
          options: poems == null 
            ? <ValueItem<PoemEntity>>[]
            : poems!.map(
              (poem) => ValueItem<PoemEntity>(label: '${poem.author ?? ''}: ${poem.title}', value: poem),
            ).toList(),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
        ),
      ),
    );
}

class _CreateButtonWidget extends StatelessWidget {
  const _CreateButtonWidget({required this.collectionName, required this.selectController});

  final String collectionName;
  final MultiSelectController<PoemEntity> selectController; 

  @override
  Widget build(BuildContext context) => FilledButton.tonal(
      onPressed: () async {
        print(selectController.selectedOptions.length);
        print(selectController.selectedOptions.map((e) => e.value!).toList());

        if(selectController.selectedOptions.isEmpty){
          await _showNegativeToast('Please select at least one poem to add to the collection');
        } else if(collectionName.isEmpty){
          await _showNegativeToast('Please provide the name for the collection');
        }
        else{
          await context.read<FirebaseDatabaseCubit>().createNewCollection(
            userId: getIt<UserRepository>().getCurrentUser().userId!, 
            collectionName: collectionName, 
            poems: selectController.selectedOptions.map(
              (selectedOption) => selectedOption.value!,
            ).toList(),
          );
        }
      }, 
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('Create'),
      ),
    );

  Future<void> _showNegativeToast(String error) async{
    await Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
