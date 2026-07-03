import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_error_model.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/user/create_post/data/repo/create_post_repo.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';
import 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePostRepo _repo;
  CreatePostCubit(this._repo) : super(const CreatePostState.initial());

  int currentStep = 0;
  List<GovernorateModel> governorates = [];

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  GovernorateModel? startGovernorate;
  GovernorateModel? endGovernorate;
  double? startLat, startLng, endLat, endLng;

  final TextEditingController startDetailsCtrl = TextEditingController();
  final TextEditingController endDetailsCtrl = TextEditingController();

  final TextEditingController objectCtrl = TextEditingController();
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController widthCtrl = TextEditingController();
  final TextEditingController lengthCtrl = TextEditingController();
  
  DateTime? lastDate;
  // bool insurance = false;

  void _updateUI() => emit(CreatePostState.uiUpdated(DateTime.now().millisecondsSinceEpoch));

  Future<void> getGovernorates() async {
    if (isClosed) return;
    emit(const CreatePostState.govLoading());
    final result = await _repo.getGovernorates();
    result.when(
      success: (govs) {
        governorates = govs;
        emit(CreatePostState.govSuccess(govs));
      },
      failure: (err) => emit(CreatePostState.govError(err)),
    );
  }

  void changeStartGovernorate(GovernorateModel? gov) {
    startGovernorate = gov; startLat = null; startLng = null; _updateUI();
  }
  void changeEndGovernorate(GovernorateModel? gov) {
    endGovernorate = gov; endLat = null; endLng = null; _updateUI();
  }
  void updateLocation(bool isStart, double lat, double lng) {
    if (isStart) { startLat = lat; startLng = lng; } else { endLat = lat; endLng = lng; }
    _updateUI();
  }
  // void updateInsurance(bool value) { insurance = value; _updateUI(); }
  void updateDate(DateTime date) { lastDate = date; _updateUI(); }

  void nextStep() {
    if (currentStep == 0) {
      if (startGovernorate == null || endGovernorate == null || startLat == null || endLat == null) {
        emit(CreatePostState.submitError(ApiErrorModel(message: "يرجى تحديد المحافظات والمواقع على الخريطة أولاً")));
        _updateUI(); return;
      }
      if (!formKeyStep1.currentState!.validate()) return;
    } else if (currentStep == 1) {
      if (lastDate == null) {
        emit(CreatePostState.submitError(ApiErrorModel(message: "يرجى تحديد أقصى موعد للتوصيل")));
        _updateUI(); return;
      }
      if (!formKeyStep2.currentState!.validate()) return;
    }

    if (currentStep < 2) { currentStep++; _updateUI(); }
  }

  void previousStep() {
    if (currentStep > 0) { currentStep--; _updateUI(); }
  }

  Future<void> submitPostStepOne() async {
    if (isClosed) return;
    emit(const CreatePostState.loading());
    final requestBody = {
      'weight': double.parse(weightCtrl.text),
      'height': double.parse(heightCtrl.text),
      'width': double.parse(widthCtrl.text),
      'length': double.parse(lengthCtrl.text),
      'object': objectCtrl.text,
      // 'insurance': insurance ? 1 : 0,
      'start_position_lat': startLat,
      'start_position_lng': startLng,
      'end_position_lat': endLat,
      'end_position_lng': endLng,
      'start_governorate_id': startGovernorate!.id,
      'end_governorate_id': endGovernorate!.id,
      'start_location_details': startDetailsCtrl.text,
      'end_location_details': endDetailsCtrl.text,
      'last_date': "${lastDate!.year}-${lastDate!.month.toString().padLeft(2, '0')}-${lastDate!.day.toString().padLeft(2, '0')}",
    };

    final result = await _repo.createPost(requestBody);
    if (isClosed) return;
    result.when(
      success: (post) => emit(CreatePostState.stepOneSuccess(post, "تم نشر إعلان الشحنة وحساب الأسعار التقديرية بنجاح")),
      failure: (error) => emit(CreatePostState.submitError(error)),
    );
  }

  Future<void> confirmAndPublishPrices(int postId, double min, double max) async {
    if (isClosed) return;
    emit(const CreatePostState.loading());
    final result = await _repo.updatePrices(postId: postId, minPrice: min, maxPrice: max);
    
    if (isClosed) return;
    result.when(
      success: (msg) {
        currentStep = 0;
        startLat = null; startLng = null; endLat = null; endLng = null;
        startGovernorate = null; endGovernorate = null; lastDate = null;
        startDetailsCtrl.clear(); endDetailsCtrl.clear(); objectCtrl.clear();
        weightCtrl.clear(); heightCtrl.clear(); widthCtrl.clear(); lengthCtrl.clear();
        
        emit(CreatePostState.stepTwoSuccess(msg));
      },
      failure: (err) => emit(CreatePostState.submitError(err)),
    );
  }

  @override
  Future<void> close() {
    startDetailsCtrl.dispose(); endDetailsCtrl.dispose(); objectCtrl.dispose();
    weightCtrl.dispose(); heightCtrl.dispose(); widthCtrl.dispose(); lengthCtrl.dispose();
    return super.close();
  }
}