import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final sl = GetIt.instance;

@injectableInit
void configureInjection() => $initGetIt(sl);
