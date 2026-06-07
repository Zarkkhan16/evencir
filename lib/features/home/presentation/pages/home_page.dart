import 'package:evencir_app/app/di/injection.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:evencir_app/features/home/presentation/cubit/home_state.dart';
import 'package:evencir_app/features/home/presentation/widgets/dashboard_content.dart';
import 'package:evencir_app/features/home/presentation/widgets/home_header.dart';
import 'package:evencir_app/features/home/presentation/widgets/month_calendar_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _initialDate = DateTime(2024, 12, 22);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..load(_initialDate),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late DateTime _sheetFocusedDay;
  late DateTime _sheetSelectedDay;

  @override
  void initState() {
    super.initState();
    _sheetFocusedDay = HomePage._initialDate;
    _sheetSelectedDay = HomePage._initialDate;
  }

  void _openMonthCalendar(DateTime currentDate) {
    setState(() {
      _sheetFocusedDay = currentDate;
      _sheetSelectedDay = currentDate;
    });

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return MonthCalendarSheet(
              focusedDay: _sheetFocusedDay,
              selectedDay: _sheetSelectedDay,
              onPageChanged: (focused) {
                setSheetState(() => _sheetFocusedDay = focused);
                setState(() => _sheetFocusedDay = focused);
              },
              onDaySelected: (selected, focused) {
                setSheetState(() {
                  _sheetSelectedDay = selected;
                  _sheetFocusedDay = focused;
                });
                setState(() {
                  _sheetSelectedDay = selected;
                  _sheetFocusedDay = focused;
                });
                Navigator.pop(sheetContext);
                context.read<HomeCubit>().load(selected);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.status != HomeStatus.loading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == HomeStatus.loading && state.dashboard == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.failure && state.dashboard == null) {
            return Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            );
          }

          final dashboard = state.dashboard;
          if (dashboard == null) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBar(
                  selectedDate: dashboard.date,
                  onWeekTap: () => _openMonthCalendar(dashboard.date),
                ),
                WeekCalendarStrip(
                  selectedDate: dashboard.date,
                  onDateSelected: (date) =>
                      context.read<HomeCubit>().load(date),
                  onOpenMonthCalendar: () => _openMonthCalendar(dashboard.date),
                ),
                const SizedBox(height: AppSpacing.lg),
                DashboardContent(
                  dashboard: dashboard,
                  onLogWater: () =>
                      context.read<HomeCubit>().logWater(dashboard.date),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          );
        },
      ),
    );
  }
}
