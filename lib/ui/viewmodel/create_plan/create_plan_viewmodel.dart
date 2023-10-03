import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tfg_v2/di/dependency_injection.dart';
import 'package:tfg_v2/domain/model/errors.dart';
import 'package:tfg_v2/domain/model/plan.dart';
import 'package:tfg_v2/domain/model/plan_category.dart';
import 'package:tfg_v2/domain/repository/social/category_repository.dart';
import 'package:tfg_v2/domain/repository/social/plan_repository.dart';
import 'package:tfg_v2/domain/repository/social/user_repository.dart';
import 'package:tfg_v2/ui/navigation/navigator.dart';
import 'package:tfg_v2/ui/viewmodel/root_viewmodel.dart';
import 'package:tfg_v2/utils/datetime_utils.dart';

@Injectable()
class CreatePlanViewModel extends RootViewModel<CreatePlanViewState> {
  final CategoryRepository _categoryRepository;
  final PlanRepository _planRepository;
  final UserRepository _userRepository;

  CreatePlanViewModel(
    this._categoryRepository,
    this._planRepository,
    this._userRepository,
  ) : super(Loading());

  TfgNavigator get navigator => getIt<TfgNavigator>();

  List<PlanCategory> categories = [];
  final Set<String> selectedSubcategories = {};

  TimeOfDay get time => _time;
  TimeOfDay _time = TimeOfDay.now();

  DateTime get date => _date;
  DateTime _date = DateTime.now();

  int _maxUsers = 2;

  final String titleRegex = ""; // TODO
  final String descriptionRegex = ""; // TODO
  final String placeRegex = ""; // TODO

  @override
  void onAttach() async {
    categories = await _getCategories();
    emitValue(Success());
  }

  Future<List<PlanCategory>> _getCategories() async {
    final result = await _categoryRepository.getCategories();
    return result.fold(
      (left) => [],
      (right) => right,
    );
  }

  Future<void> finishOperation({
    required String title,
    required String description,
    required String place,
  }) async {
    final currentUsername = await _userRepository.getCurrentLoggedUsername();
    if (currentUsername.isLeft) return;

    // TODO: handle errors
    final result = await _planRepository.createPlan(
      plan: Plan.createPlan(
        title: title,
        description: description,
        place: place,
        date: DateTimeUtils.getDateTimeFromDateAndTime(
          date: _date,
          time: _time,
        ),
        categories: selectedSubcategories.toList(),
        maxUsers: _maxUsers,
      ),
      creatorUsername: currentUsername.right,
    );

    result.fold(
      (left) => print("Error: $left"), // TODO: handle error
      (right) => navigator.replaceToHome(),
    );
  }

  void addOrDeletePlanCategory({
    required String subcategory,
    bool isAdd = true,
  }) {
    isAdd
        ? selectedSubcategories.add(subcategory)
        : selectedSubcategories.remove(subcategory);
    emitValue(Success());
  }

  void setTime(TimeOfDay time) {
    _time = time;
    emitValue(Success());
  }

  void setDate(DateTime date) {
    _date = date;
    emitValue(Success());
  }

  void setMaxUsers(int max) => _maxUsers = max;
}

sealed class CreatePlanViewState extends ViewState {}

class Loading extends CreatePlanViewState {}

class Success extends CreatePlanViewState {
  Success();
}

class Error extends CreatePlanViewState {
  final AppError error;

  Error(this.error);
}
