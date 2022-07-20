//
//  Constants.swift
//  Towy Driver
//
//  Created by Macbook Pro on 19/06/2022.
//


import UIKit

open class Constants {
    
    struct ScreenSize {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        static let maxWH = max(ScreenSize.width, ScreenSize.height)
    }
    
    struct DeviceType {
        static let iPhone4orLess  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH < 568.0
        static let iPhone5orSE    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 568.0
        static let iPhone678      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 667.0
        static let iPhone678p     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 736.0
        static let iPhoneX        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 812.0
    }
    
    // ------------------------------------------------------------------------------------
    // --------------------              PREFERENCES                -----------------------
    // ------------------------------------------------------------------------------------
    
    
    
    
    public static let USER_PREFERENCES_EMAIL        = "USER_PREFERENCES_EMAIL"
    public static let USER_PREFERENCES_NAME         = "USER_PREFERENCES_NAME"
    public static let USER_PROFILE_IMAGE            = "USER_PROFILE_IMAGE"
    public static var Currency                      = "PKR. "
    public static let LOCATION_TIMER_DURATION_ONLINE:Double = 10
    public static let LOCATION_TIMER_DURATION_ONRIDE:Double = 10
    public static let DRIVER_WAITING_TIMER_DURATION:Double = 10
    
    // ------------------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------------------
    // --------------------                 URLS                ---------------------------
    // ------------------------------------------------------------------------------------
    //--------------------------- TEST SERVER LINK------------------------//
    //
    public static let HTTP_CONNECTION_ROOT   =  "http://13.213.132.157/api/v1/"
    public static let ASSETS_BASE_URL = "http://13.213.132.157/"
    
    //-------------------------------------------------------------------------//
    
    
    
    //--------------------------- LIVE SERVER LINK------------------------//
    
//    public static let HTTP_CONNECTION_ROOT   = "http://54.254.32.130/api/v1/"
//    public static let ASSETS_BASE_URL = "http://54.254.32.130/";
    
    
    //----------------------------------------------------------------------------//
    
    
    public static let HTTP_CONNECTION_IMG = "https://storage.googleapis.com/"
    //Live
    public static let HTTP_CONNECTION_PROFILE    = "http://softechsolution.net/POS-WEB/";
    public static let PRIVACY_POLICE_URL = "https://www.ae.sa.com/terms-and-conditions?layout=false";
    public static let APP_KEY   = "$2y$10$nhVMfqloBOM7JeDaDP.UgO9LOJbLDcFG60BJ.mHX.XBF6RUtu8IAW";
    public static let PLACEHOLDER_URL   = "https://projects.scpr.org/static-files/_v4/images/default_avatar.png";
    public static let NO_IMAGE_URL = "https://www.hearthsidedistributors.com/site/hearthgrillsales/images/noimage.png";
    public static let GOOGLE_APIKEY   = "AIzaSyBsdpz4AX5T6uqLxqJXUgEDtoxd0TIiJ2w";
    public static let GOOGLE_CLIENT_ID   = "935000554849-gkjqopeja7nenfatqu5rfq62s0cpk0ji.apps.googleusercontent.com";
    public static var DEFAULT_AVG_DISTANCE:Double = 12.0
    public static var DEFAULT_LAT:Double!
    public static var DEFAULT_LONG:Double!
    public static var IS_RIDE_POPUP_VISIBLE:Bool = false
    public static var FIREBASE_PUSH_NOTIFICATION_SERVER_KEY = ""
    
    
    
    
    // ------------------------------------------------------------------------------------
    
    
    // ------------------------------------------------------------------------------------
    // --------------------                 API                ----------------------------
    // ------------------------------------------------------------------------------------
    
    
    
    
    public static let SERVER_USER_NAME          = "first_name";
    
