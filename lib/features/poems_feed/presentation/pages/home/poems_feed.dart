import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';
import 'package:poetlum/features/poems_feed/presentation/widgets/poem_card.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class PoemsFeed extends StatelessWidget {
  const PoemsFeed({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    drawer: Drawer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
            
            const Center(
              child: Text(
                'Search settings',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              )
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth / 1.35;
      
                return Align(
                  child: SizedBox(
                    width: width,  
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Author',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth / 1.35;
      
                return Align(
                  child: SizedBox(
                    width: width,  
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth / 1.35;
      
                return Align(
                  child: SizedBox(
                    width: width,  
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Number of lines',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth / 1.35;
      
                return Align(
                  child: SizedBox(
                    width: width,  
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Result count',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            CheckboxListTile(
              value: true, 
              onChanged: (value){},
              title: Text('Return random poems?'),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            CustomSpacer(height: MediaQuery.of(context).size.height * 0.04),
      
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth / 1.35;
      
                return Align(
                  child: SizedBox(
                    width: width,
                    child: FilledButton(
                      onPressed: (){}, 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.5),
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                      )
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    ),
    body: _buildBody(),
  );

  BlocBuilder<RemotePoemBloc, RemotePoemState> _buildBody() => BlocBuilder<RemotePoemBloc, RemotePoemState>(
    builder: (_, state){
      if(state is RemotePoemLoading){
        return const Center(child: CircularProgressIndicator(),);
      } 

      if(state is RemotePoemError){
        return const Center(child: Icon(Icons.refresh));
      }

      if(state is RemotePoemDone){
        return ListView.builder(
          itemCount: state.poems!.length,
          itemBuilder: (__, index) => PoemCard(
            poemEntity: state.poems![index],
          ),
        );
      }

      return const SizedBox();
    },
  );
}
