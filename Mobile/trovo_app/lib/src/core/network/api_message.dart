/// Lightweight envelope for simple `{ status, message, data }` API responses.
///
/// Used by action endpoints that only need to surface a success flag and a
/// human-readable message (change password, delete account, etc.). Kept as a
/// plain class so it requires no code generation.
class ApiMessage {
  const ApiMessage({
    required this.status,
    required this.message,
    this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory ApiMessage.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status'] ?? json['success'];
    return ApiMessage(
      status: rawStatus is bool ? rawStatus : rawStatus != null,
      message: (json['message'] ?? json['msg'] ?? '').toString(),
      data: json['data'],
    );
  }
}