    public static let SERVER_USER_ADDRESS       = "fullAddress";
    public static let SERVER_NOMBRE_ID          = "mobile_no";
    public static let SERVER_EMAIL_ID           = "email";
    public static let FRANCHISE_NAME            = "franchise_code";
    public static let SERVER_OTP_CODE           = "otpCode";
    public static let SERVER_FCM_TOKEN          = "fcmToken";
    public static let LOCAL_FCM_TOKEN           = "fcmTokenLocal";
    public static let SERVER_USER_IMAGE         = "profile_picture";
    public static let SERVER_VEHICLE_NUMBER     = "vehicle_number";
    public static let SERVER_VEHICLE_MODEL      = "vehicle_model";
    public static let SERVER_VEHICLE_MODEL_YEAR = "vehicle_model_year";
    public static let GET_HELP_DATA             = "getPageData";
    
    
    public static let SERVER_ACCESS_TOKEN       = "accessToken";
    public static let SERVER_USER_SID           = "id";
    public static let SERVER_DRIVER_RATING      = "driverRating";
    public static let SERVER_REFERRAL_ID        = "referralId";
    
    public static let IS_LOGIN                  = "isLogin";
    public static let IS_PERFORMER              = "isPerfomer";
    public static let IS_FIRST_TIME             = "FirstTimeAppInstall";
    public static let CURRENT_RIDE              = "currentRide";
    public static let SCHEDUAL_RIDE             = "schedualRide";
    public static let IS_HAPTIC_FEEDBACK        = "isHaptickFeedBack";
    
    public static let IS_LOCAL                  = "isLocal";
    public static let HAS_ALREADY_RECEIVED      = "hasAlreadyReceived";
    public static let RIDE_WAITING_TIME_START   = "waitingTimeStart";
    public static let APP_RUNNING_BACKGROUND    = "appIsInBackground";
    public static let VEHICLE_IMAGE_NAME        = "vehicleImageName";
    public static let DRIVER_TYPE               = "driverType";
    public static let DUAL_CAT_ID               = "dualCatId";
    public static let IS_ON_DUAL                = "isOnDual";
    public static let RIDE_LOCATIONS            = "rideLocations"
    
    public static let USER_CURRENCEY            = "user_Currencey_Country";
    
    
    public static let INTERSTITIAL_AD_ID            = "ca-app-pub-9690524535831287/5349051521"
    //    ca-app-pub-3940256099942544~1458002511
    public static let SERVER_DRIVER_STATUS          = "status";
    
    public static let DRIVER_VEHICLE_TYPE_ID        = "driver_vehicletype_id";
    
    public static let IS_POLYLINE_DRAWN             = "isPolylineDrawn";
    public static let NATIONAL_ID                   = "nic";
    public static let JOINING_DATE                  = "created_at";
    
    
    // ------------------------------------------------------------------------------------
    // --------------------                 Notifications              ----------------------------
    // ------------------------------------------------------------------------------------
    public enum NotificationType:String{
        case RIDE_LOCATION_CHANGED      = "3";
        case NEW_RIDE_REQUEST           = "2"
        case RIDE_CANCELED              = "4";
        case SCHEDULE_RIDE              = "7";
        case LOGOUT_USER                = "8";
        case OFFLINE_PARTNER            = "11";
        case RIDE_CANCEL_ON_RECEIVE     = "10";
        case MESSAGE_RECEIVE            = "20";
        case NONE                       = "0";
        case WARNING                    = "21"
        case BOUNS                      = "22"
        case LOCATION_ERROR_NOTIFICATION = "23"
        
    }
    
    public enum RideStatus:String{
        case REACHED_PICKUP     = "1";
        case RIDE_START         = "2";
        case RIDE_COMPLETED     = "3";
        case NONE               = "0";
    }
    
    
    
    //    public enum VehicleType:Int{
    //        case CAR      = 1;
    //        case BIKE     = 10;
    //        case NONE     = 0;
    //    }
    
    
    
    // ------------------------------------------------------------------------------------
    // --------------------                 End Points                ----------------------------
    // ------------------------------------------------------------------------------------
    
