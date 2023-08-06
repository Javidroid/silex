// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tfg_v2/data/datasource/local/default_local_datasource.dart'
    as _i6;
import 'package:tfg_v2/data/datasource/local/local_datasource.dart' as _i5;
import 'package:tfg_v2/data/datasource/remote/default_remote_datasource.dart'
    as _i10;
import 'package:tfg_v2/data/datasource/remote/remote_datasource.dart' as _i9;
import 'package:tfg_v2/data/services/api_service.dart' as _i3;
import 'package:tfg_v2/di/dependency_injection.dart' as _i17;
import 'package:tfg_v2/domain/model/user.dart' as _i8;
import 'package:tfg_v2/domain/repository/social/plan_repository.dart' as _i15;
import 'package:tfg_v2/domain/repository/social/user_repository.dart' as _i14;
import 'package:tfg_v2/env/environment.dart' as _i12;
import 'package:tfg_v2/ui/navigation/navigator.dart' as _i13;
import 'package:tfg_v2/ui/viewmodel/home/home_viewmodel.dart' as _i4;
import 'package:tfg_v2/ui/viewmodel/plans/plans_viewmodel.dart' as _i16;
import 'package:tfg_v2/ui/viewmodel/profile_viewmodel/profile_viewmodel.dart'
    as _i7;
import 'package:tfg_v2/ui/viewmodel/splash/splash_viewmodel.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiServiceModule = _$ApiServiceModule();
    final diModule = _$DiModule();
    gh.lazySingleton<_i3.ApiService>(() => apiServiceModule.httpClient);
    gh.factory<_i4.HomeViewModel>(() => _i4.HomeViewModel());
    gh.factory<_i5.LocalDatasource>(() => _i6.DefaultLocalDatasource());
    gh.factory<_i7.ProfileViewModel>(
        () => _i7.ProfileViewModel(user: gh<_i8.User>()));
    gh.factory<_i9.RemoteDatasource>(
        () => _i10.DefaultRemoteDatasource(gh<_i3.ApiService>()));
    gh.factory<_i11.SplashViewModel>(() => _i11.SplashViewModel());
    gh.singleton<_i12.TfgEnv>(diModule.env);
    gh.singleton<_i13.TfgNavigator>(diModule.navigator);
    gh.factory<_i14.UserRepository>(() => _i14.UserRepositoryImpl(
          gh<_i9.RemoteDatasource>(),
          gh<_i5.LocalDatasource>(),
        ));
    gh.factory<_i15.PlanRepository>(
        () => _i15.PlanRepositoryImpl(gh<_i9.RemoteDatasource>()));
    gh.factory<_i16.PlansViewModel>(
        () => _i16.PlansViewModel(gh<_i15.PlanRepository>()));
    return this;
  }
}

class _$ApiServiceModule extends _i3.ApiServiceModule {}

class _$DiModule extends _i17.DiModule {}
