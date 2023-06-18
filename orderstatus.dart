import 'package:flutter/cupertino.dart';

class orderStatusProvider with ChangeNotifier {
  Map<String, bool> _paymentStatusMap = {};

  bool getPaymentStatus(String orderNumber) {
    return _paymentStatusMap[orderNumber] ?? false;
  }

  void updatePaymentStatus(String orderNumber, bool isSuccess) {
    _paymentStatusMap[orderNumber] = isSuccess;
    notifyListeners();
  }
}