
import 'package:flutter/material.dart';
import 'package:knit_count_v2/constants/constants.dart';
import 'package:knit_count_v2/domain/entity/count.dart';
import 'package:knit_count_v2/model/model.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';


class CountKnitWidgetProvider extends StatelessWidget {
   const CountKnitWidgetProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List dataCount = ModalRoute.of(context)!.settings.arguments as List;
    return ChangeNotifierProvider.value(
        value: ListCountWidgetModel(),
        child: CountKnitWidget(dataCount: dataCount,));
  }


}





class CountKnitWidget extends StatefulWidget {
 final List dataCount;
   const CountKnitWidget({Key? key, required this.dataCount}) : super(key: key);

  @override
  State<CountKnitWidget> createState() => _CountKnitWidgetState();
}

class _CountKnitWidgetState extends State<CountKnitWidget> {


  @override
  Widget build(BuildContext context) {
    final Count dataCount = widget.dataCount[0];
    final int countKey = widget.dataCount[1];
    final String nameCount = dataCount.nameCount;
    final int numberCount = dataCount.numberCount;
    final String notesCount = dataCount.notesCount;
    final model = context.read <ListCountWidgetModel>();

    void plus (){
      model.plus(dataCount, countKey);
      setState(() {
      });
    }
    void minus (){
      model.minus(dataCount, countKey);
      setState(() {
      });
    }
    void zero (){
      model.zero(dataCount, countKey);
      setState(() {
      });
    }


    return Scaffold(
      appBar: AppBar(
        title:  Text(nameCount),
        actions: [
          IconButton(
              onPressed: () =>  model.editCount(context, countKey),
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: mainColor,
                      ),
                      onPressed: () => plus(),
                      child:FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('$numberCount',
                          maxLines: 1,
                          style: const TextStyle(fontSize: 200,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),

                // const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => minus(),
                    onLongPress: () => zero(),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            mainColor)),
                    child: const Text('Отнять \\ Обнулить')),
                const SizedBox(height: 20),
                TextField(
                  minLines: 10,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromRGBO(128, 116, 214, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    hintText: 'В этом поле можно сохранять свои заметки.\n '
                        'При нажатии на число, счетчик увеличивается.\n'
                        'При нажатии на "Отнять \\ Обнулить", счетчик убавится на 1, при долгом нажатии, обнулится.',
                  ),
                 onChanged:(value) => model.comment(dataCount, countKey, value),
                 // model.numberCount = int.tryParse(value)?? 0,
                 controller: TextEditingController(text: notesCount),


                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.exit_to_app_sharp),
      ),
    );
  }
}
