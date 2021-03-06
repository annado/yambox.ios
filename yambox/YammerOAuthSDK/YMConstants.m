//
// Copyright (c) 2013 Yammer, Inc. All rights reserved.
//


#import "YMConstants.h"

NSString * const YAMMER_BASE_URL = @"https://www.yammer.com";

NSString * const YAMMER_MOBILE_SAFARI_STRING = @"com.apple.mobilesafari";

NSString * const YAMMER_AUTH_REDIRECT_URI = @"comannahdoyambox://oauth";

// Put your Yammer App's Client ID here
NSString * const YAMMER_APP_CLIENT_ID = @"DC7FhZ2XC7FEyj3MGUZxBw";

// Put your Yammer App's Client Secret here.  How you manage this and where you store it is up to you.  This is just a static sample.
NSString * const YAMMER_APP_CLIENT_SECRET = @"gdnk63xVwseBzrA08bGz8eYl7eZV0TsAtoYErmpj5g";

NSString * const YMYammerSDKErrorDomain = @"com.yammer.YammerSDK.ErrorDomain";

const NSInteger YMYammerSDKLoginAuthenticationError = 1001;
const NSInteger YMYammerSDKLoginObtainAuthTokenError = 1002;

NSString * const YMYammerSDKLoginDidCompleteNotification = @"YMYammerSDKLoginDidCompleteNotification";
NSString * const YMYammerSDKLoginDidFailNotification = @"YMYammerSDKLoginDidFailNotification";

NSString * const YMYammerSDKAuthTokenUserInfoKey = @"YMYammerSDKAuthTokenUserInfoKey";
NSString * const YMYammerSDKErrorUserInfoKey  = @"YMYammerSDKErrorUserInfoKey";