    public static let DRIVER_REGISTERATION          = "registerNewDriver"
    public static let ALL_FRANCHISES                = "franchisesAll"
    public static let VERIFY_OTP                    = "verifyCode"
    public static let RESEND_OTP                    = "resendOTP"
    public static let DRIVER_LOGIN                  = "loginDriver"
    public static let DRIVER_STATUS                 = "setDriverStatus"
    public static let DRIVER_COORDINATES_UPDATE     = "setDriverCoordinates"
    public static let VEHICLE_INFO_UPLOAD           = "vehicleInfoUpdate"
    public static let USER_DOCUMENTS_UPLOAD         = "uploadIdDocInfo"
    public static let USER_REFRESH_TOKEN            = "userRefreshToken?"
    public static let USER_LOGOUT                   = "logout"
    public static let ACCEPT_RIDE                   = "newRideBooking"
    public static let DRIVER_CANCEL_BOOKING         = "driverCancelsRide"
    public static let UPDATE_RIDE_STATUS            = "setDriverBookingStatus"
    public static let CHECK_BOOKING_STATUS          = "checkBookingStatus"
    public static let RATE_PASSENGER                = "giveDriverRating"
    public static let GET_OTP_FORGOT_PASSWORD       = "forgetPasswordSendOTP"
    public static let VERIFY_OTP_FORGOT_PASSWORD    = "verifyOTPCodeForgetPassword"
    public static let FORGOT_PASSWORD               = "forgot_password"
    public static let GET_SCHEDUAL_RIDE             = "getScheduledRide"
    public static let GET_CALCULATED_FARE           = "getBookingUpdatedCalculations"
    public static let GET_PARTNER_LEDGER            = "partnerLedgers"
    public static let GET_TEMP_RIDE                 = "getTempRideData"
    public static let GET_RIDES_HISTORY             = "getCompletedRides"
    public static let GET_DUAL_CAT_ID               = "vehicle_dual_cat_update"
    public static let GET_TRANSACTION_HISTORY       = "partnerTransactionsHistory"
    public static let GET_NOTIFICATIONS_HISTORY     = "getNotificationList"
    
    
    // ------------------------------------------------------------------------------------
    // --------------------                 Alert Messages                ----------------------------
    // ------------------------------------------------------------------------------------
    public static let LOGIN_SUCESSFULLY     = "Login Successfully!"
    public static let WRONG_NUMBER          = "Your entered number is not correct"
    public static let APP_NAME              = "TOWY"
    public static let PROMO_CODE_EMPTY      = "please enter promo code"
    public static let PROMO_CODE_INVALID    = "please enter valid promo code"
    public static let TERM_CONDITION        = "Please accept term and conditions"
    public static let CANT_GET_BACK         = "Please enter information to get back."
    
    //validations
    
    public static let VALID_PIN         = "Please enter valid pin"
    public static let ENTER_NAME        = "Please enter your name"
    public static let ENTER_VALID_NAME  = "Please enter your name without Any number."
    
    public static let ENTER_NUMBER          = "Please enter your mobile number"
    public static let ENTER_NIC             = "Please enter your National ID"
    public static let WRONG_NIC             = "Please enter correct National ID"
    public static let ENTER_EMAIL           = "Please enter your Email"
    public static let WRONG_EMAIL           = "Enter Valid Email Adress."
    public static let CREATE_PASS           = "Please create your password"
    public static let WEAK_PASSWORD         = "Password should be minimum 8 character long"
    public static let AGREE_T_AND_C         = "To continue you must agree terms and conditions."
    public static let ENTER_REFERRAL_CODE   = "Enter referral Code."
    
    public static let PASSWORD_MISS_MATCH   = "New password and confirm password are different."
    public static let PASSWORD_UPDATED      = "Password updated successfully login with new password."
    public static let RATE_FIRST = "Please rate passenger first."
    public static let LOGOUT_BY_NOTIFICAION = "You have been logged-out as you have login on another device"
    public static let BTN_LOGIN_AGAIN       = "Login Again"
    public static let RIDE_CANCELLED_BY_PASSENGER = "Ride cancel by user."
    public static let IS_DESTINATION_CHANGED_POP_VIEWED = "popUpViewed"
    public static let UPDATE_APP            = "A newer version is available on Appstore please update to newer version."
    public static let CHECK_NETWORK_CONNECTION = "Your internet Appears to be Offine."
    //vehicle infor VC
    
