import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:knit_count_v2/domain/entity/count.dart';

class CountWidgetModel extends ChangeNotifier {
  String nameCount = '';
  String notesCount = '';
  int numberCount = 0;

  void saveCount(BuildContext context) async {
    if (nameCount.isEmpty) return;
    final box = await Hive.openBox<Count>('counts_box');
    final count = Count(
        nameCount: nameCount, notesCount: notesCount, numberCount: numberCount);
    await box.add(count); //  добавляем сохраненную группу в список
    Navigator.of(context).pop();
  }
}

/////////////////////////////////////////////////////////////////////
class ListCountWidgetModel extends ChangeNotifier {
  var _counts = <Count>[];
  String name = '';


  List<Count> get counts => _counts.toList();

  ListCountWidgetModel() {
    _setup();
  }

  void _readCountsFromHive(Box<Count> box) {
    _counts = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    final box = await Hive.openBox<Count>('counts_box');
    _readCountsFromHive(box);
    box.listenable().addListener(() => _readCountsFromHive(box));
  }

  void deleteCount(int index) async {
    final box = await Hive.openBox<Count>('counts_box');
    await box.deleteAt(index);
  }

  Count? dataCount;
  late int countKey;

  void showCount(BuildContext context, int index) async {
    final box = await Hive.openBox<Count>('counts_box');
    countKey = box.keyAt(index) as int;
    dataCount = box.get(countKey) as Count;
    Navigator.of(context).pushNamed('/count', arguments: [dataCount, countKey]);
  }

  void editCount(BuildContext context, int index) async {
    final box = await Hive.openBox<Count>('counts_box');
    dataCount = box.get(index) as Count;
    Navigator.of(context).pushNamed('/edit', arguments: [dataCount, index]);
  }

  void SaveEditCount(BuildContext context, int countKey, String name) async {
    final box = await Hive.openBox<Count>('counts_box');
    dataCount = box.get(countKey) as Count;
    if (name == '') {
      Navigator.pop(context);
      Navigator.pop(context);}
    else{
    Count newDataCount = Count(nameCount: name, notesCount: dataCount!.notesCount, numberCount: dataCount!.numberCount);
    box.put(countKey, newDataCount);
    // Navigator.pushNamed(context, '/');
    Navigator.pop(context);
    Navigator.pop(context);
    }
  }

  void plus(Count dataCount, int countKey) async {
    final box = await Hive.openBox<Count>('counts_box');
    dataCount.numberCount++;
    box.put(countKey, dataCount);
  }

  void minus(Count dataCount, int countKey) async {
    final box = await Hive.openBox<Count>('counts_box');
    if (dataCount.numberCount > 0) {
      dataCount.numberCount--;
    } else {
      dataCount.numberCount = 0;
    }
    box.put(countKey, dataCount);
  }

  void zero(Count dataCount, int countKey) async {
    final box = await Hive.openBox<Count>('counts_box');
    dataCount.numberCount = 0;
    box.put(countKey, dataCount);
  }

  void comment(Count dataCount, int countKey, String value) async {
    final box = await Hive.openBox<Count>('counts_box');
    dataCount.notesCount = value;
    box.put(countKey, dataCount);
  }
}
