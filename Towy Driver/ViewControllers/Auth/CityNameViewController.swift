//
//  CityNameViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 07/07/2022.
//

import UIKit
import CoreLocation
import GoogleMaps


class CityNameViewController: UIViewController,LocationDelagates {

    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var txtCitytName:UITextField!
    @IBOutlet weak var tbSearch:UITableView!

    
    var user = User()
    
//    var autocompleteResults :[GApiResponse.Autocomplete] = []
    var autocompleteResults :[GApiResponse.Autocomplete] = []

    var CurrentLat  = CLLocationDegrees()
    var CurrentLong = CLLocationDegrees()
    
    var sourceLocation  = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    var currentTFTag = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if user.mobileNumber == nil{
//            user = User.init(dictionary: UtilityManager.manager.getModelFromUserDefalts(key: Constants.APP_USER)!) 
//        }
        tbSearch.delegate = self
        tbSearch.dataSource = self
        self.tbSearch.register(UINib(nibName: "PlacesTBCell", bundle: nil), forCellReuseIdentifier: "PlacesTBCell")

        getAddressFromlatLong(lat: CurrentLat, long: CurrentLong, point: "Source")
        sourceLocation = CLLocationCoordinate2D(latitude: CurrentLat, longitude: CurrentLong)
        txtCitytName.delegate = self
        btnNext.disable()
        txtCitytName.setPadding(12)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtCitytName.becomeFirstResponder()
    }
    
    func OnUpdate(Lat: CLLocationDegrees, Long: CLLocationDegrees , tag: Int) {
        currentTFTag = tag
        if currentTFTag == 0{
            getAddressFromlatLong(lat: Lat, long: Long, point: "Source")
        }else{
            getAddressFromlatLong(lat: Lat, long: Long, point: "Destination")
        }
    }

    
    
    func getAddressFromlatLong(lat: Double, long: Double,point:String) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let geocoder = GMSGeocoder()
        var add = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { [self] (response, error) in
          if let address = response?.firstResult() {
            
            guard let arrAddress = address.lines else {return}
            if arrAddress.count > 1 {
                add =  (arrAddress[1])
            }else if arrAddress.count == 1 {
                add =  (arrAddress[0])
                if point == "Source"{
                    self.txtCitytName.text = add
                }
            }
          }
        }
        
        
      }
    
    func showResults(string:String){
        var input = GInput()
        input.keyword = string
        
        GoogleApi.shared.callApi(.autocomplete,input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                
                DispatchQueue.main.async {
                    //                    self.searchTableView.isHidden = false
                    print("responseSearch",response.data)
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.tbSearch.reloadData()
                }
            } else { print(response.error ?? "ERROR") }
        }
        
        /*
        GoogleApi.shared.callApi(.autocomplete,input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    //                    self.searchTableView.isHidden = false
                    print("responseSearch",response.data)
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.tbSearch.reloadData()
                }
            } else { print(response.error ?? "ERROR") }
        }
        */
    }
    

    @IBAction func btnNext(_ sender: Any) {
        
        
       
        if txtCitytName.text == ""{
            UtilityManager.manager.showAlert(self, message: "Please enter city name.", title: Constants.APP_NAME)
            return
        }
        registerUser()
        
    }
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    
    func registerUser(){
        
        let params = ["user_type":"2",
                      "fcm_token":UtilityManager.manager.getFcmToken(),"password":user.password,
                      "password_confirmation":user.password,
                      "city":user.city ?? txtCitytName.text!,
                      "first_name":user.first_name,
                      "last_name":user.last_name,
                      "login":user.mobile_no ?? user.email,
                      "referrer":user.referral_code]
//        ["user_type":"2",
//                      "fcm_token":"jgdfjhsdhfjsgjfhsdf4b3bb 435","password":"123456789a",
//                      "password_confirmation":"123456789a",
//                      "city":"Lahore",
//                      "first_name":"mnbfdsn",
//                      "last_name":"sdfbskdjf",
//                      "login":"034564645475985"]
        SignUpManager.manager.signup(params: params as [String : Any]) { result, message in
            if message == nil{
                
                 self.user.city = self.txtCitytName.text!
                 
                 let st = UtilityManager.manager.getAuthStoryboard()
                 let vc = st.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
                 vc.user = self.user
                UtilityManager.manager.saveModelInUserDefaults(key: Constants.APP_USER, data: User.getDictFromUser(user: self.user))
                self.navigationController?.pushViewController(vc, animated: true)

            }else{
                UtilityManager.manager.showAlert(self, message: message!, title: "Oops")
            }
        }
    }

}

