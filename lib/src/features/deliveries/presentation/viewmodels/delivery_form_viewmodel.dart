import 'dart:io';

import 'package:ezy_pod/src/core/commons/custom_text_controller.dart';
import 'package:ezy_pod/src/features/deliveries/data/repositories/delivery_repository_impl.dart';
import 'package:ezy_pod/src/features/deliveries/domain/repositories/delivery_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class DeliveryFormViewModel with ChangeNotifier {
  final Ref _ref;

  DeliveryFormViewModel(this._ref);

  final DeliveryRepository _deliveryRepository = DeliveryRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /*=================Delivered Form Screen =====================*/

  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  CustomTextController personNameCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  final _signatureController = SignatureController();
  Uint8List? _signatureBytes;

  SignatureController get signatureController => _signatureController;

  Uint8List? get signatureBytes => _signatureBytes;

  TextEditingController notes = TextEditingController();

  void clearSignaturePad() {
    _signatureBytes = null;
    _signatureController.clear();
    notifyListeners();
  }

  Future<void> saveSignatureValue() async {
    final bytes = await _signatureController.toPngBytes();

    _signatureBytes = bytes;

    notifyListeners();
  }

  void onChange(
      {required CustomTextController con,
      String? Function(String?)? validator,
      required String value}) {
    if (validator != null) {
      con.error = validator(value);
    }
    setEnableBtn();
  }

  void setEnableBtn() {
    if (personNameCon.controller.text.isNotEmpty) {
      if (personNameCon.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  bool _isCheckBox = false;

  bool get isCheckBox => _isCheckBox;

  void setCheckBox(bool? value) {
    _isCheckBox = value ?? false;
    notifyListeners();
  }

  File? uploadedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> imageOptionClick(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      uploadedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void removeUploadedImg() {
    uploadedImage = null;
    notifyListeners();
  }
}
