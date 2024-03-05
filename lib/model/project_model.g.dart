// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectModelAdapter extends TypeAdapter<ProjectModel> {
  @override
  final int typeId = 1;

  @override
  ProjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectModel(
      totalTask: fields[0] as int,
      completedTask: fields[1] as int,
      dueDate: fields[2] as DateTime,
      title: fields[3] as String,
      description: fields[4] as String,
      category: fields[5] as String,
      taskList: (fields[6] as List).cast<SubTaskModel>(),
      id: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.totalTask)
      ..writeByte(1)
      ..write(obj.completedTask)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.taskList)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
