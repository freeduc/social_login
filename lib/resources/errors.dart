class Exceptions implements Exception {
  Exceptions([this.msg]);

  final String? msg;

  static Exceptions connectServerFailed = Exceptions('서버와 통신하지 못했습니다.');
  static Exceptions testError = Exceptions('testest');

  @override
  String toString() {
    if (msg == null) return 'Exception';
    return msg!;
  }
}
