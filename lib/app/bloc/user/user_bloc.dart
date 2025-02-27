import 'package:bloc/bloc.dart';
import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/domain/repository/user_repository.dart';
import 'package:double_v_partners/app/domain/usecase/user/delete_user_usecase.dart';
import 'package:double_v_partners/app/domain/usecase/user/edit_user_usecase.dart';
import 'package:double_v_partners/app/domain/usecase/user/fetch_user_usecase.dart';
import 'package:double_v_partners/app/domain/usecase/user/save_user_usecase.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<SaveUserEvent>((event, emit) async => await _saveUser(event, emit));
    on<EditUserEvent>((event, emit) async => await _editUser(event, emit));
    on<FetchUserEvent>((_, emit) async => await _fetchUser(emit));
    on<DeleteUserEvent>((_, emit) async => await _deleteUser(emit));
    on<UserInitialEvent>((_, emit) => emit(UserInitialState()));
  }

  Future<void> _editUser(
    EditUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      final useCase = EditUserUsecase(userRepository: userRepository);

      final user = await useCase.call(event.user);

      emit(UserUpdatedState(user: user));
    } catch (e) {
      emit(UserErrorState());
    }
  }

  Future<void> _saveUser(
    SaveUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      final useCase = SaveUserUsecase(userRepository: userRepository);

      final response = await useCase.call(event.user);
      if (response) {
        emit(UserSavedState());
      }
    } catch (e) {
      emit(UserErrorState());
    }
  }

  Future<void> _fetchUser(Emitter<UserState> emit) async {
    emit(UserLoadingState());

    try {
      final useCase = FetchUserUsecase(userRepository: userRepository);

      final response = await useCase.call(null);
      emit(UserFetchedState(user: response));
    } catch (e) {
      emit(UserErrorState());
    }
  }

  Future<void> _deleteUser(
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());

    try {
      final useCase = DeleteUserUsecase(userRepository: userRepository);

      final response = await useCase.call(null);
      if (response) {
        emit(UserDeletedState());
      }
    } catch (e) {
      emit(UserErrorState());
    }
  }
}
