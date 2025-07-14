import 'package:feedback_app/app/models/question_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/models/sarcasm_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/repository/feedback_form_repository.dart';
import 'package:feedback_app/app/modules/user/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';
import '../../../../utils/send_email.dart';
import '../../../../utils/show_success_dialog.dart';
import '../models/clauses_model.dart';
import '../models/field_model.dart';
import '../models/sentiment_model.dart';

class FeedbackFormController extends GetxController {
  FeedbackFormRepository feedbackFormRepository =
      Get.find<FeedbackFormRepository>();
  HomeController homeController = Get.find<HomeController>();
  final title = ''.obs;
  final content = ''.obs;
  final selectedField = RxnString();
  final selectedType = RxnString();
  final agreeToTerms = false.obs;
  final isSending = false.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    ever(isSending, (isSending) {
      if (isSending) {
        showIsSendingDialog();
      } else {
        Get.back(); // Đóng dialog khi gửi xong
        titleController.clear();
        contentController.clear();
        selectedField.value = null;
        selectedType.value = null;
        agreeToTerms.value = false;
      }
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  Future<void> submitFeedback() async {
    if (!agreeToTerms.value) {
      Get.snackbar("Lỗi", "Bạn cần đồng ý với điều khoản.");
      return;
    }

    if (titleController.text.isEmpty ||
        contentController.text.isEmpty ||
        selectedField.value == null) {
      Get.snackbar("Thiếu thông tin", "Vui lòng điền đầy đủ thông tin.");
      return;
    }

    isSending.value = true;

    final cleanedContent =
        await feedbackFormRepository.cleanInput(contentController.text);

    print("Cleaned content: $cleanedContent");
    if (selectedType.value == "Đánh giá") {
      FeedbackModel feedback = FeedbackModel(
        title: titleController.text,
        field: selectedField.value,
        fieldDetails: [],
        clausesSentiment: [],
        status: "Đang chờ duyệt",
        response: null,
        content: contentController.text,
      );

      //Nhận diện lĩnh vực từ nội dung
      Field field =
          await feedbackFormRepository.detectFieldFromText(cleanedContent);
      print("Detected field: ${field.lable}, details: ${field.fieldDetails}");
      feedback.fieldDetails = field.fieldDetails;

      if (selectedField.value == "Khác" && field.lable != "Khác") {
        feedback.field = field.lable;
        feedback.status = "Đang xử lý";
      } else if (selectedField.value != "Khác" &&
          selectedField.value == field.lable) {
        feedback.status = "Đang xử lý";
      }

      //Nhận diện mỉa mai từ nội dung
      Sarcasm sarcasm =
          await feedbackFormRepository.detectSarcasmFromText(cleanedContent);
      print(
          "Detected sarcasm: ${sarcasm.isSarcasm}, probability: ${sarcasm.probability}");
      if (sarcasm.isSarcasm && sarcasm.probability > 0.6) {
        //Đánh giá mỉa mai
        feedback.clausesSentiment = [
          {
            cleanedContent: "Tiêu cực",
          }
        ];
        await feedbackFormRepository.submitFeedback(feedback).then((id) {
          feedback.id = id;
          isSending.value = false;
          if (feedback.status == "Đang xử lý") {
            sendEmail(
                feedback.field!,
                formatClausesAsNumberedListFromListMap(
                    feedback.clausesSentiment!, contentController.text),
                feedback.title ?? 'Góp ý từ người dùng',
                id);
          }
          showFeedbackSuccessDialog(
              'Góp ý của bạn đã được gửi tới bộ phận liên quan, vui lòng theo dõi thông báo phản hồi. Cảm ơn bạn rất nhiều.');
        }).catchError((error) {
          Get.snackbar("Lỗi", "Không thể gửi góp ý. Vui lòng thử lại sau.");
        });
        print(feedback.id);
        homeController.feedbackList.insert(0, feedback);
      } else {
        //Đánh giá bình thường
        //Tách nội dung thành các mệnh đề
        Clauses clauses_list =
            await feedbackFormRepository.splitTextIntoClauses(cleanedContent);
        print("Clauses detected: ${clauses_list.all_clauses}");

        //Nhận diện cảm xúc của từng mệnh đề
        for (var clause in clauses_list.all_clauses) {
          Sentiment sentiment =
              await feedbackFormRepository.detectSentimentFromText(clause);
          print("Detected sentiment: ${sentiment.lable}");

          final label =
              (sentiment.probability > 0.6) ? sentiment.lable : "chưa xác định";
          feedback.clausesSentiment!.add({clause: label});

          if (label == "chưa xác định") {
            feedback.status = "Đang chờ duyệt";
          }
        }

        // Kiểm tra nếu có ít nhất 1 câu Tiêu cực
        final hasNegative = feedback.clausesSentiment!
            .any((map) => map.containsValue("Tiêu cực"));

        if (!hasNegative) {
          feedback.status = "Đã xử lý";
        }

        await feedbackFormRepository.submitFeedback(feedback).then((id) {
          feedback.id = id;
          isSending.value = false;
          if (feedback.status == "Đang xử lý") {
            sendEmail(
                feedback.field!,
                formatClausesAsNumberedListFromListMap(
                    feedback.clausesSentiment!, contentController.text),
                feedback.title ?? 'Góp ý từ người dùng',
                id);
          }
          isSending.value = false;
          showFeedbackSuccessDialog(
              'Góp ý của bạn đã được gửi tới bộ phận liên quan, vui lòng theo dõi thông báo phản hồi. Cảm ơn bạn rất nhiều.');
        }).catchError((error) {
          Get.snackbar("Lỗi", "Không thể gửi góp ý. Vui lòng thử lại sau.");
        });
        // Thêm vào dau danh sách phản ánh
        homeController.feedbackList.insert(0, feedback);
      }
    } else if (selectedType.value == "Câu hỏi") {
      QuestionModel question = QuestionModel(
        title: titleController.text,
        field: selectedField.value,
        fieldDetails: [],
        status: "Đang chờ duyệt",
        response: null,
        content: contentController.text,
      );

      //Nhận diện lĩnh vực từ nội dung
      Field field =
          await feedbackFormRepository.detectFieldFromText(cleanedContent);

      print("Detected field: ${field.lable}, details: ${field.fieldDetails}");
      question.fieldDetails = field.fieldDetails;

      if (selectedField.value == "Khác" && field.lable != "Khác") {
        question.field = field.lable;
        question.status = "Đang xử lý";
      } else if (selectedField.value != "Khác" &&
          selectedField.value == field.lable) {
        question.field = selectedField.value;
        question.status = "Đang xử lý";
      }

      await feedbackFormRepository.submitQuestion(question).then((id) {
        if (question.status == "Đang xử lý") {
          sendEmail(question.field!, contentController.text,
              question.title ?? 'Câu hỏi từ người dùng', id);
        }

        isSending.value = false;
        showFeedbackSuccessDialog(
            'Góp ý của bạn đã được gửi tới bộ phận liên quan, vui lòng theo dõi thông báo phản hồi. Cảm ơn bạn rất nhiều.');
      }).catchError((error) {
        Get.snackbar("Lỗi", "Không thể gửi câu hỏi. Vui lòng thử lại sau.");
      });
    }
  }

  void showIsSendingDialog() {
    showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: false, // tránh bị tắt khi chạm bên ngoài
      builder: (_) => CupertinoAlertDialog(
        title: const Text(
          'Đang gửi góp ý',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Vui lòng đợi trong giây lát, góp ý của bạn đang được gửi đi.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(), // loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
