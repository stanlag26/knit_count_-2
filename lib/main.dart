import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:knit_count_v2/widgets/my_app/my_app.dart';
import 'package:wakelock/wakelock.dart';

import 'domain/entity/count.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await Hive.initFlutter();
  Hive.registerAdapter(CountAdapter());
  runApp(  const MyApp());
}