extension CityNameViewController:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let fullText = text.replacingCharacters(in: range, with: string)
        if fullText.count > 2 {
            showResults(string:fullText)
        }else{
            
            //hideResults()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tbSearch.isHidden = false
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtCitytName.text != ""{
            btnNext.enable()
        }else{
            btnNext.disable()
        }
     
        
        if textField.text == ""{
            textField.layer.borderWidth = 0
        }
        
        if txtCitytName.text == ""{
            getAddressFromlatLong(lat: CurrentLat, long: CurrentLong, point: "Source")
            self.sourceLocation = CLLocationCoordinate2D(latitude: CurrentLat, longitude: CurrentLong)
        }
        self.txtCitytName?.text = textField.text ?? ""
        
    }
    
}



extension CityNameViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTBCell", for: indexPath) as! PlacesTBCell
//        if indexPath.row == autocompleteResults.count {
//            //cell.lblTitle.text = ""
//            cell.lblTitle.text = "Set location on map"
//        }else {
//            cell.lblTitle.text = autocompleteResults[indexPath.row].title
            cell.lblTitle.text = autocompleteResults[indexPath.row].formattedAddress
            //cell.lblSubTitle.text = autocompleteResults[indexPath.row].title

//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        txtCitytName.text = autocompleteResults[indexPath.row].formattedAddress
        btnNext.enable()
        txtCitytName.resignFirstResponder()
        tbSearch.isHidden = true
    }
        //        tfLocation?.text = autocompleteResults[indexPath.row].formattedAddress
        //        tfLocation?.resignFirstResponder()
//        if indexPath.row == autocompleteResults.count{
//
//            let vc = UtilityManager.manager.getAuthStoryboard().instantiateViewController(withIdentifier: "selectLocationVC") as! selectLocationVC
//            if currentTFTag == 0{
//
//            }else{
//                vc.sourceLocation = sourceLocation
//            }
//            vc.currentTFTag = currentTFTag
//            vc.delegate = self
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else {
//            var input = GInput()
//            input.keyword = autocompleteResults[indexPath.row].placeId
//            GoogleApi.shared.callApi(.placeInformation,input: input) { (response) in
//                if let place =  response.data as? GApiResponse.PlaceInfo, response.isValidFor(.placeInformation) {
//                    DispatchQueue.main.async {
//                        // self.searchTableView.isHidden = true
//                        if let lat = place.latitude, let lng = place.longitude{
//                            let center  = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//                            //                        self.selected_lat = center.latitude
//                            //                        self.selected_lang = center.longitude
//                            let dataToBeSent = ["lat":center.latitude,"lng":center.longitude] as [String : Any]
//
//                            if self.currentTFTag == 0{
//                                self.sourceLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
//                                self.getAddressFromlatLong(lat: center.latitude, long: center.longitude, point: "Source")
//                            }else{
//                                if self.txtCitytName.text == ""{
//                                    self.destinationLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
//                                    self.getAddressFromlatLong(lat: center.latitude, long: center.longitude, point: "Destination")
//                                }else{
////                                    let vc = UtilityManager.manager.getAuthStoryboard().instantiateViewController(withIdentifier: "MainMapVC") as! MainMapVC
////                                    vc.destinationLocation = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
////                                    vc.sourceLocation = self.sourceLocation
//////                                    vc.strDestination = self.autocompleteResults[indexPath.row].formattedAddress
////                                    self.navigationController?.pushViewController(vc, animated: true)
//                                }
//                            }
                            
                            
                            
                            
                            
                            // self.delegate?.sendDataToMapVC(myData: dataToBeSent)
                            //self.navigationController?.popViewController(animated: true)
                            
                            //
                            //                        if self.delegate != nil && self.selected_lat != 0.0 && self.selected_lang != 0.0 {
                            //
                            //                            let dataToBeSent = ["lat":self.selected_lat,"lng":self.selected_lang]
                            //                            self.delegate?.sendDataToMapVC(myData: dataToBeSent)
                            //                            self.navigationController?.popViewController(animated: true)
                            //                        }
                            //self.mapView.animate(to: GMSCameraPosition.camera(withLatitude:center.latitude, longitude: center.longitude, zoom: 15.0))
//                        }
                        //                    self.searchTableView.reloadData()
//                    }
//                }
//else { print(response.error ?? "ERROR") }
//            }
            
//        }
        
//    }
    
    
}
