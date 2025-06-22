import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../controller/dashboard_controller.dart';
import '../model/feedback_issue.dart'; 

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
            _buildPieChart(),
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

  Widget _buildPieChart() {
    return Obx(() {
      final total = controller.totalFeedback.value.toDouble();
      final positive = controller.positiveFeedback.value.toDouble();
      final negative = controller.negativeFeedback.value.toDouble();

      return Column(
        children: [
          Text(
            'Thống kê số lượng góp ý\nNăm học 2024-2025',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 55,
                    sections: [
                      PieChartSectionData(
                        value: negative,
                        color: Colors.pinkAccent.withOpacity(0.8),
                        radius: 60,
                        title: '',
                      ),
                      PieChartSectionData(
                        value: positive,
                        color: AppColors.bluePrimary,
                        radius: 60,
                        title: '',
                      ),
                    ],
                  ),
                  swapAnimationDuration: Duration(milliseconds: 300),
                  swapAnimationCurve: Curves.easeInOut,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${total.toInt()}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendDot(Colors.pinkAccent.withOpacity(0.8)),
                      Text('${negative.toInt()}'),
                      SizedBox(width: 16),
                      _buildLegendDot(AppColors.bluePrimary),
                      Text('${positive.toInt()}'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildLegendDot(Color color) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTopIssuesSection() {
    return Obx(() {
      final issues = controller.topIssues;

      Map<String, List<FeedbackIssue>> grouped = {};
      for (var issue in issues) {
        grouped.putIfAbsent(issue.category, () => []).add(issue);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ...entry.value.map((issue) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(issue.title),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text('Chi tiết'),
                  ),
                );
              }).toList(),
              SizedBox(height: 10),
            ],
          );
        }).toList(),
      );
    });
  }
}
