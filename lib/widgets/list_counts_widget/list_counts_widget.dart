import 'package:flutter/material.dart';
import 'package:knit_count_v2/constants/constants.dart';
import 'package:knit_count_v2/model/model.dart';
import 'package:provider/provider.dart';


class ListCountsProviderWidget extends StatelessWidget {
  const ListCountsProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ListCountWidgetModel(),
        child: const ListCountsWidget());
  }
}


class ListCountsWidget extends StatelessWidget {
  const ListCountsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch <ListCountWidgetModel>();
    final _listCount = model.counts.length;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Счетчик вязания'),
      ),
      body: ListView.separated(
          itemCount: _listCount,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return CountCard(indexInList: index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.pushNamed(context, '/form');
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.add),


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
}



class CountCard extends StatelessWidget {
  final int indexInList;
  const CountCard({Key? key, required this.indexInList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = context.read <ListCountWidgetModel>();


    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: frontColor,
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Удалить счетчик?')
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Да', style: TextStyle(color: mainColor, fontSize: 15)),
                onPressed: () {
                  model.deleteCount(indexInList);
                  Navigator.of(context).pop();
                }
              ),
              TextButton(
                child: const Text('Нет', style: TextStyle(color: mainColor, fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return  Card(
      child: ListTile(
        tileColor: frontColor,
          onTap: () =>model.showCount(context, indexInList),
          leading: Image.asset('images/ball.png',width: 40),
          title: Text(model.counts[indexInList].nameCount),
          subtitle: Text(model.counts[indexInList].numberCount.toString() + ' ряд.'),
          trailing: IconButton(
              onPressed: () => _showMyDialog(),
              icon: const Icon(Icons.delete, color: Colors.deepOrange,))
      ),
      elevation: 8,
      shadowColor: mainColor,
    );
  }
}
