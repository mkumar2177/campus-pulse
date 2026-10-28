import 'package:campus_pulse_server/src/generated/endpoints.dart';
import 'package:campus_pulse_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

void run(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());
  await pod.start();
}
