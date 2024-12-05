import '../../../../core/models.dart';
import '../repos/login_repo.dart';

class LogoutUseCase {
  final LoginRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<void>> call() {
    return repository.logoutUser();
  }
}
