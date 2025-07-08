import 'package:feedback_app/app/service/email_service.dart';

import '../models/send_email_model.dart';

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

Future<void> sendEmail(
    String field, String message, String subject, String id) async {
  switch (field) {
    case "Thủ tục" || "Khảo thí" || "Xét tốt nghiệp" || "Giáo vụ" || "Kế hoạch":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "hsu.pdt23164@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Dịch vụ sinh viên" || "Thực tập":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "hsu.tttnsv23164@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Học phí":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "sylviapham23@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Cơ sở vật chất":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "thanh.truc.pham.782003@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Công nghệ thông tin":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "hanqhoa01@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Hỗ trợ Học viên Sau đại học":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "hanqhoa02@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    case "Đào tạo trực tuyến":
      EmailService.sendEmail(SendEmailModel(
        recipient_email: "trukstudy01@gmail.com",
        message: createEmailFormattedContent(message, id),
        subject: subject,
      ));
      break;
    default:
      print("Không có email liên hệ cho lĩnh vực này: $field");
      break;
  }
}
