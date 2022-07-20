//
//  UtilityManager.swift
//  Towy Driver
//
//  Created by Macbook Pro on 19/06/2022.
//


import UIKit
//import Alamofire
//import GoogleMaps
import MediaPlayer
//import SideMenu
import AVFoundation
import CoreLocation
//import Toast_Swift

class UtilityManager: NSObject
{
    
    public static var manager = UtilityManager()
    var player: AVAudioPlayer?
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
//    func saveModelObject(data:[String:Any],key:String){
//
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
//        userDefaults.set(encodedData, forKey: key)
//        userDefaults.synchronize()
//
//    }
    
    
    func getP2PForPickup(driverLocation: CLLocationCoordinate2D, pickup: CLLocationCoordinate2D) -> CLLocationDistance {
        
        let start = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
        let end = CLLocation(latitude: pickup.latitude, longitude: pickup.longitude)
        let distance =  start.distance(from: end)
            return distance / 1000.0
        }
    
//    func p2pDistance(from: LocationModel, to: LocationModel) -> CLLocationDistance {
//
//        let start = CLLocation(latitude: from.lat, longitude: from.lng)
//        let end = CLLocation(latitude: to.lat, longitude: to.lng)
//        let distance =  start.distance(from: end)
//        if distance < 15{
//            return CLLocationDistance.init(0.0)
//        }else{
////            return distance
//            return checkIfDistanceIsTooMuch(distance: distance, from: from, to: to) / 1000.0
//        }
//    }
    
//    func checkIfDistanceIsTooMuch(distance:Double,from: LocationModel, to: LocationModel)->Double{
//        let time = UtilityManager.manager.secondsInTimeIntervals(startTime: to.time, endTime: from.time)
//        //before 10 sec
//        if time <= 10 && distance <= Constants.DEFAULT_AVG_DISTANCE * time{
//            return distance
//        }else
//        //after 10 sec efor 20
//        if time > 10 && distance >= Constants.DEFAULT_AVG_DISTANCE * time{
//            return Constants.DEFAULT_AVG_DISTANCE * time
//        }else if time <= 10 && distance >= Constants.DEFAULT_AVG_DISTANCE * time{
//                return Constants.DEFAULT_AVG_DISTANCE * time
//        }else{
//            return distance
//        }
//    }
    
    
//    func removeDuplicateElements(posts: [LocationModel]) -> [LocationModel] {
//        var uniquePosts = [LocationModel]()
//        for post in posts {
//            if !uniquePosts.contains(where: {$0.time == post.time }) {
//                uniquePosts.append(post)
//            }
//        }
//        return uniquePosts
//    }
    
    func saveModelInUserDefaults(key:String,data:[String:Any]?){
        do{
            if data != nil{
                let model = try NSKeyedArchiver.archivedData(withRootObject: data!, requiringSecureCoding: true)
                UserDefaults.standard.set(model, forKey: key)
            }else{
                UserDefaults.standard.set(nil, forKey: key)
            }
            UserDefaults.standard.synchronize()
        }catch (let error){
            #if DEBUG
                print("Failed to convert UIColor to Data : \(error.localizedDescription)")
            #endif
        }
    }
    
