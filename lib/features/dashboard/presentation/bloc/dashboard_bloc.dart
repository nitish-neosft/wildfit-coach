import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/dashboard_member.dart';
import '../../domain/usecases/get_dashboard_data.dart';
import '../../domain/usecases/get_members.dart';
import '../../domain/usecases/get_member_details.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData getDashboardData;
  final GetMembers getMembers;
  final GetMemberDetails getMemberDetails;

  DashboardBloc({
    required this.getDashboardData,
    required this.getMembers,
    required this.getMemberDetails,
  }) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<LoadMembers>(_onLoadMembers);
    on<LoadMemberDetails>(_onLoadMemberDetails);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await getDashboardData();
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(DashboardAuthError(failure.message));
        } else if (failure is NetworkFailure) {
          emit(DashboardNetworkError(failure.message));
        } else {
          emit(DashboardError(failure.message));
        }
      },
      (dashboardData) => emit(DashboardLoaded(dashboardData)),
    );
  }

  Future<void> _onLoadMembers(
    LoadMembers event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await getMembers();
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(DashboardAuthError(failure.message));
        } else if (failure is NetworkFailure) {
          emit(DashboardNetworkError(failure.message));
        } else {
          emit(DashboardError(failure.message));
        }
      },
      (members) => emit(MembersLoaded(members)),
    );
  }

  Future<void> _onLoadMemberDetails(
    LoadMemberDetails event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await getMemberDetails(event.memberId);
    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(DashboardAuthError(failure.message));
        } else if (failure is NetworkFailure) {
          emit(DashboardNetworkError(failure.message));
        } else if (failure is NotFoundFailure) {
          emit(MemberNotFound(failure.message));
        } else {
          emit(DashboardError(failure.message));
        }
      },
      (member) => emit(MemberDetailsLoaded(member)),
    );
  }
}
