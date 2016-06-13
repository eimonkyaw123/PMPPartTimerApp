//
//  Constant.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/16/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#ifndef PMPPartTimerApp_Constant_h
#define PMPPartTimerApp_Constant_h


#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

#pragma URL String

// application code
#define APP_CODE        @"Hughippo-01"

#define API_DOMAIN_PATH @"http://192.168.1.47:8080"

#define API_URL_SIGN_UP @"/api/parttimer/signup.htm?json="
#define API_URL_LOGIN @"/api/login.htm?json="
#define API_URL_CHECK_PARTTIMER_INFO @"/api/parttimer/checkPartTimerInfo.htm?json="
#define API_URL_PROFILE_INFO @"/api/parttimer/profileInfo.htm?json="
#define API_URL_PREFERENCE_LIST @"/api/parttimer/preferenceList.htm?json="
#define API_URL_PREFERENCE_INFO @"/api/parttimer/preferenceInfo.htm?json="
#define API_URL_PROFILE_BANK_INFO @"/api/parttimer/profileBankInfo.htm?json="
#define API_URL_JOB_LIST @"/api/parttimer/jobList.htm?json="
#define API_URL_JOB_LIST_FAVOURIT @"/api/parttimer/jobListFavourite.htm?json="
#define API_URL_JOB_DETAIL @"/api/parttimer/jobDetail.htm?json="
#define API_URL_ACCEPT_JOB @"/api/parttimer/acceptJob.htm?json="
#define API_URL_CANCEL_JOB @"/api/parttimer/cancelJob.htm?json="
#define API_URL_BANK_LIST @"/api/parttimer/getBankList.htm?json="
#define API_URL_FAVOURIT @"/api/parttimer/favouriteInfo.htm?json="
#define API_URL_NOTI_SETTING @"/api/parttimer/noti-setting.htm?json="
#define API_URL_NOTI_SETTING_LIST @"/api/parttimer/noti-setting-list.htm?json="
#define API_URL_NEWS_UPDATE_LIST @"/api/parttimer/newsUpdateList.htm?json="
#define API_URL_GET_PARTTIMER_PROFILE_INFO @"/api/parttimer/getPartTimerInfo.htm?json="
#define API_URL_FORGET_PASSWORD @"/api/forget-password.htm?json="
#define API_URL_UPDATE_DEVICE @"/api/update-device.htm?json="
#define API_URL_PROFILE_CHANGE_PASSWORD @"/api/profileChangePassword.htm?json="

// server url

#define SignUpURL  @"http://ihughos.com/api/parttimer/signup.htm?json="
#define SignUpJSON  @"{\"firstName\":\"%@\",\"lastName\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"confirmpassword\":\"%@\",\"deviceType\":\"%@\",\"deviceId\":\"%@\"}"

#define MyDetailURL @"http://ihughos.com/api/parttimer/profileInfo.htm?json="


#define PreferenceURL   @"http://ihughos.com/api/parttimer/preferenceInfo.htm?json="
#define PerferenceJSON  @"{\"sessionId\":\"%@\",\"partTimerId\":\"%d\",\"preferenceList\":%@}"

#define LoadPerferenceURL @"http://ihughos.com/api/parttimer/preferenceList.htm?json="
#define LoadPerferenceJSON  @"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}"

#define BankListURL  @"http://ihughos.com/api/parttimer/getBankList.htm?json="
#define BankListJSON  @"{\"sessionId\":\"%@\"}"

#define BankURL @"http://ihughos.com/api/parttimer/profileBankInfo.htm?json="
#define BankJSON  @"{\"partTimerId\":\"%d\",\"bankId\":\"%d\",\"accNumber\":\"%@\",\"sessionId\":\"%@\"}"

#define JobListURL  @"http://ihughos.com/api/parttimer/jobList.htm?json="
#define JobListJSON  @"{\"partTimerId\":\"%d\",\"pageNo\":\"%d\",\"sortBy\":\"%d\",\"filter\":\"%@\",\"sessionId\":\"%@\"}"

#define FavouritURL   @"http://ihughos.com/api/parttimer/jobListFavourite.htm?json="
#define FavouritJSON  @"{\"partTimerId\":\"%d\",\"pageNo\":\"%d\",\"sortBy\":\"%d\",\"sessionId\":\"%@\"}"

#define FavouritDetailURL  @"http://ihughos.com/api/parttimer/jobDetail.htm?json="
#define FavouritDetailJSON  @"{\"id\":\"%@\",\"sessionId\":\"%@\"}"