    func saveFareInUSD(fare:Double?){
        UserDefaults.standard.setValue(fare, forKey: "rideFare")
        UserDefaults.standard.synchronize()
    }
    func saveDistanceInUSD(fare:Double?){
        UserDefaults.standard.setValue(fare, forKey: "rideDistance")
        UserDefaults.standard.synchronize()
    }
    func saveTimeInUSD(fare:String?){
        UserDefaults.standard.setValue(fare, forKey: "rideTime")
        UserDefaults.standard.synchronize()
    }
    func saveDescriptionInUSD(fare:String?){
        UserDefaults.standard.setValue(fare, forKey: "rideDescription")
        UserDefaults.standard.synchronize()
    }
    func saveBookingIdInUSD(fare:String?){
        UserDefaults.standard.setValue(fare, forKey: "booking_unique_id")
        UserDefaults.standard.synchronize()
    }
    func getFareFromUSD()->Double?{
        return UserDefaults.standard.value(forKey: "rideFare") as? Double
    }
    func getTimeFromUSD()->String?{
        return UserDefaults.standard.value(forKey: "rideTime") as? String
    }
    func getDescriptionFromUSD()->String?{
        return UserDefaults.standard.value(forKey: "rideDescription") as? String
    }
    func getBookingIdFromUSD()->String?{
        return UserDefaults.standard.value(forKey: "booking_unique_id") as? String
    }
    func getDistnaceFromUSD()->Double?{
        return UserDefaults.standard.value(forKey: "rideDistance") as? Double
    }
    func getModelFromUserDefalts(key:String)->[String:Any]?{
        do{
            if let encodedData = UserDefaults.standard.object(forKey: key) as? Data{
                if let data = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self], from: encodedData){
                    return data as? [String : Any]
                }
            }
        }catch (let error){
            #if DEBUG
                print("Failed to convert UIColor to Data : \(error.localizedDescription)")
            return nil
            #endif
        }
        return nil
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func RGB(_ r: Float,_ g: Float,_ b: Float,_ a: Float) -> UIColor
    {
        let color = UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha:CGFloat(a))
        
        return color
        
    }
    func getAPIBaseUrl(api:String) -> String
    {
        let urlString = Constants.HTTP_CONNECTION_ROOT+api
        
        return urlString
    }
    func getMainStoryboard() -> UIStoryboard
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard
    }
    func getAuthStoryboard() -> UIStoryboard
    {
        let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
        return storyboard
    }
    func getDashboardStoryboard() -> UIStoryboard
    {
        let storyboard = UIStoryboard.init(name: "Dashboard", bundle: .main)
        return storyboard
    }
    func isIPAD() -> Bool
    {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        {
            return true
        }
        
        return false
    }
    func navigateToVc(from:UIViewController,identifier:String,storyBoard:UIStoryboard,_ animate:Bool = true){
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        from.navigationController?.pushViewController(vc, animated: animate)
    }
    func presentVC(from:UIViewController,identifier:String,storyBoard:UIStoryboard,_ animate:Bool = true,_ style:UIModalPresentationStyle = .fullScreen){
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = style
        from.present(vc, animated: animate, completion: nil)
    }
    
    func gotoVC(from:UIViewController,identifier:String,storyBoard:UIStoryboard,_ animate:Bool = true,_ style:UIModalPresentationStyle = .fullScreen){
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        if from.navigationController == nil{
            vc.modalPresentationStyle = style
            from.present(vc, animated: animate, completion: nil)
        }else{
            from.navigationController?.pushViewController(vc, animated: animate)
        }
       
    }
    
    
    func moveBack(_ vc:UIViewController,_ animate:Bool = true){
        if vc.navigationController != nil{
            vc.navigationController?.popViewController(animated: animate)
        }else{
            vc.dismiss(animated: animate, completion: nil)
        }
    }
