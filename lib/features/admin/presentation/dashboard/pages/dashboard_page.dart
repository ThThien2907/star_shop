import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_cubit.dart';
import 'package:star_shop/features/presentation/order/bloc/order_display_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<OrderDisplayCubit, OrderDisplayState>(
            builder: (context, state) {
          if (state is OrderDisplayInitialState) {
            context.read<OrderDisplayCubit>().getOrder(true);
          }

          if (state is OrderDisplayLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is OrderDisplayLoadFailure) {
            return Center(
              child: AppErrorWidget(
                onPress: () {
                  context.read<OrderDisplayCubit>().getOrder(true);
                },
              ),
            );
          }

          if (state is OrderDisplayLoaded) {
            var listOrder = state.listOrder;

            DateTime now = DateTime.now();
            DateTime dayNow = DateTime(now.year, now.month, now.day);
            var listOrderToday = listOrder.where((e) {
              return e.createdAt.toDate().isAfter(dayNow) &&
                  e.createdAt
                      .toDate()
                      .isBefore(dayNow.add(const Duration(days: 1)));
            }).toList();

            DateTime startOfCurrentMonth = DateTime(now.year, now.month, 1);
            DateTime endOfCurrentMonth = calculateNextMonth(startOfCurrentMonth)
                .subtract(const Duration(days: 1));
            var listOrderCurrentMonth = listOrder.where((e) {
              return e.createdAt.toDate().isAfter(startOfCurrentMonth) &&
                  e.createdAt.toDate().isBefore(endOfCurrentMonth);
            }).toList();

            DateTime startOfLastMonth = calculateLastMonth(startOfCurrentMonth);
            DateTime endOfLastMonth =
                startOfCurrentMonth.subtract(const Duration(days: 1));
            var listOrderLastMonth = listOrder.where((e) {
              return e.createdAt.toDate().isAfter(startOfLastMonth) &&
                  e.createdAt.toDate().isBefore(endOfLastMonth);
            }).toList();

            DateTime startOf2MonthAgo = calculateLastMonth(startOfLastMonth);
            DateTime endOf2MonthAgo =
                startOfLastMonth.subtract(const Duration(days: 1));
            var listOrder2MonthAgo = listOrder.where((e) {
              return e.createdAt.toDate().isAfter(startOf2MonthAgo) &&
                  e.createdAt.toDate().isBefore(endOf2MonthAgo);
            }).toList();

            num inComToday = 0;
            num inComCurrentMonth = 0;
            num inComLastMonth = 0;
            num inCom2MonthAgo = 0;

            for (var i in listOrderToday) {
              if (i.status != 'Canceled') {
                inComToday += i.totalPrice;
              }
            }
            for (var i in listOrderCurrentMonth) {
              if (i.status != 'Canceled') {
                inComCurrentMonth += i.totalPrice;
              }
            }
            for (var i in listOrderLastMonth) {
              if (i.status != 'Canceled') {
                inComLastMonth += i.totalPrice;
              }
            }
            for (var i in listOrder2MonthAgo) {
              if (i.status != 'Canceled') {
                inCom2MonthAgo += i.totalPrice;
              }
            }
            num max = inComCurrentMonth;
            if (max < inComLastMonth) {
              max = inComLastMonth;
            }
            if (max < inCom2MonthAgo) {
              max = inCom2MonthAgo;
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Incom Today',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.textColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '\$$inComToday',
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Order Number',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.textColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                listOrderToday.length.toString(),
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: BarChart(BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: max < 10000 ? 10000 : 100000,
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                              toY: inCom2MonthAgo.toDouble(),
                              color: Colors.blue,
                              width: 16),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                              toY: inComLastMonth.toDouble(),
                              color: Colors.blue,
                              width: 16),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                              toY: inComCurrentMonth.toDouble(),
                              color: Colors.green,
                              width: 16),
                        ],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            String text;
                            switch (value.toInt()) {
                              case 0:
                                text =
                                    '${startOf2MonthAgo.month}/${startOf2MonthAgo.year}';
                                break;
                              case 1:
                                text =
                                    '${startOfLastMonth.month}/${startOfLastMonth.year}';
                                break;
                              case 2:
                                text = '${dayNow.month}/${dayNow.year}';
                                break;
                              default:
                                return Container();
                            }
                            return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                      color: AppColors.textColor, fontSize: 12),
                                ));
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                  )),
                ),
              ],
            );
          }

          return Container();
        }),
      ),
    );
  }

  DateTime calculateNextMonth(DateTime dateTime) {
    int year = dateTime.year;
    int newMonth = dateTime.month + 1;

    if (newMonth > 12) {
      year += 1;
      newMonth = 1;
    }
    return DateTime(year, newMonth, 1);
  }

  DateTime calculateLastMonth(DateTime dateTime) {
    int year = dateTime.year;
    int lastMonth = dateTime.month - 1;

    if (lastMonth <= 0) {
      year -= 1;
      lastMonth = 12;
    }
    return DateTime(year, lastMonth, 1);
  }
}
