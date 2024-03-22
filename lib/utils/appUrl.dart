class AppUrl{
  static var baseUrl = 'https://lhindi.lekhny.com/lekhny/Api/v1';

  static var profileImagebaseUrl = 'https://lekhny.com/UserProfileImages/';
  static var upcomingBookImagebaseUrl = 'https://lekhny.com/UploadHomeImage/';

  static var englishUserProfileImagebaseUrl = 'https://english.lekhny.com/images/';
  static var hindiUserProfileImagebaseUrl = 'https://lekhny.com/images/';
  static var urduUserProfileImagebaseUrl = 'https://urdu.lekhny.com/images/';

  static var hindiAndUrduCoverImageBaseUrl = "https://lekhny.com/images/";
  static var englishCoverImageBaseUrl = "https://english.lekhny.com/images/";

  static var hindiImagebaseUrl = 'https://lekhny.com/UserBookCover/';
  static var englishImagebaseUrl = 'https://english.lekhny.com/UserBookCover/';
  static var urduImagebaseUrl = 'https://urdu.lekhny.com/UserBookCover/';

  static var hindiDailyCompImagebaseUrl = 'https://lekhny.com/uploadcompt/';
  static var englishDailyCompImagebaseUrl = 'https://english.lekhny.com/uploadcompt/';
  static var urduDailyCompImagebaseUrl = 'https://urdu.lekhny.com/uploadcompt/';

  static var loginUrl = baseUrl + '/auth/login';
  static var signUpByEmailUrl = baseUrl + '/auth/singup/email';
  static var signUpByGoogleUrl = baseUrl + '/auth/social/Singup';
  static var loginByGoogleUrl = baseUrl + '/auth/social/login';
  static var readingHistoryUrl = baseUrl + '/auth/readingHistory?pegination=';//
  static var latestPostsUrl = baseUrl + '/latestPost?pegination=';//
  static var mostReadPostsUrl = baseUrl + '/mostread?pegination=';//
  static var pastDailyTopicsUrl = baseUrl + '/dailyCompetitionTopic?postTopicNo=';//
  static var topSeriesUrl = baseUrl + '/topSeries?pegination=';//
  static var topPicksUrl = baseUrl + '/specialPost?pegination=';//
  static var topPostsUrl = baseUrl + '/topstory?pegination=';//
  static var singleBookDetailsUrl = baseUrl + '/singlepost?postID=';
  static var singleBookPartsUrl = baseUrl + '/singlepostallParts?postID=';
  static var singleBookDataUrl = baseUrl + '/viewSinglePostData?postID=';
  static var topWritersUrl = baseUrl + '/topWriters';
  static var upcomingBookUrl = baseUrl + '/upcomingbook';
  static var addNewPostUrl = baseUrl + '/addNewPost';
  static var writePostUrl = baseUrl + '/startWritting';
  static var postDetailsUrl = baseUrl + '/editPostDetails';
  static var languageCategoryUrl = baseUrl + '/languageCategory';
  static var languageSubCategoryUrl = baseUrl + '/languageSubCategory';
  static var updatePostDetailsUrl = baseUrl + '/updatePostDetails';
  static var publishPostUrl = baseUrl + '/postPublished';
  static var postCopyrightUrl = baseUrl + '/allcopyWrite';
  static var draftsUrl = baseUrl + '/draftPost';
  static var monthlyCompetitionResultUrl = baseUrl + '/monthly/Competition/result?resultDay=1';//
  static var publishedPostUrl = baseUrl + '/auth/latestpublushpost';
  static var authFollowingDataUrl = baseUrl + '/auth/authfollowingdata';
  static var categoryUrl = baseUrl + '/getallCategory?withPost=0';
  static var subCategoryUrl = baseUrl + '/allSubCategory?categoryID=';
  static var postsByCategoryUrl = baseUrl + '/postforCategory?paginateNo=';
  static var postsBySubCategoryUrl = baseUrl + '/getpost/bysubcategory?cateoryID=';
  static var userProfileUrl = baseUrl + '/auth/profile';
  static var unPublishedPostsUrl = baseUrl + '/auth/unpublushpost';
  static var publishedSeriesUrl = baseUrl + '/auth/latestpublushpostseries';
  static var libraryCollectionUrl = baseUrl + '/library/collaction?authID=';
  static var changeProfilePictureUrl = baseUrl + '/auth/authProfileChange';
  static var verifyEmailUrl = baseUrl + '/auth/email/verify/send';
  static var verifyEmailOTPUrl = baseUrl + '/auth/email/verify/otp';
  static var allPointsDetaislUrl = baseUrl + '/auth/allCreditPointsDetails';
  static var redeemPointsUrl = baseUrl + '/auth/pointsredeemrequest';
  static var requestPointsUrl = baseUrl + '/auth/requestForpoints';
  static var pointsEarnedUrl = baseUrl + '/auth/postLikePoints?pegID=';
  static var pointsDeductedUrl = baseUrl + '/auth/getpostPublushDebitPoints?pegination=';
  static var redeemedPointsUrl = baseUrl + '/auth/pointsredeemDetails?pegination=';
  static var addNextPartUrl = baseUrl + '/nextPartadd';
  static var dailyCompetitonTopicUrl = baseUrl + '/todayCompetitionDetails';
  static var dailyCompetitionParticipateUrl = baseUrl + '/daily/competition/participate?contestId=';
  static var forgetPasswordSendOtpUrl = baseUrl + '/auth/password/reset/otp';
  static var forgetPasswordVerifyOtpUrl = baseUrl + '/auth/password/verify/otp';
  static var mainSearchUrl = baseUrl + '/search/data';
  static var trendingSearchUrl = baseUrl + '/pre/search';
  static var dailyCompetitionWinnersUrl = baseUrl + '/dailyCompetitionResult?resultDay=';
  static var sixDayStreakUrl = baseUrl + '/auth/participantsdata';
  static var followUnfollowUrl = baseUrl + '/auth/followunfollow';
  static var upcomingBookDetailsUrl = baseUrl + '/upcomingbook/details?bookID=';
  static var writerProfileDetailsUrl = baseUrl + '/WritterProfile?writterid=';
  static var writerStatsUrl = baseUrl + '/all/time/statics?writterid=';
  static var writerPostsUrl = baseUrl + '/WritterPosts?writterid=';
  static var writerSeriesUrl = baseUrl + '/WritterPostSeries?writterid=';
  static var changePasswordUrl = baseUrl + '/auth/password/update';
  static var likePostUrl = baseUrl + '/postLike?postID=';
  static var postLikesListUrl = baseUrl + '/singlepostalllikes?postID=';
  static var commentListUrl = baseUrl + '/singlepostcomments?postID=';
  static var postCommentUrl = baseUrl + '/postcomments';
  static var commentReplyUrl = baseUrl + '/replyonComments';
  static var editCommentUrl = baseUrl + '/updateComment';
  static var editReplyUrl = baseUrl + '/updateReply';
  static var deleteCommentUrl = baseUrl + '/deletecomments';
  static var deleteReplyUrl = baseUrl + '/deletereplys';
  static var dailyCompetitionTopicPostsUrl = baseUrl + '/dailyCompetitionTopicposts?comTopicId=';
  static var leaderboardMostPostsUrl = baseUrl + '/topPostWritter?pagination=';
  static var leaderboardMostFollowersUrl = baseUrl + '/topFollowersOfWeekWritter?pagination=';
  static var leaderboardMostLikesUrl = baseUrl + '/totalLikeAchiver?pagination=';
  static var dailyCompetitionRulesUrl = baseUrl + '/competitionRule';
}

//