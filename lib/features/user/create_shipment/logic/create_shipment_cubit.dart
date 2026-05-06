import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import '../data/models/create_shipment_request_body.dart';
import '../data/models/governorate_model.dart';
import '../data/repos/create_shipment_repo.dart';
import 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  final CreateShipmentRepo _repo;
  CreateShipmentCubit(this._repo) : super(const CreateShipmentState.initial());

  int currentStep = 0;

  List<GovernorateModel> governorates = [];

  GovernorateModel? startGovernorate;
  GovernorateModel? endGovernorate;
  double? startLat, startLng, endLat, endLng;

  final formKey = GlobalKey<FormState>();
  final TextEditingController objectController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  bool insurance = false;

  bool isEditMode = false;
  ShipmentModel? _shipmentToEdit;



  void _updateUI() {
    emit(CreateShipmentState.uiUpdated(DateTime.now().millisecondsSinceEpoch));
  }

  void changeStartGovernorate(GovernorateModel? gov) {
    startGovernorate = gov;
    startLat = null;
    startLng = null;
    _updateUI();
  }

  void changeEndGovernorate(GovernorateModel? gov) {
    endGovernorate = gov;
    endLat = null;
    endLng = null;
    _updateUI();
  }

  void updateLocation(bool isStart, double lat, double lng) {
    if (isStart) {
      startLat = lat;
      startLng = lng;
    } else {
      endLat = lat;
      endLng = lng;
    }
    _updateUI();
  }

  void updateInsurance(bool value) {
    insurance = value;
    _updateUI();
  }

  void nextStep() {
    if (currentStep == 0) {
      if (startGovernorate == null || endGovernorate == null || startLat == null || endLat == null) {
        emit(
          CreateShipmentState.submitError(
            ApiErrorModel(
              message: "يرجى تحديد المحافظات والمواقع على الخريطة أولاً",
            ),
          ),
        );
        _updateUI();
        return;
      }
    }

    else if (currentStep == 1) {
      if (!formKey.currentState!.validate()) return;
    }

    if (currentStep < 2) {
      currentStep++;
      _updateUI();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      _updateUI();
    }
  }

  void getGovernorates({ShipmentModel? shipmentToEdit}) async {
    if (shipmentToEdit != null) {
      isEditMode = true;
      _shipmentToEdit = shipmentToEdit;
    }
    if (isClosed) return;
    emit(const CreateShipmentState.govLoading());
    final result = await _repo.getGovernorates();
    if (isClosed) return;

    result.when(
      success: (govs) {
        if (govs.isEmpty) {
          emit(
            CreateShipmentState.govError(
              ApiErrorModel(message: "لا يوجد محافظات متاحة حالياً"),
            ),
          );
        } else {
          governorates = govs;
          if (isEditMode && _shipmentToEdit != null) {
            _editData(_shipmentToEdit!);
          }
          emit(CreateShipmentState.govSuccess(govs));
        }
      },
      failure: (error) => emit(CreateShipmentState.govError(error)),
    );
  }


  void _editData(ShipmentModel shipment) {
    weightController.text = shipment.weight.toString();
    heightController.text = shipment.height.toString();
    widthController.text = shipment.width.toString();
    lengthController.text = shipment.length.toString();
    objectController.text = shipment.object;
    insurance = shipment.insurance;
    
    startLat = double.tryParse(shipment.startPositionLat.toString());
    startLng = double.tryParse(shipment.startPositionLng.toString());
    endLat = double.tryParse(shipment.endPositionLat.toString());
    endLng = double.tryParse(shipment.endPositionLng.toString());

    try {
      startGovernorate = governorates.firstWhere((g) => g.id.toString() == shipment.startGovernorateId.toString());
      endGovernorate = governorates.firstWhere((g) => g.id.toString() == shipment.endGovernorateId.toString());
    } catch (e) {
      startGovernorate = null;
      endGovernorate = null;
    }
    _updateUI();
  }


  void submitShipment() async {
    if (isClosed) return;
    emit(const CreateShipmentState.submitLoading());

    final requestBody = CreateShipmentRequestBody(
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
      width: double.parse(widthController.text),
      length: double.parse(lengthController.text),
      object: objectController.text,
      insurance: insurance,
      startPositionLat: startLat!,
      startPositionLng: startLng!,
      endPositionLat: endLat!,
      endPositionLng: endLng!,
      startGovernorateId: startGovernorate!.id,
      endGovernorateId: endGovernorate!.id,
    );
    if (isEditMode) {
      final result = await _repo.updateShipment(requestBody);
      if (isClosed) return;
      result.when(
        success: (message) => emit(CreateShipmentState.submitSuccess(message)),
        failure: (error) => emit(CreateShipmentState.submitError(error)),
      );
    }
    else {
      final result = await _repo.createShipment(requestBody);
      if (isClosed) return;
      result.when(
        success: (message) => emit(CreateShipmentState.submitSuccess(message)),
        failure: (error) => emit(CreateShipmentState.submitError(error)),
      );
    }
  }


  @override
  Future<void> close() {
    objectController.dispose();
    weightController.dispose();
    heightController.dispose();
    widthController.dispose();
    lengthController.dispose();
    return super.close();
  }
  
}
