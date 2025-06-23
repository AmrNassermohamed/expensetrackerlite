import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/expense_item_card.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/widgets/balance_card.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/widgets/blue_decored_background.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/widgets/bottom_nav_bar.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/widgets/dashboard_header.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/widgets/recent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/injection_container.dart' as di;
import '../../../../../core/enums/dashboard_filter.dart';
import '../../bloc/add_expense/add_expense_bloc.dart';
import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';
import '../add_expense_screen/add_expense_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const LoadDashboardData(filter: DashboardFilter.thisMonth));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        context.read<DashboardBloc>().add(const LoadMoreExpenses());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  const BlueDecorBackground(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DashboardHeader(),
                        const SizedBox(height: 20),
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            if (state is DashboardLoaded) {
                              return BalanceCard(
                             
                       
                                 balance:    state.balance, income:          state.totalIncome, expense: state.totalExpense,
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RecentHeader(),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoaded) {
                        return ListView.separated(
                          controller: _scrollController,
                          itemCount: state.expenses.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            final item = state.expenses[index];
                            return ExpenseItemCard(item:item);
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF246BFD),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BlocProvider<AddExpenseBloc>(
                create: (_) => di.sl<AddExpenseBloc>(),
                child:  AddExpenseScreen(),
              )),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavBar(),

    );
  }

}
