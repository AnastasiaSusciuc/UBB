import 'package:mobile_cloud/models/teacher/teacher.dart';
import 'package:mobile_cloud/repo/teacher_repo.dart';


class EditViewModel {
  final TeacherRepo _repo;

  EditViewModel(this._repo);

  Future<bool> updateTeacher(Teacher teacher) {
    return _repo.updateTeacher(teacher);
  }
}
