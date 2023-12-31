// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/top_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/core/shared/presentation/widgets/toast_manager.dart';
import 'package:poetlum/features/application/presentation/widgets/drawer/custom_textfield.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_cubit.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_state.dart';

class CreateCollectionBottomSheetContent extends StatefulWidget {
  const CreateCollectionBottomSheetContent({super.key, required this.poems});

  final List<PoemEntity>? poems;

  @override
  State<CreateCollectionBottomSheetContent> createState() => _CreateCollectionBottomSheetContentState();
}

class _CreateCollectionBottomSheetContentState extends State<CreateCollectionBottomSheetContent> {
  late TextEditingController _collectionNameController;
  late MultiSelectController<PoemEntity> _selectController;

  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(
      name: 'create_collection',
      parameters: {
        'opened': 'true',
      },
    );
    _collectionNameController = TextEditingController();
    _selectController = MultiSelectController();
    animationController = AnimationControllerWithDelays(
      initialDelay: animationDelay,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 4,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _collectionNameController.dispose();
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

        TopAnimation(
          animationField: animationController.animationStates[0],
          positionInitialValue: MediaQuery.of(context).size.width/6,
          child: const _TitleTextWidget(),
        ),
        const CustomSpacer(heightFactor: 0.05),

        TopAnimation(
          animationField: animationController.animationStates[1],
          positionInitialValue: MediaQuery.of(context).size.width/6,
          child: _CollectionNameInputWidget(controller: _collectionNameController),
        ),
        const CustomSpacer(heightFactor: 0.05),

        TopAnimation(
          animationField: animationController.animationStates[2],
          positionInitialValue: MediaQuery.of(context).size.width/6,
          child: _PoemSelectionWidget(controller: _selectController, poems: widget.poems),
        ),
        const CustomSpacer(heightFactor: 0.05),

        TopAnimation(
          animationField: animationController.animationStates[3],
          positionInitialValue: MediaQuery.of(context).size.width/6,
          child: _CreateButtonWidget(
            textController: _collectionNameController, 
            selectController: _selectController,
          ),
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
  const _CreateButtonWidget({required this.textController, required this.selectController});

  final TextEditingController textController;
  final MultiSelectController<PoemEntity> selectController; 

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
            unawaited(
              FirebaseAnalytics.instance.logEvent(
                name: 'create_collection',
                parameters: {
                  'button_pressed': 'true',
                },
              ),
            );

            if(selectController.selectedOptions.isEmpty){
              unawaited(
                FirebaseAnalytics.instance.logEvent(
                  name: 'create_collection',
                  parameters: {
                    'success': 'false',
                    'error': 'Empty selected options',
                  },
                ),
              );

              await ToastManager.showNegativeToast('Please select at least one poem to add to the collection');
            } else if(textController.text.isEmpty){
              unawaited(
                FirebaseAnalytics.instance.logEvent(
                  name: 'create_collection',
                  parameters: {
                    'success': 'false',
                    'error': 'Empty collection name options',
                  },
                ),
              );

              await ToastManager.showNegativeToast('Please provide the name for the collection');
            }
            else{
              final isCollectionExist = await context.read<FirebaseDatabaseCubit>().isCollectionExists(
                collectionName: textController.text, 
                userId: getIt<UserRepository>().getCurrentUser().userId!,
              );

              if(!isCollectionExist){
                unawaited(
                  FirebaseAnalytics.instance.logEvent(
                    name: 'create_collection',
                    parameters: {
                      'success': 'true',
                      'collection_name': textController.text,
                      'poems_count': selectController.selectedOptions.length.toString(),
                    },
                  ),
                );

                await context.read<FirebaseDatabaseCubit>().createNewCollection(
                  userId: getIt<UserRepository>().getCurrentUser().userId!, 
                  collectionName: textController.text, 
                  poems: selectController.selectedOptions.map(
                    (selectedOption) => selectedOption.value!,
                  ).toList(),
                );
      
                await ToastManager.showPositiveToast('The collection has been successfully saved');
              } else{
                unawaited(
                  FirebaseAnalytics.instance.logEvent(
                    name: 'create_collection',
                    parameters: {
                      'success': 'false',
                      'error': 'Collection exists',
                    },
                  ),
                );

                await ToastManager.showNegativeToast('The collection with this name already exists');
              }
              
            }
          }, 
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Create'),
          ),
        ),
  );
}
