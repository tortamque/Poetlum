// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/toast_manager.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_state.dart';

class UpdateCollectionBottomSheetContent extends StatefulWidget {
  const UpdateCollectionBottomSheetContent({super.key, this.allSavedPoems, this.poemsInTheCollection, required this.collectionName});

  final List<PoemEntity>? allSavedPoems;
  final List<PoemEntity>? poemsInTheCollection;
  final String collectionName;

  @override
  State<UpdateCollectionBottomSheetContent> createState() => _UpdateCollectionBottomSheetContentState();
}

class _UpdateCollectionBottomSheetContentState extends State<UpdateCollectionBottomSheetContent> {
  late MultiSelectController<PoemEntity> _selectController;
  late List<ValueItem<PoemEntity>> selectedValues = <ValueItem<PoemEntity>>[];
  late List<ValueItem<PoemEntity>> allValues = <ValueItem<PoemEntity>>[];

  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(
      name: 'update_collection',
      parameters: {
        'opened': 'true',
      },
    );
        
    _selectController = MultiSelectController();

    _initPoemsInTheCollectionValues();
    _initAllSavedPoemsValues();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 3,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _initPoemsInTheCollectionValues(){
    if(widget.poemsInTheCollection != null){
      selectedValues = widget.poemsInTheCollection!.map(
        (poem) => ValueItem(label: '${poem.author}: ${poem.title}', value: poem),
      ).toList();
    }
  }

  void _initAllSavedPoemsValues(){
    if(widget.allSavedPoems != null){
      allValues = widget.allSavedPoems!.map(
        (poem) => ValueItem(label: '${poem.author}: ${poem.title}', value: poem),
      ).toList();
    }
  }

  @override
  void dispose() {
    _selectController.dispose();
    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height / 1.15,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        const CustomSpacer(heightFactor: 0.05),
        RightAnimation(
          animationField: animationController.animationStates[0],
          positionInitialValue: MediaQuery.of(context).size.width/8,
          child: const _TitleTextWidget(),
        ),
        const CustomSpacer(heightFactor: 0.05),

        RightAnimation(
          animationField: animationController.animationStates[1],
          positionInitialValue: MediaQuery.of(context).size.width/8,
          child: _PoemSelectionWidget(controller: _selectController, allValues: allValues, selectedValues: selectedValues),
        ),
        const CustomSpacer(heightFactor: 0.05),

        RightAnimation(
          animationField: animationController.animationStates[2],
          positionInitialValue: MediaQuery.of(context).size.width/8,
          child: _EditButtonWidget(selectController: _selectController, collectionName: widget.collectionName),
        ),
        const CustomSpacer(heightFactor: 0.05),
      ],
    ),
  );
}

class _TitleTextWidget extends StatelessWidget {
  const _TitleTextWidget();

  @override
  Widget build(BuildContext context) => const Text(
      'Edit the collection',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
}

class _PoemSelectionWidget extends StatelessWidget {
  const _PoemSelectionWidget({required this.controller, required this.allValues, required this.selectedValues});

  final MultiSelectController<PoemEntity> controller;
  final List<ValueItem<PoemEntity>> allValues;
  final List<ValueItem<PoemEntity>> selectedValues;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width / 1.35,
    child: MultiSelectDropDown(
      borderRadius: 4,
      borderWidth: 1.5,
      backgroundColor: Colors.transparent,
      hint: 'Select a poem to add',
      controller: controller,
      onOptionSelected: (selectedOptions) {},
      options: allValues,
      dropdownHeight: 300,
      selectedOptions: selectedValues,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    ),
  );
}

class _EditButtonWidget extends StatelessWidget {
  const _EditButtonWidget({required this.selectController, required this.collectionName});

  final MultiSelectController<PoemEntity> selectController; 
  final String collectionName;

  @override
  Widget build(BuildContext context) => BlocConsumer<FirebaseDatabaseCubit, FirebaseDatabaseState>(
    listener: (context, state) {
      if (state.status == FirebaseDatabaseStatus.error) {
        ToastManager.showNegativeToast('An error occurred :(');
      }
    },
    builder: (context, state) => state.status == FirebaseDatabaseStatus.submitting
      ? const CircularProgressIndicator()
      : FilledButton.tonal(
          onPressed: () async {
            if(selectController.selectedOptions.isEmpty){
              unawaited(
                FirebaseAnalytics.instance.logEvent(
                  name: 'update_collection',
                  parameters: {
                    'successful': 'true',
                    'error': 'Empty poems',
                  },
                ),
              );

              await ToastManager.showNegativeToast('Please select at least one poem to add to the collection');
            } else{
              unawaited(
                FirebaseAnalytics.instance.logEvent(
                  name: 'update_collection',
                  parameters: {
                    'collection_name': collectionName,
                    'updated_poems_count': selectController.selectedOptions.length.toString(),
                  },
                ),
              );

              await context.read<FirebaseDatabaseCubit>().updatePoemsInCollection(
                userId: getIt<UserRepository>().getCurrentUser().userId!,
                collectionName: collectionName,
                updatedPoems: selectController.selectedOptions.map(
                  (selectedOption) => selectedOption.value!,
                ).toList(),
              );
    
              await ToastManager.showPositiveToast('The collection has been successfully saved');
            }
          }, 
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Edit'),
          ),
        ),
  );
}
