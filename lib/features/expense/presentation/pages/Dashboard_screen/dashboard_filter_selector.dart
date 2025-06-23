import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/dashboard_filter.dart';
import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';


class DashboardFilterSelector extends StatelessWidget {
  final DashboardFilter selected;
  const DashboardFilterSelector({super.key, required this.selected});
  @override
  Widget build(BuildContext context) {
    return DropdownButton<DashboardFilter>(
      value: selected,
      onChanged: (DashboardFilter? value) {
        if (value != null) {
          context.read<DashboardBloc>().add(LoadDashboardData(filter: value));
        }
      },
      items: DashboardFilter.values.map((filter) {
        return DropdownMenuItem(
          value: filter,
          child: Text(_filterLabel(filter)),
        );
      }).toList(),
    );
  }

  String _filterLabel(DashboardFilter filter) {
    switch (filter) {
      case DashboardFilter.thisMonth:
        return 'This Month';
      case DashboardFilter.last7Days:
        return 'Last 7 Days';
      case DashboardFilter.all:
      default:
        return 'All';
    }
  }
}
