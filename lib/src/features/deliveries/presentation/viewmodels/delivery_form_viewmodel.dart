import 'dart:io';

import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/commons/custom_text_controller.dart';
import 'package:ezy_pod/src/core/enums/snackbar_status.dart';
import 'package:ezy_pod/src/features/deliveries/data/repositories/delivery_repository_impl.dart';
import 'package:ezy_pod/src/features/deliveries/domain/repositories/delivery_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class DeliveryFormViewModel with ChangeNotifier {



  final DeliveryRepository _deliveryRepository = DeliveryRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /*=================Delivered Form Screen =====================*/

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

  Future<void> submit(
      {required Function(
              {required SnackBarType snackType, required String message})
          showSnackBarMsg}) async {
    if (personNameCon.controller.text.isNotEmpty &&
        personNameCon.error == null) {
      if (_signatureBytes != null) {
        if (uploadedImage != null) {
          CustomNavigation().pop();
          showSnackBarMsg(
              message: "Delivered form submitted successfully",
              snackType: SnackBarType.success);
        } else {
          showSnackBarMsg(
              message: "Please upload image to proceed",
              snackType: SnackBarType.error);
        }
      } else {
        showSnackBarMsg(
            message: "Please upload signature to proceed",
            snackType: SnackBarType.error);
      }
    } else {
      showSnackBarMsg(
          message: "Please enter person name", snackType: SnackBarType.error);
    }

    notifyListeners();
  }

  /*=================Undelivered Form Screen =====================*/

  bool isDropdownExpanded = false;
  bool showBottomBorder = false;

  List<String> reasonsList = [
    "Recipient Absent",
    "Incorrect Address",
    "Failed Delivery Attempts",
    "Delivery Restrictions",
    "Weather or Natural Disasters",
    "Logistical Issues,",
    "Recipient Refusal"
  ];

  setDropdownExpansion(AnimationController animationController) {
    isDropdownExpanded = !isDropdownExpanded;
    if (isDropdownExpanded) {
      animationController.forward();
      showBottomBorder = isDropdownExpanded;
    } else {
      animationController.reverse();
      Future.delayed(const Duration(milliseconds: 500), () {
        showBottomBorder = isDropdownExpanded;
        notifyListeners();
      });
    }

    notifyListeners();
  }

  String? undeliveredReason;

  setReasonValue(AnimationController animationController, String value) {
    undeliveredReason = value;
    setDropdownExpansion(animationController);
  }

  void undelivered(
      {required Function(
              {required SnackBarType snackType, required String message})
          showSnackBarMsg}) {
    if (uploadedImage != null) {
      if (undeliveredReason != null) {
        CustomNavigation().pop();
        showSnackBarMsg(
            message: "Undelivered form submitted successfully",
            snackType: SnackBarType.success);
      } else {
        showSnackBarMsg(
            message: "Please select reason", snackType: SnackBarType.error);
      }
    } else {
      showSnackBarMsg(
          message: "Please upload image to proceed",
          snackType: SnackBarType.error);
    }
  }
}
