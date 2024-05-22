import 'package:ezy_pod/src/features/auth/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final userProvider = StateProvider<User?>((ref) => null);
const int routingDuration = 300;
double inputFieldHeight = 44.sp;
double hMargin = 30.sp;
