import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/commentListModelClass.dart';
import 'package:lekhny/data/model/commentReplyModelClass.dart';
import 'package:lekhny/data/model/deleteCommentModelClass.dart';
import 'package:lekhny/data/model/deleteReplyModelClass.dart';
import 'package:lekhny/data/model/editCommentModelClass.dart';
import 'package:lekhny/data/model/editReplyModelClass.dart';
import 'package:lekhny/data/model/postCommentModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/commentListRepository.dart';
import 'package:lekhny/data/repository/commentReplyRepository.dart';
import 'package:lekhny/data/repository/deleteCommentRepository.dart';
import 'package:lekhny/data/repository/deleteReplyRepository.dart';
import 'package:lekhny/data/repository/editCommentRepository.dart';
import 'package:lekhny/data/repository/editReplyRepository.dart';
import 'package:lekhny/data/repository/postCommentRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class CommentsViewModel with ChangeNotifier{

  final _commentsListRepository = CommentsListRepository();
  final  postCommentRepository = PostCommentRepository();
  final  commentReplyRepository = CommentReplyRepository();
  final  editCommentRepository = EditCommentRepository();
  final  editReplyRepository = EditReplyRepository();
  final  deleteCommentRepository = DeleteCommentRepository();
  final  deleteReplyRepository = DeleteReplyRepository();

  CommentsListModelClass? commentsListModel;
  PostCommentModelClass? postCommentModel;
  CommentReplyModelClass? commentReplyModel;
  EditCommentModelClass? editCommentModel;
  EditReplyModelClass? editReplyModel;
  DeleteCommentModelClass? deleteCommentModel;
  DeleteReplyModelClass? deleteReplyModel;

  ApiResponse<List<dynamic>> commentsListData = ApiResponse.loading();

  bool? commentLoading;
  bool? commentReplyLoading;
  bool? editCommentLoading;
  bool? editReplyLoading;
  bool? deleteCommentLoading;
  bool? deleteReplyLoading;

  setCommentLoading(value){
    commentLoading = value;
    notifyListeners();
  }

  setCommentReplyLoading(value){
    commentReplyLoading = value;
    notifyListeners();
  }

  setEditCommentLoading(value){
    editCommentLoading = value;
    notifyListeners();
  }

  setEditReplyLoading(value){
    editReplyLoading = value;
    notifyListeners();
  }

  setDeleteCommentLoading(value){
    deleteCommentLoading = value;
    notifyListeners();
  }

  setDeleteReplyLoading(value){
    deleteReplyLoading = value;
    notifyListeners();
  }

  setCommentsListData( ApiResponse<List<dynamic>> response){
    print('working');
    commentsListData = response;
    print("this is responsePassed ${response}");
    print("this is commentsListData ${commentsListData}");
    notifyListeners();
  }

  Future<void> getCommentsListData(dynamic data, dynamic headers, postId) async{


    setCommentsListData(ApiResponse.loading());

    Future.wait([
      _commentsListRepository.commentListApi(data, headers, postId)
    ]).then((value){

      commentsListModel = value[0] as CommentsListModelClass;

      print('this is future.wait value ${value}');

      setCommentsListData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setCommentsListData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> postComment(dynamic data, dynamic headers) async{

    setCommentLoading(true);

    Future.wait([
      postCommentRepository.postCommentApi(data, headers)
    ]).then((value){

      postCommentModel = value[0] as PostCommentModelClass;

      if(postCommentModel!.data == true){
        Utils.toastMessage("Comment posted successfully");
    }else{
        Utils.toastMessage("Error while posting comment");

    }

      setCommentLoading(false);

    }).onError((error, stackTrace){

      setCommentLoading(false);

    });
  }

  Future<void> postCommentReply(dynamic data, dynamic headers) async{

    setCommentReplyLoading(true);

    Future.wait([
      commentReplyRepository.commentReplyApi(data, headers)
    ]).then((value){

      commentReplyModel = value[0] as CommentReplyModelClass;

      if(commentReplyModel!.data == true){
        Utils.toastMessage("Reply posted successfully");
      }else{
        Utils.toastMessage("Error while posting reply");

      }

      setCommentReplyLoading(false);

    }).onError((error, stackTrace){

      setCommentReplyLoading(false);

    });
  }

  Future<void> editComment(dynamic data, dynamic headers) async{

    setEditCommentLoading(true);

    Future.wait([
      editCommentRepository.editCommentApi(data, headers)
    ]).then((value){

      editCommentModel = value[0] as EditCommentModelClass;

      if(editCommentModel!.data == 1){
        Utils.toastMessage("Comment edited successfully");
      }else{
        Utils.toastMessage("Error while editing comment");

      }

      setEditCommentLoading(false);

    }).onError((error, stackTrace){

      setEditCommentLoading(false);

    });
  }

  Future<void> editReply(dynamic data, dynamic headers) async{

    setEditReplyLoading(true);

    Future.wait([
      editReplyRepository.editReplyApi(data, headers)
    ]).then((value){

      editReplyModel = value[0] as EditReplyModelClass;

      if(editReplyModel!.data == 1){
        Utils.toastMessage("Reply edited successfully");
      }else{
        Utils.toastMessage("Error while editing reply");

      }

      setEditReplyLoading(false);

    }).onError((error, stackTrace){

      setEditReplyLoading(false);

    });
  }

  Future<void> deleteComment(dynamic data, dynamic headers, index, BuildContext context) async{

    setDeleteCommentLoading(true);

    Future.wait([
      deleteCommentRepository.deleteCommentApi(data, headers)
    ]).then((value){

      deleteCommentModel = value[0] as DeleteCommentModelClass;

      if(deleteCommentModel!.status == 200){
        commentsListModel!.data!.removeAt(index);
        Utils.toastMessage("Comment deleted successfully");
      }else{
        Utils.toastMessage("Error while deleting comment");

      }

      Navigator.pop(context);

      setDeleteCommentLoading(false);

    }).onError((error, stackTrace){

      setDeleteCommentLoading(false);

    });
  }

  Future<void> deleteReply(dynamic data, dynamic headers, index, index2, BuildContext context) async{

    setDeleteReplyLoading(true);

    Future.wait([
      deleteReplyRepository.deleteReplyApi(data, headers)
    ]).then((value){

      deleteReplyModel = value[0] as DeleteReplyModelClass;

      if(deleteReplyModel!.status == 200){
        commentsListModel!.data![index].commentReply!.removeAt(index2);
        Utils.toastMessage("Reply deleted successfully");
      }else{
        Utils.toastMessage("Error while deleting reply");

      }

      Navigator.pop(context);

      setDeleteReplyLoading(false);

    }).onError((error, stackTrace){

      setDeleteReplyLoading(false);

    });
  }


}