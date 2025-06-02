import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
    try {
      final result = await getDashboardData();
      result.fold(
        (failure) => emit(DashboardError(failure.message)),
        (dashboardData) => emit(DashboardLoaded(dashboardData)),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onLoadMembers(
    LoadMembers event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final result = await getMembers();
      result.fold(
        (failure) => emit(DashboardError(failure.message)),
        (members) => emit(MembersLoaded(members)),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onLoadMemberDetails(
    LoadMemberDetails event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final result = await getMemberDetails(event.memberId);
      result.fold(
        (failure) => emit(DashboardError(failure.message)),
        (member) => emit(MemberDetailsLoaded(member)),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
