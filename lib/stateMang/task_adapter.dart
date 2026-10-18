
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:taskaty_app/models/taskModel.dart';

// class TaskAdapter extends TypeAdapter<Taskmodel> {
//   // different type id for each type adapter
//   @override
//   final int typeId = 0;

//   @override
//   Taskmodel read(BinaryReader reader) {
//     return Taskmodel(
//       id: reader.readString(),
//       title: reader.readString(),
//       description: reader.readString(),
//       isCompleted: reader.readBool(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Taskmodel obj) {
//     writer.writeString(obj.id);
//     writer.writeString(obj.title);
//     writer.writeString(obj.description);
//     writer.writeBool(obj.isCompleted);
//   }
// }