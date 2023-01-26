import '../../models/teacher/teacher.dart';
import '../../repo/teacher_repo.dart';

class HomeViewModel {
  final TeacherRepo _repo;

  HomeViewModel(this._repo);

  Future<List<Teacher>> getTeachers() {
    return _repo.getTeachers();
  }

  Future<bool> deleteTeachers(String id){
    print("Delete teacher");
    return _repo.deleteTeacher(id);
  }
}
