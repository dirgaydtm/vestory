import 'package:drift/drift.dart';
// ignore: deprecated_member_use
import 'package:drift/web.dart';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      return DatabaseConnection(WebDatabase('db', logStatements: true));
    }),
  );
}
