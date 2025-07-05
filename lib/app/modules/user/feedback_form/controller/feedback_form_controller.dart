import 'package:feedback_app/app/models/question_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/models/sarcasm_model.dart';
import 'package:feedback_app/app/modules/user/feedback_form/repository/feedback_form_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/feedback_model.dart';
import '../models/clauses_model.dart';
import '../models/field_model.dart';
import '../models/send_email_model.dart';
import '../models/sentiment_model.dart';

class FeedbackFormController extends GetxController {
  FeedbackFormRepository feedbackFormRepository =
      Get.find<FeedbackFormRepository>();
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
        feedback.field = selectedField.value;
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
            contentController.text: "Tiêu cực",
          }
        ];
        feedbackFormRepository.submitFeedback(feedback).then((id) {
          isSending.value = false;
          sendEmail(
              feedback.field!,
              formatClausesAsNumberedListFromListMap(
                  feedback.clausesSentiment!, contentController.text),
              feedback.title ?? 'Góp ý từ người dùng',
              id);
          showFeedbackSuccessDialog();
        }).catchError((error) {
          Get.snackbar("Lỗi", "Không thể gửi góp ý. Vui lòng thử lại sau.");
        });
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

        feedbackFormRepository.submitFeedback(feedback).then((id) {
          isSending.value = false;
          if (hasNegative && feedback.status == "Đang xử lý") {
            sendEmail(
                feedback.field!,
                formatClausesAsNumberedListFromListMap(
                    feedback.clausesSentiment!, contentController.text),
                feedback.title ?? 'Góp ý từ người dùng',
                id);
          }
          isSending.value = false;
          showFeedbackSuccessDialog();
        }).catchError((error) {
          Get.snackbar("Lỗi", "Không thể gửi góp ý. Vui lòng thử lại sau.");
        });
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

      feedbackFormRepository.submitQuestion(question).then((id) {
        if (question.status == "Đang xử lý") {
          sendEmail(question.field!, contentController.text,
              question.title ?? 'Câu hỏi từ người dùng', id);
        }
        isSending.value = false;
        showFeedbackSuccessDialog();
      }).catchError((error) {
        Get.snackbar("Lỗi", "Không thể gửi câu hỏi. Vui lòng thử lại sau.");
      });
    }
  }

  //send email
  Future<void> sendEmail(
      String field, String message, String subject, String id) async {
    switch (field) {
      case "Thủ tục" ||
            "Khảo thí" ||
            "Xét tốt nghiệp" ||
            "Giáo vụ" ||
            "Kế hoạch":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.pdt23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Dịch vụ sinh viên" || "Thực tập":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.tttnsv23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Học phí":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.hp23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Cơ sở vật chất":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.csvc23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Công nghệ thông tin":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.cntt23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Hỗ trợ Học viên Sau đại học":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.vsdh23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      case "Đào tạo trực tuyến":
        feedbackFormRepository.sendEmail(SendEmailModel(
          recipient_email: "hsu.dttt23164@gmail.com",
          message: createEmailFormattedContent(message, id),
          subject: subject,
        ));
        break;
      default:
        print("Không có email liên hệ cho lĩnh vực này: $field");
        break;
    }
  }

  String createEmailFormattedContent(String text, String id) {
    final now = DateTime.now();
    final formattedDate =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return '''
  <html>
  <body style="font-family: Arial, sans-serif; color: #333;">
    <h4 style="color: black;">BÁO CÁO GÓP Ý / CÂU HỎI CẦN XỬ LÝ</h4>
    <p><b>- Thời gian:</b> $formattedDate</p>
    <hr style="color: black;">
    $text
    <a href="https://docs.google.com/forms/d/e/1FAIpQLSdXFMX7CLVrRH7gm9NYy-XhgAC3txYi6bbLLJbdhU4Ky-0noQ/viewform?usp=pp_url&entry.1390513214=$id" style="color: blue; text-decoration: underline;">
  Xử lý feedback tại đây</a>
    <hr>
    <p style="color: gray;">Hệ thống sẽ tiếp tục gửi thông báo khi có nội dung tương tự.</p>
  </body>
  </html>
  ''';
  }

  String formatClausesAsNumberedListFromListMap(
      List<Map<String, String>> listMap, String originalText) {
    String result = '';

    result += '<h4 style="color: black;">- Bản gốc:</h4>\n';
    result +=
        '<p style="color: black;">${originalText.replaceAll('\n', '<br>')}</p>\n';

    result += '<h4 style="color: black;">- Các mệnh đề và cảm xúc:</h4>\n';
    result += '<ol>\n';

    for (var item in listMap) {
      item.forEach((clause, sentiment) {
        final isNegative = sentiment.toLowerCase().contains("tiêu cực");
        final emoji = isNegative ? '❗' : '';
        final style = isNegative
            ? 'color:red; font-weight:bold;'
            : 'color:green; font-weight:bold;';
        result +=
            '<li style="color: black;">$clause: <span style="$style">$emoji $sentiment</span></li>\n';
      });
    }

    result += '</ol>\n';

    return result;
  }

  void showFeedbackSuccessDialog() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (_) => CupertinoAlertDialog(
        title: Text(
          'Góp ý đã được gửi',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Góp ý của bạn đã được gửi tới bộ phận liên quan, vui lòng theo dõi thông báo phản hồi. Cảm ơn bạn rất nhiều.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            isDefaultAction: true,
            child: Text(
              'Đồng ý',
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ],
      ),
    );
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