//    func showAlertView(title:String?, message:String,VC:UIViewController? = nil){
////        let alert = UIAlertController(title:title!, message:message, preferredStyle: UIAlertController.Style.alert)
////
////        // add an action (button)
////        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        let st = UtilityManager.manager.getMainStoryboard()
//        let vc = st.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
//        vc.txt = title ?? ""
//        vc.msg = message
//        vc.modalPresentationStyle = .overFullScreen
//        if VC != nil{
//            VC!.present(vc, animated: false, completion: nil)
//        }else{
//            if let topVc = UIApplication.getTopMostViewController(){
//                topVc.present(vc, animated: false, completion: nil)
//            }
//
//        }
//
//    }
    
    func showAlertWithAction(_ vc:UIViewController, message:String,title:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for index in 0..<buttons.count{
            
            alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]), forKey: "attributedTitle")
            
            alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]), forKey: "attributedMessage")
            
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(index)
                }
            })
            
            action.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(action)
        }
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(_ vc:UIViewController, message:String,title:String) -> Void {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
    func appThemeColor() -> UIColor
    {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    func getAppRedColor() -> UIColor
    {
        return UIColor.init(red: 165, green: 0, blue: 0, alpha: 1.0)
    }
    func getAppGreenColor() -> UIColor
    {
        return UIColor.init(red: 0, green: 100, blue: 0, alpha: 1.0)
    }
    func appBackgroundColor() -> UIColor
    {
        return UIColor.init(red: 32.0/255.0, green: 129.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    }
    func getAuthToken() -> String
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_ACCESS_TOKEN) as? String
        return result ?? ""
    }
    func saveFCMToken(token:String){
        UserDefaults.standard.setValue(token, forKey: Constants.LOCAL_FCM_TOKEN)
    }
    func getServerFcmToken() -> String
       {
           let result = UserDefaults.standard.value(forKey: Constants.SERVER_FCM_TOKEN) as? String
           return result ?? ""
       }
    func getFcmToken() -> String
    {
        let result = UserDefaults.standard.value(forKey: Constants.LOCAL_FCM_TOKEN) as? String
        return result ?? ""
    }
    func getId() -> Int
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_USER_SID) as? Int
        return result ?? 0
    }
    func getEmail() -> String
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_EMAIL_ID) as? String
        return result ?? ""
    }
    func getNumber() -> Int
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_NOMBRE_ID) as? Int
        return result ?? 0
    }
    
    
    func doesStringContainsNumber( _string : String) -> Bool{

            let numberRegEx  = ".*[0-9]+.*"
            let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: _string)

            return containsNumber
        }
    
    func getUserName() -> String
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_USER_NAME) as? String
        return result ?? "iOS_Driver"
    }
    func getUserImageUrl() -> String?
    {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_USER_IMAGE) as? String
        return result ?? nil
    }
    func getVehicleNumber() -> String?
       {
           let result = UserDefaults.standard.value(forKey: Constants.SERVER_VEHICLE_NUMBER) as? String
           return result ?? "_"
       }
    
    func getVehicleModel() -> String?
       {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_VEHICLE_MODEL) as? String
           return result ?? "_"
       }
    func getVehicleModelYear() -> String?
       {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_VEHICLE_MODEL_YEAR) as? String
           return result ?? "_"
       }
    func getDriverRating() -> String?
       {
        let result = UserDefaults.standard.value(forKey: Constants.SERVER_DRIVER_RATING) as? Double ?? 0.0
           return "\(result)"
       }
    func getDriverReferralId() -> String?
       {
           let result = UserDefaults.standard.value(forKey: Constants.SERVER_REFERRAL_ID) as? String
           return result ?? "0.0"
       }
    func getDriverStatus() -> Int
       {
           let result = UserDefaults.standard.value(forKey: Constants.SERVER_DRIVER_STATUS) as? Int
           return result ?? 0
       }
    func saveDriverStatus(status:Int)
       {
         UserDefaults.standard.setValue(status, forKey: Constants.SERVER_DRIVER_STATUS)
        UserDefaults.standard.synchronize()
       }
    
   
    
    
    func saveUserSession(userDict:NSDictionary,accessToken:String){
        
//        print(userDict)
        
        if  accessToken != ""{
            UserDefaults.standard.set(accessToken, forKey: Constants.SERVER_ACCESS_TOKEN)
        }
        
        if let userID = userDict["id"] as? NSInteger
        {
            UserDefaults.standard.set(userID, forKey: Constants.SERVER_USER_SID)
        }
        if let userName = userDict["first_name"] as? String
        {
            UserDefaults.standard.set(userName, forKey: Constants.SERVER_USER_NAME)
        }
        if let userName = userDict["created_at"] as? String
        {
            UserDefaults.standard.set(userName, forKey: Constants.JOINING_DATE)
        }
        if let userEmail = userDict["email"] as? String
        {
            UserDefaults.standard.set(userEmail, forKey: Constants.SERVER_EMAIL_ID)
        }
        
        if let userEmail = userDict["franchise_code"] as? String
        {
            UserDefaults.standard.set(userEmail, forKey: Constants.FRANCHISE_NAME)
        }
        
        if let userPhone = userDict["mobile_no"] as? NSInteger
        {
            UserDefaults.standard.set(userPhone, forKey: Constants.SERVER_NOMBRE_ID)
        }
        if let userID = userDict["vehicle_number"] as? String
        {
            UserDefaults.standard.set(userID, forKey: Constants.SERVER_VEHICLE_NUMBER)
        }
        if let userID = userDict["driver_ratings"] as? Double
        {
            UserDefaults.standard.set(userID, forKey: Constants.SERVER_DRIVER_RATING)
        }
        
        if let userID = userDict["vehicle_model"] as? String
        {
            UserDefaults.standard.set(userID, forKey: Constants.SERVER_VEHICLE_MODEL)
        }
        
        if let userID = userDict["vehicle_model_year"] as? String
        {
            UserDefaults.standard.set(userID, forKey: Constants.SERVER_VEHICLE_MODEL_YEAR)
        }
        
        
        if let referralId = userDict["referral_id"] as? String
        {
            UserDefaults.standard.set(referralId, forKey: Constants.SERVER_REFERRAL_ID)
        }
        
        if let otpCode = userDict["otp_code"] as? NSInteger
        {
            UserDefaults.standard.set(otpCode, forKey: Constants.SERVER_OTP_CODE)
        }
        if let otpCode = userDict["nic"] as? String
        {
            UserDefaults.standard.set(otpCode, forKey: Constants.NATIONAL_ID)
        }
        if let fcm = userDict["fcm_token"] as? String
        {
            UserDefaults.standard.set(fcm, forKey: Constants.SERVER_FCM_TOKEN)
        }
        if let userImage = userDict["profile_picture"] as? String
        {
            UserDefaults.standard.set(userImage, forKey: Constants.SERVER_USER_IMAGE)
        }
        
        if let userStatus = userDict["is_driver_active"] as? Int
        {
            saveDriverStatus(status: userStatus)
        }
        
        if let userStatus = userDict["driver_vehicletype_id"] as? Int
        {
            UtilityManager.manager.saveVehicleName(type: userStatus)
        }
        
        if let userStatus = userDict["is_oyla_driver"] as? Int
        {
            UtilityManager.manager.saveDriverType(type: userStatus)
        }
        if let userStatus = userDict["dual_vehicle_cat_id"] as? Int
        {
            UtilityManager.manager.saveDualCatId(type: userStatus)
        }
        
        if let franchise = userDict["franchise"] as? [String:Any]
        {
            if let currency = franchise["currency"] as? String{
                UserDefaults.standard.set(currency, forKey: Constants.USER_CURRENCEY)
            }
        }
        
//        print("bbbbbbbb",UtilityManager.manager.getId())
        
    }
    
    
    func playTune() {
       
        guard let path = Bundle.main.path(forResource: "tune1", ofType:"caf") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func setPoliLineStatus(isDrawn:Bool)
       {
           UserDefaults.standard.set(isDrawn, forKey: Constants.IS_POLYLINE_DRAWN)
       }
    
    
    func isPolyLineDrawn() -> Bool?
       {
           let result = UserDefaults.standard.value(forKey: Constants.IS_POLYLINE_DRAWN) as? Bool
           return result ?? false
       }
    
    
    func clearUserData(){
        let token = UtilityManager.manager.getFcmToken()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UtilityManager.manager.saveFCMToken(token: token)
        UserDefaults.standard.synchronize()
    }
    
    func getVehicleImageName()->String{
        switch UserDefaults.standard.integer(forKey: Constants.VEHICLE_IMAGE_NAME) {
        case 1:
            return "carRed"
        case 10:
            return "bike_map"
        case 9:
            return "richshaw"
        default:
            return "carRed"
        }
        
        
    }
    func saveDriverType(type:Int){
         UserDefaults.standard.setValue(type, forKey: Constants.DRIVER_TYPE)
    }
    
    func saveDualCatId(type:Int){
         UserDefaults.standard.setValue(type, forKey: Constants.DUAL_CAT_ID)
    }
    
    func getDriverType()->Int{
        return UserDefaults.standard.integer(forKey: Constants.DRIVER_TYPE)
    }
    
    func checkIdDualCatAvailable()->Bool{
        if UserDefaults.standard.integer(forKey: Constants.DUAL_CAT_ID) != 0{
            return true
        }
        return false
    }
    
    func saveDualCatOnOff(on:Bool){
        UserDefaults.standard.set(on, forKey: Constants.IS_ON_DUAL)
    }
    
    func getDualCat()->Int{
        return UserDefaults.standard.integer(forKey: Constants.DUAL_CAT_ID)
    }
    
    func saveVehicleName(type:Int){
        print("vehicle type id === ",type)
        return UserDefaults.standard.setValue(type, forKey: Constants.VEHICLE_IMAGE_NAME)
    }
    
    func getCurrentDateString()->String{
        return getDateFormatter().string(from: Date.init())
    }
    
    func getFranchiseName()->String{
         return UserDefaults.standard.string(forKey: Constants.FRANCHISE_NAME) ?? "Missing"
    }
    func getCurrencyForCurrentUser()->String{
        print("USER_CURRENCEY",UserDefaults.standard.string(forKey: Constants.USER_CURRENCEY))
         return UserDefaults.standard.string(forKey: Constants.USER_CURRENCEY) ?? "PK"
    }
    func getCurrentDate()->Date{
        return getDateFormatter().date(from: getCurrentDateString()) ?? Date.init()
    }
    
    func convertDateToString(date:Date)->String?{
        return getDateFormatter().string(from: date)
    }
    func convertStringToDate(date:String)->Date?{
        return getDateFormatter().date(from: date)
    }
    func convertStringToServerDate(date:String)->Date?{
        let d = getServerDateFormatter().date(from: date)
        return d
    }
    func saveWaitingStartTime(time:Date?){
        UserDefaults.standard.setValue(time, forKey: Constants.RIDE_WAITING_TIME_START)
            
    } 
    
    func getWaitingStartTime()->Date?{
        return UserDefaults.standard.value(forKey: Constants.RIDE_WAITING_TIME_START) as? Date
    }
    
    func getNIC()->String?{
        return UserDefaults.standard.value(forKey: Constants.NATIONAL_ID) as? String ?? "_"
    }
    
    func getDateOfJoining(date:String? = nil)->String?{
        if date == nil{
            let joiningDate = convertStringToDate(date: UserDefaults.standard.value(forKey: Constants.JOINING_DATE) as? String ?? "unknown")
            return getDateFormatter().string(from: joiningDate ?? Date.init())
        }else{
            let joiningDate = convertStringToServerDate(date: date ?? "unknown")
            return getDateFormatter().string(from: joiningDate ?? Date.init())
        }
        
    }
    
    
    func getDateFormatterWithTime()->DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }
    
    func getDateFormatter()->DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    func getServerDateFormatter()->DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        return df
    }
    func getCountryCallingCode(countryRegionCode:String)->String{
        
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryRegionCode]
        return countryDialingCode!
    }
    func convertBlockDateAppFormat(blockDate:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: blockDate)
        
        if newDate == nil
        {
            return blockDate
        }
        
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        let appDate = dateFormatter.string(from: newDate!)
        return appDate
        
    }
    func getAuthHeader() -> [String:String]
    {
        let headers = [
            "Authorization": "Bearer \(UtilityManager().getAuthToken())",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        return headers
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func getTimerValue() -> TimeInterval {
        
        let lhs = Date.init()
        let rhs = (UtilityManager.manager.getWaitingStartTime() ?? Date.init())
            return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate

    }
    
    func secondsInTimeIntervals(startTime:Int,endTime:Int)->Double{
        let std = Date(timeIntervalSince1970: TimeInterval(startTime))
        let end = Date(timeIntervalSince1970: TimeInterval(endTime))
        
        let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.second]
        formatter.unitsStyle = .positional
            let difference = formatter.string(from: std, to: end) ?? "0"
            print("Time To cover",difference,"\n")
        
        return Double(difference) ?? 0.0
        
    }
    
    
    
    
//    func isValidEmail(_ stringToCheckForEmail:String) -> Bool {
//        let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
//        
//    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func addHapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle)
    {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    func addLightHapticFeedback()
    {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    
    func getAddressFromLatLong(latitude: Double, longitude : Double,completionHandler:@escaping ( _ adress:String?)-> Void) {

        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(latitude)") ?? Constants.DEFAULT_LAT
        let lon: Double = Double("\(longitude)") ?? Constants.DEFAULT_LONG
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        guard let pm = placemarks else{return}
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                                
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality!
                                                    + ", "
                                               
                                            }
                                            if pm.administrativeArea != nil {
                                                addressString = addressString + pm.administrativeArea! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                               
                                            }
                                            completionHandler(addressString)
                                        }
                                    })
    }
    
    
    func checkIfSunday()->Bool{
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: today)

        if components.weekday == 1 {
           return true
        } else {
            return false
        }
    }
    
    func muteTune(){
            let volumeView = MPVolumeView()
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
              slider?.value = 1
            }
    }
    
    
    @available(iOS 13.0, *)
    func getSystemIcon(name:String,scale:UIImage.SymbolScale,weight:UIImage.SymbolWeight,pointSize:CGFloat) -> UIImage {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize:pointSize, weight: weight, scale: scale)
        return  UIImage(systemName: name, withConfiguration: symbolConfig)!
    }
}


extension UILabel {
    func createDottedLine(width: CGFloat, color: CGColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,2]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}

extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}




extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
      slider?.value = volume
    }
  }
}




extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
//            if let sideMenuVC = nav.presentedViewController as? SideMenuViewController{
//                return getTopMostViewController(base: sideMenuVC)
//            }else{
            print("Navigation return")
            return getTopMostViewController(base: nav.visibleViewController)
//            }
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        print(base)
        print("base returned")
        return base
    }
}
