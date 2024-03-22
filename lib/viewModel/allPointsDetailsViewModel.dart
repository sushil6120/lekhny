import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/pointsDeductedModelClass.dart';
import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/redeemedPointsModelClass.dart';
import 'package:lekhny/data/repository/pointsDeductedRepository.dart';
import 'package:lekhny/data/repository/pointsEarnedRepository.dart';
import 'package:lekhny/data/repository/redeemedPointsRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';

class AllPointsDetailsViewModel with ChangeNotifier{

  final _pointsEarnedRepository = PointsEarnedRepository();
  final _pointsDeductedRepository = PointsDeductedRepository();
  final _redeemedPointsRepository = RedeemedPointsRepository();

  PointsEarnedModelClass? pointsEarnedModel;
  PointsDeductedModelClass? pointsDeductedModel;
  RedeemedPointsModelClass? redeemedPointsModel;

  ApiResponse<dynamic> allPointsDetailsData = ApiResponse.loading();

  bool load = false;

  List<PointsEarnedData> pointsEarnedData = [];
  List<PointsDeductedData> pointsDeductedData = [];
  List<RedeemedPointsData> redeemedPointsData = [];

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setPointsEarnedData(json) {
    pointsEarnedData = pointsEarnedData + json;
    notifyListeners();
  }

  setPointsDeductedData(json) {
    pointsDeductedData = pointsDeductedData + json;
    notifyListeners();
  }

  setRedeemedPointsData(json) {
    redeemedPointsData = redeemedPointsData + json;
    notifyListeners();
  }

  setAllPointsDetailsData( ApiResponse<dynamic> response){
    print('working');
    allPointsDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is allPointsDetailsData ${allPointsDetailsData}");
    notifyListeners();
  }

  Future<void> getPointsEarnedData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setAllPointsDetailsData(ApiResponse.loading());
    }

    _pointsEarnedRepository.pointsEarnedApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.completed(value));
      }

      pointsEarnedModel = value;

      List<PointsEarnedData>? list = [];
      list = value!.data;
      setPointsEarnedData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getPointsDeductedData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setAllPointsDetailsData(ApiResponse.loading());
    }

    _pointsDeductedRepository.pointsDeductedApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.completed(value));
      }

      List<PointsDeductedData>? list = [];
      list = value!.data;
      setPointsDeductedData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getRedeemedPointsData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setAllPointsDetailsData(ApiResponse.loading());
    }

    _redeemedPointsRepository.redeemedPointsApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.completed(value));
      }

      List<RedeemedPointsData>? list = [];
      list = value!.data;
      setRedeemedPointsData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setAllPointsDetailsData(ApiResponse.error(error.toString()));
      }
    });
  }



}