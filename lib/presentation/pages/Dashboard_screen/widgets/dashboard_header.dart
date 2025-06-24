import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/enums/dashboard_filter.dart';
import '../../../bloc/dashboard/dashboard_bloc.dart';
import '../../../bloc/dashboard/dashboard_event.dart';
import '../../../bloc/dashboard/dashboard_state.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // You can add a profile picture here if needed
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Good Morning\nShihab Rahman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            DashboardFilter current = DashboardFilter.thisMonth;
            if (state is DashboardLoaded) {
              current = state.filter;
            }

            return _FilterSelector(selected: current);
          },
        ),
      ],
    );
  }
}

class _FilterSelector extends StatelessWidget {
  final DashboardFilter selected;

  const _FilterSelector({required this.selected});

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
