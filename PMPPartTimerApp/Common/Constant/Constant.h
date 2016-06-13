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

#define API_DOMAIN_PATH @"http://192.168.1.47:8080"//http://ihughos.com

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
#define API_URL_CHECK_PARTTIMER @"/api/parttimer/checkPartTimerInfo.htm?json="



// textfield validate
#define REGEX_EMAIL     @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

// method
#define GET_METHOD      @"GET"
#define POST_METHOD     @"POST"

#endif
