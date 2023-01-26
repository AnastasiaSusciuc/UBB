import 'package:floor/floor.dart';
import 'package:mobile_cloud/models/teacher/teacher.dart';

@dao
abstract class TeacherDao {
  @Query('SELECT * FROM Teacher')
  Future<List<Teacher>> findAllTeachers();

  @Query('SELECT * FROM Teacher WHERE id = :id')
  Future<Teacher?> findTeacherById(String id);

  @insert
  Future<void> insertTeacher(Teacher teacher);

  @delete
  Future<void> deleteTeacher(Teacher teacher);

  @update
  Future<void> updateTeacher(Teacher teacher);
}