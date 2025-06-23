import 'package:equatable/equatable.dart';
import '../../../../../core/enums/dashboard_filter.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class LoadDashboardData extends DashboardEvent {
  final DashboardFilter filter;
  final int page;

  const LoadDashboardData({required this.filter, this.page = 1});

  @override
  List<Object> get props => [filter, page];
}
class LoadMoreExpenses extends DashboardEvent {
  const LoadMoreExpenses();

  @override
  List<Object?> get props => [];
}