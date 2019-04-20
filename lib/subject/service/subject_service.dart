import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/service/subject_repository.dart';

class SubjectService {
  static List<Subject> findAll() {
    return SubjectRepository.findAll();
  }

  static void saveAll(List<Subject> subjects) {
    for (Subject subject in subjects) {
      SubjectRepository.save(subject);
    }
  }
}