#define JobDetailURL  @"http://ihughos.com/api/parttimer/jobDetail.htm?json="
#define JobDetailJSON  @"{\"id\":\"%@\",\"partTimerId\":\"%@\",\"sessionId\":\"%@\"}"

#define AcceptJobURL  @"http://192.168.1.47:8080/api/parttimer/acceptJob.htm?json="
#define AcceptJobJSON @"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}"

#define CanecelJobURL @"http://192.168.1.47:8080/api/parttimer/cancelJob.htm?json="
#define CancelJobJSON  @"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}"

#define ForgetPasswordURL   @"http://ihughos.com/api/forget-password.htm?json="
#define ForgetPasswordJSON  @"{\"email\":\"%@\",\"appCode\":\"%@\"}"

#define SettingURL   @"http://ihughos.com/api/parttimer/noti-setting.htm?json="
#define SettingJSON  @"{\"partTimerId\":\"%d\",\"newjobalert\":\"%d\",\"newsalert\":\"%d\",\"workremainder\":\"%d\",\"sessionId\":\"%@\"}"

#define GetSettingURL  @"http://ihughos.com/api/parttimer/noti-setting-list.htm?json="
#define GetSettingJSON  @"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}"

#define GetFavouriteURL  @"http://ihughos.com/api/parttimer/favouriteInfo.htm?json="
#define GetFavouriteJSON  @"{\"partTimerId\":\"%d\",\"jobId\":\"%d\",\"sessionId\":\"%@\"}"

#define NewsURL  @"http://ihughos.com/api/parttimer/newsUpdateList.htm?json="
#define NewsJSON  @"{\"userId\":\"%d\",\"pageNo\":\"%d\",\"sessionId\":\"%@\"}"

#define CheckUserURL  @"http://ihughos.com/parttimer/checkPartTimerInfo.htm?json="
#define CheckUserJSON  @"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}"




#define SignInURL   @"http://ihughos.com/api/login.htm?json="
#define SignInJSON  @"{\"email\":\"%@\",\"password\":\"%@\",\"appCode\":\"%@\"}"

#define UpdateDeviceURL @"http://ihughos.com/api/update-device.htm?json="
#define UpdateDeviceJSON  @"{\"DeviceId\":\"%@\",\"deviceType\":\"%@\",\"userId\":\"%d\",\"sessionId\":\"%@\"}"




#define GetMyDetailURL  @"http://ihughos.com/api/parttimer/getPartTimerInfo.htm?json="
#define MyDetailJSON  @"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}"


#define GetBankDataURL  @"http://ihughos.com/api/parttimer/getPartTimerInfo.htm?json="
#define GetBankDataJSON @"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}"


#define ChangePasswordURL  @"http://ihughos.com/api/profileChangePassword.htm?json="
#define ChangePasswordJSON  @"{\"userId\":\"%d\",\"oldPassword\":\"%@\",\"password\":\"%@\",\"repeatPassword\":\"%@\",\"sessionId\":\"%@\"}"




#define MakeFavouritURL @"http://ihughos.com/api/parttimer/favouriteInfo.htm?json="
#define MakeFavouritJSON  @"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}"










// server url
#define SignUpURL     @"http://192.168.1.47:8080/api/parttimer/signup.htm?json="
#define LoginURL      @"http://192.168.1.47:8080/api/login.htm?json="
#define ForgetURL     @"http://192.168.1.47:8080/api/forget-password.htm?json="
#define ProfileInfoURL    @"http://192.168.1.47:8080/api/parttimer/profileInfo.htm?json="
#define PreferenceURL @"http://192.168.1.47:8080/api/parttimer/preferenceInfo.htm?json="


// sign up data
#define SIGNUP          @"{\"name\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"confirmpassword\":\"%@\",\"deviceType\":\"%@\",\"deviceId\":\"%@\"}"
#define LOGIN           @"{\"email\":\"%@\",\"password\":\"%@\",\"appCode\":\"%@\"}"    
#define PROFILE         @"id=%@&name=%@&email=%@&nric=%@&gender=%@&dob=%@&phoneNo=%@&schoolName=%@&studentCardExpire=%@&imageFrontView=%@&imageBackView=%@&"
#define FORGOT          @"{\"email\":\"%@\",\"appCode\":\"%@\"}"



// textfield validate
#define REGEX_EMAIL     @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

// method
#define GET_METHOD      @"GET"
#define POST_METHOD     @"POST"

#endif
