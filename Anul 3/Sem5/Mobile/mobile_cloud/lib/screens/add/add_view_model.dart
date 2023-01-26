import 'package:mobile_cloud/models/teacher/teacher.dart';
import 'package:mobile_cloud/repo/teacher_repo.dart';

class AddViewModel {
  final TeacherRepo _repo;

  AddViewModel(this._repo);

  Future<bool> addTeacher(Teacher teacher) {
    return _repo.addTeacher(teacher);
  }
}
