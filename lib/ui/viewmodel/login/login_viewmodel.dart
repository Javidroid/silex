import 'package:injectable/injectable.dart';
import 'package:tfg_v2/di/dependency_injection.dart';
import 'package:tfg_v2/domain/model/errors.dart';
import 'package:tfg_v2/ui/navigation/navigator.dart';
import 'package:tfg_v2/ui/viewmodel/root_viewmodel.dart';

@Injectable()
class LoginViewModel extends RootViewModel<LoginViewState> {
  TfgNavigator get navigator => getIt<TfgNavigator>();

  LoginViewModel() : super(Loading());

  @override
  void onAttach() async {
    emitValue(Success());
  }

  // TODO: check epueyo
  // TODO: set user in sharedPreferences
}

sealed class LoginViewState extends ViewState {}

class Loading extends LoginViewState {}

class Success extends LoginViewState {
  Success();
}

class Error extends LoginViewState {
  final AppError error;

  Error(this.error);
}