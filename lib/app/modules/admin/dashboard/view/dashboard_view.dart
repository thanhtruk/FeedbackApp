import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../controller/dashboard_controller.dart';
import '../model/yearly_feedback_stats.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông kê Góp ý sinh viên',
          style: TextStyle(
              color: AppColors.lightWhite,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
        iconTheme: IconThemeData(color: AppColors.lightWhite),
        backgroundColor: AppColors.bluePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              return controller.issues.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : buildPieCharts(controller.yearlyFeedbackStats);
            }),
            SizedBox(height: 20),
            _buildTopIssuesSection(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bluePrimary,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {},
              child: Text(
                'Xem tất cả Góp ý',
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildPieCharts(List<YearlyFeedbackStats> stats) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: stats.map((stat) {
  //       var sections = <PieChartSectionData>[
  //         if (stat.positive > 0)
  //           PieChartSectionData(
  //             value: stat.positive.toDouble(),
  //             title: 'Tích cực\n${stat.positive}',
  //             color: AppColors.positiveStatColor,
  //             radius: 70,
  //             titleStyle:
  //                 const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //           ),
  //         if (stat.negative > 0)
  //           PieChartSectionData(
  //             value: stat.negative.toDouble(),
  //             title: 'Tiêu cực\n${stat.negative}',
  //             color: AppColors.negativeStatColor,
  //             radius: 70,
  //             titleStyle:
  //                 const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //           ),
  //         if (stat.neutral > 0)
  //           PieChartSectionData(
  //             value: stat.neutral.toDouble(),
  //             title: 'Trung lập\n${stat.neutral}',
  //             color: AppColors.neutralStatColor,
  //             radius: 70,
  //             titleStyle:
  //                 const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //           ),
  //       ];
  //
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const SizedBox(height: 20),
  //           Text('Thống kê số lượng góp ý năm ${stat.year}',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.bluePrimary.withOpacity(0.8))),
  //           const SizedBox(height: 10),
  //           SizedBox(
  //             height: 250,
  //             child: Container(
  //               margin:
  //                   const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: const [
  //                   BoxShadow(
  //                     color: Colors.black12,
  //                     blurRadius: 8,
  //                     offset: Offset(0, 4),
  //                   ),
  //                 ],
  //               ),
  //               child: PieChart(
  //                 PieChartData(
  //                   sections: sections,
  //                   centerSpaceRadius: 30,
  //                   sectionsSpace: 2,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildPieCharts(List<YearlyFeedbackStats> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: stats.map((stat) {
        var sections = <PieChartSectionData>[
          if (stat.positive > 0)
            PieChartSectionData(
              value: stat.positive.toDouble(),
              color: AppColors.positiveStatColor,
              radius: 70,
              showTitle: false,
            ),
          if (stat.negative > 0)
            PieChartSectionData(
              value: stat.negative.toDouble(),
              color: AppColors.negativeStatColor,
              radius: 70,
              showTitle: false,
            ),
          if (stat.neutral > 0)
            PieChartSectionData(
              value: stat.neutral.toDouble(),
              color: AppColors.neutralStatColor,
              radius: 70,
              showTitle: false,
            ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Thống kê số lượng góp ý năm ${stat.year}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.bluePrimary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 30,
                    sectionsSpace: 2,
                  ),
                ),
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      _buildLegendItem(AppColors.positiveStatColor, 'Tích cực',
                          stat.positive),
                      _buildLegendItem(AppColors.negativeStatColor, 'Tiêu cực',
                          stat.negative),
                    ],
                  ),
                  _buildLegendItem(
                      AppColors.neutralStatColor, 'Trung lập', stat.neutral),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildLegendItem(Color color, String label, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text('$label ($value)',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget buildBarChart(List<YearlyFeedbackStats> stats) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: stats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: safeDouble(stat.positive),
                color: Colors.blue,
                width: 8,
              ),
              BarChartRodData(
                toY: safeDouble(stat.negative),
                color: Colors.red,
                width: 8,
              ),
              BarChartRodData(
                toY: safeDouble(stat.neutral),
                color: Colors.grey,
                width: 8,
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = safeInt(value, stats.length);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8,
                  child: Text(
                    stats[index].year,
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double safeDouble(num? value) {
    if (value == null || value.isNaN || value.isInfinite) return 0.0;
    return value.toDouble();
  }

  int safeInt(double value, int max) {
    if (value.isNaN || value.isInfinite) return 0;
    final i = value.toInt();
    return (i >= 0 && i < max) ? i : 0;
  }

  Widget _buildTopIssuesSection() {
    return Obx(() {
      final groups = controller.topIssueGroups;

      if (groups.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Không có vấn đề nổi bật nào.'),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Các vấn đề được sinh viên góp ý nhiều',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.bluePrimary.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: 12),
          ...groups.map((group) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Về ${group.category}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  ...group.issues.map((issue) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(issue.fieldDetail),
                        trailing: TextButton(
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.ADMIN_FEEDBACK_LIST,
                              arguments: issue.feedbacks,
                            );
                          },
                          child: Text('Chi tiết'),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
          SizedBox(height: 8),
        ],
      );
    });
  }
}
