import 'package:flutter/material.dart';
import 'package:knit_count_v2/constants/constants.dart';
import 'package:knit_count_v2/model/model.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/count.dart';


//  Создаем дополнительный класс чтобы обернуть в Provider
class EditCountProviderWidget extends StatelessWidget {
   const EditCountProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List dataCount = ModalRoute.of(context)!.settings.arguments as List;
    return  ChangeNotifierProvider.value(
        value: ListCountWidgetModel(),
        child: EditCountWidget(dataCount: dataCount,));
  }
}


class EditCountWidget extends StatefulWidget {
  final List dataCount;
  const EditCountWidget({Key? key, required this.dataCount}) : super(key: key);

  @override
  State<EditCountWidget> createState() => _EditCountWidgetState();
}

class _EditCountWidgetState extends State<EditCountWidget> {
  @override
  Widget build(BuildContext context) {

    final Count dataCount = widget.dataCount[0];
    final int countKey = widget.dataCount[1];
    final String nameCount = dataCount.nameCount;
    final model = context.read <ListCountWidgetModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать проект'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child:  ListView(
          children:  [
             const SizedBox(height: 30),
            TextField(
              controller: TextEditingController(text: nameCount),
              onChanged: (value) {
                model.name = value;
                },

              autofocus: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: textFieldColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1,color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1,color: Colors.grey),
                ),
                labelStyle: TextStyle(color: mainColor),
                labelText:'Измените название',

              ),

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.SaveEditCount(context, countKey, model.name);
          },
        backgroundColor:mainColor,
        child: const Icon(Icons.done),
      ),
    );
  }
}