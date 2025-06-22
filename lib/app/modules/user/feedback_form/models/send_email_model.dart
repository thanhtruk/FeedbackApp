class SendEmailModel {
  String? recipient_email;
  String? message;
  String? subject;

  SendEmailModel({
    this.recipient_email,
    this.message,
    this.subject,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipient_email': recipient_email,
      'message': message,
      'subject': subject,
    };
  }
}