    public static let ENTER_VEHICLE_TYPE    = "Please enter your Vehicle type."
    public static let ENTER_CAR_NAME        = "Please enter your car name"
    public static let ENTER_VEHICLE_MODEL   = "Please enter Vehicle model"
    public static let ENTER_VEHICLE_NO      = "Please enter Vehicle's number"
    public static let ENTER_VEHICLE_YEAR    = "Please enter your vehicle model year"
    public static let INVALID_VEHICLE_YEAR  = "This Vehicle Model is not allowed for Registration in : \(Constants.APP_NAME)"
    public static let ADD_VEHICLE_REGISTRAION_CAR = "Please add your vehicle registraion Card "
    public static let ADD_VEHICLE_IMAGES    = "Please add your vehicle front and back images"
    public static let CAR_IMAGES_LIMIT_EXCEED = "You have already selected two images.\n Remove to add more."
    public static let CAR_REGISTRAION_IMAGE_LIMIT_EXCEED = "You have already selected registraion.\n Remove to add another."
    
    //Documents VC
    
    public static let ID_IMAGES_LIMIT_EXCEED = "You have already selected two images.\n Remove to add more."
    public static let DRIVING_LICENSE_IMAGES_LIMIT_EXCEED = "You have already selected two images.\n Remove to add more."
    public static let ADD_ID_IMAGES         = "Please add your ID Card front and back images"
    public static let ADD_DRIVING_LICENSE_IMAGES = "Please add your drining license front and back images"
    public static let WAIT_FOR_DOCUMENTS_APPROVAL = "your attached documents are under review you will continue to take rides after approval."
    // DASHBOARD
    public static let LOCATION_PERMISSION   = "Please enable Location Services"
    
    public static let SOMETHING_WENT_WRONG  = "Something went wrong"
    public static let NO_FRANCHISE          = "No frnachise in this Region."
    public static let SELECT_FRANCHISE      = "Select Frnachise to continue."
    
    
    public static let WANT_TO_FINISH_RIDE   = "Do you want to finish ride now?"
    public static let YOU_ARE_OFFLINE       = "You are offline due to non-interactivity"
    public static let YOU_ARE_OFFLINE_DUE_REJECTION = "Offile due to Rejecting Rides"
    
    public static let ENABLE_DUAL_CAT       = "Enable Dual Vehicle Booking."
    
    
    // ------------------------------------------------------------------------------------
    // --------------------                Notification Observers                ----------------------------
    // ------------------------------------------------------------------------------------
    
    
    public enum NotificationObservers:String{
        
        case RIDE_CANCEL_BY_DRIVER      = "ride_Cancelled";
        case RIDE_CANCEL_BY_USER        = "ride_Cancelled_By_User";
        case RIDE_CANCEL_BY_USER_ON_RECEIVE = "ride_Cancelled_By_User_ON_RECEIVE";
        case RIDE_ACCEPTED              = "ride_Accepted";
        case RIDE_DESTINATION_CHANGED   = "ride_Destination_changed"
        case LUNCH_BY_NOTIFICATION      = "lunchByNotification"
        case APP_BECOME_ACTIVE          = "applicationBecomeActive"
        case APP_ENTER_BACKGROUND       = "applicationEnterBackground"
        case UPDATE_AVAILABLE           = "updateIsAvailable"
        case OFFLINE_USER               = "offlineUser"
        case CHECK_BANNER               = "checkBanner"
        case RESET_BANNER               = "resetBanner"
    }
    
    
    
    enum AssetsColor:String {
       case TextfieldBackGround = "TextfieldBackGround"
       case ThemeBtnColor       = "ThemeBtnColor"
       case ThemeTextColor      = "ThemeTextColor"
       case ThemeBlueColor      = "ThemeBlueColor"
    }

   
    
    
   
    
}

