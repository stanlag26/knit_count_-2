import 'package:flutter/material.dart';
import 'package:knit_count_v2/constants/constants.dart';
import 'package:knit_count_v2/model/model.dart';
import 'package:provider/provider.dart';


//  Создаем дополнительный класс чтобы обернуть в Provider
class AddCountProviderWidget extends StatelessWidget {
  const AddCountProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => CountWidgetModel(),
    child: const AddCountWidget());
  }
}


class AddCountWidget extends StatelessWidget {
  const AddCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read <CountWidgetModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новый проект'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child:  ListView(
          children:  [
            const SizedBox(height: 30),
            TextField(
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
                labelText:
                'Введите название проекта',

              ),
              onChanged: (value) => model.nameCount = value,
              onEditingComplete: () =>
                  model.saveCount(context),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.number,
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
                labelStyle: TextStyle(
                    color: mainColor),
                labelText: 'С какого ряда начать',
                hintText: '0',
              ),
              onChanged: (value) => model.numberCount = int.tryParse(value)?? 0,
              onEditingComplete: () =>
                  model.saveCount(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.saveCount(context),
        backgroundColor:mainColor,
        child: const Icon(Icons.done),
      ),
    );
  }
}