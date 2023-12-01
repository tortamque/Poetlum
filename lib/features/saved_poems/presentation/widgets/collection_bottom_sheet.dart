import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/drawer/custom_textfield.dart';

class ColectionBottomSheetContent extends StatelessWidget {
  ColectionBottomSheetContent({super.key, required this.poems});

  final List<PoemEntity>? poems;
  final TextEditingController _collectionNameController = TextEditingController();
  final MultiSelectController<PoemEntity> _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: MediaQuery.of(context).size.height/1.15,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        const CustomSpacer(heightFactor: 0.05),
        const Text(
          'Create a collection',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const CustomSpacer(heightFactor: 0.05),
        CustomTextField(hintText: 'Collection name', controller: _collectionNameController),
        const CustomSpacer(heightFactor: 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.35,
          child: MultiSelectDropDown(
            borderRadius: 4,
            borderWidth: 1.5,
            backgroundColor: Colors.transparent,
            hint: 'Select a poem to add',
            controller: _controller,
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
        const CustomSpacer(heightFactor: 0.05),
        FilledButton.tonal(onPressed: (){}, child: const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),child: Text("Create")))
      ],
    ),
  );
}
