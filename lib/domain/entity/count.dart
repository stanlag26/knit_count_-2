import 'package:hive/hive.dart';

part 'count.g.dart';

@HiveType(typeId: 1)
class Count extends HiveObject {
  @HiveField(0)
  String nameCount;

  @HiveField(1)
  String notesCount;

  @HiveField(2)
  int numberCount;

  Count(
      {required this.nameCount,
      required this.notesCount,
      required this.numberCount});
  @override
  String toString() => 'Название: $nameCount, Заметки: $notesCount, Счетчик: $numberCount';
}

//команда для генерации  flutter packages pub run build_runner watch
