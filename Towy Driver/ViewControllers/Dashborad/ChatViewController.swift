//
//  ChatViewController.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 12/07/2021.
//  Copyright © TOWY. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import IQKeyboardManager


class ChatViewController: UIViewController {

    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var txtMessage:UITextField!
    @IBOutlet weak var textAreaBottom:NSLayoutConstraint!
    
    
    var ref:DatabaseReference!
    var pasengerFcm:String? = nil
    var messages = [Message]()
    var booking:BookingInfo? = nil
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startObservingKeyboard()
        txtMessage.setPadding(20)
        txtMessage.delegate = self
        txtMessage.placeholder = "Write to send message..."
        ref = Database.database().reference()
        
        tblView.register(UINib.init(nibName: "SenderTableViewCell", bundle: .main), forCellReuseIdentifier: "SenderTableViewCell")
        tblView.register(UINib.init(nibName: "ReceiverTableViewCell", bundle: .main), forCellReuseIdentifier: "ReceiverTableViewCell")
        
        tblView.estimatedRowHeight = 800
        self.getdata()

//        SHOW_CUSTOM_LOADER()
//        Auth.auth().signInAnonymously { result, error in
//            HIDE_CUSTOM_LOADER()
//            if error != nil{
//                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "Error connecting server...")
//            }else{
//                self.getdata()
//            }
//        }
        
        
//        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 25))
//        txtMessage.leftView = leftView
//        txtMessage.leftViewMode = .always
//        txtMessage.addSubview(leftView)
        
        getPassengerFcm { fcm in
            if fcm != nil{
                self.pasengerFcm = fcm
            }else{
                UtilityManager.manager.showAlertView(title: Constants.APP_NAME, message: "Oops error getting passnger fcm token.")
            }
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.RESET_BANNER.rawValue), object: nil, userInfo: nil)
    }
    
    
    private func startObservingKeyboard() {
      let notificationCenter = NotificationCenter.default
      notificationCenter.addObserver(
        forName: UIResponder.keyboardWillShowNotification,
        object: nil,
        queue: nil,
        using: keyboardWillAppear)
      notificationCenter.addObserver(
        forName: UIResponder.keyboardWillHideNotification,
        object: nil,
        queue: nil,
        using: keyboardWillDisappear)
    }
    
    private func keyboardWillAppear(_ notification: Notification) {
      let key = UIResponder.keyboardFrameEndUserInfoKey
      guard let keyboardFrame = notification.userInfo?[key] as? CGRect else {
        return
      }
      let safeAreaBottom = view.safeAreaLayoutGuide.layoutFrame.maxY
      let viewHeight = view.bounds.height
      let safeAreaOffset = viewHeight - safeAreaBottom
      let lastVisibleCell = tblView.indexPathsForVisibleRows?.last
        
        UIView.animate(
          withDuration: 0.3,
          delay: 0,
          options: [.curveEaseInOut],
          animations: {
            self.textAreaBottom.constant = -keyboardFrame.height + safeAreaOffset
            self.view.layoutIfNeeded()
            if let lastVisibleCell = lastVisibleCell {
              self.tblView.scrollToRow(
                at: lastVisibleCell, at: .bottom, animated: false)
            }
        })
        
    }
    
    private func keyboardWillDisappear(_ notification: Notification) {
      UIView.animate(
        withDuration: 0.3,
        delay: 0,
        options: [.curveEaseInOut],
        animations: {
            if self.messages.count > 0{
                self.tblView.scrollToRow(at: IndexPath.init(row: self.messages.count-1, section: 0), at: .bottom, animated: false)
            }
          self.textAreaBottom.constant = -12
          self.view.layoutIfNeeded()
      })
    }
    
    @IBAction func sendMessage( _ sender : UIButton){
        txtMessage.text = removeSpace()
        if txtMessage.text != ""{
            if booking?.id != nil{
//                \(UtilityManager.manager.getId())
                let paramas = ["booking_id":"\(booking!.id!)","receiver_id":booking?.passenger_id ?? "","sender_id":UtilityManager.manager.getId(),"message":txtMessage.text!,"messageTime":Date.init().timeIntervalSince1970,"type":"2"] as [String : Any]
                
                ref.child("\(booking!.id!)").child("messages").childByAutoId().setValue(paramas) { err, refer in
                    if err == nil{
                        if self.pasengerFcm != nil{
                            PushNotificationSender().sendPushNotification(to: self.pasengerFcm!, title: "New message by" + " \(UtilityManager.manager.getUserName())", body: self.txtMessage.text!)
                        }
                    }
                    self.txtMessage.text = ""
                }
            }
            
        }
    }
    
    
    func removeSpace()->String{
        let txt = txtMessage.text ?? " "
        var count:Int! = 0
        for i in txt{
            if i  == " "{
                count += 1
            }else{
                if count != 0{
                    return String(txt.dropFirst(count))
                }else{
                    return txt
                }
            }
        }
        return ""
    }
    
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }
    
    func getPassengerFcm(completionHandler:@escaping ( _ fcm:String?)-> Void){
        
        if booking?.id != nil{
            self.ref.child("\(booking!.id!)").child("fcm").child("fcm1").observeSingleEvent(of: .value) { dataSnap in
                if dataSnap.exists(){
                    if let fcmData = dataSnap.value as? String{
                        completionHandler(fcmData)
                    }else{
                        completionHandler(nil)
                    }
                }
            }
        }
        
    }
    
    
    func getdata(){
        if booking?.id != nil{
            ref.child("\(booking!.id!)").child("messages").observe(.childAdded) { dataSnap in
                if dataSnap.exists(){
                    self.messages.append(Message.init(dict: dataSnap.value as? [String:Any] ?? [:]))
                    self.tblView.reloadData()
                    self.tblView.scrollToRow(at: IndexPath.init(row: self.messages.count-1, section: 0), at: .bottom, animated: false)
                }
            }
        }
        
    }
    

}


extension ChatViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ds = messages[indexPath.row]
        if ds.type == "1"{
             let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
            cell.lblMessage.text = ds.message ?? ""
            return cell
        }else{
             let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell", for: indexPath) as! SenderTableViewCell
            cell.lblMessage.text = ds.message ?? ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let ds = messages[indexPath.row]
        if ds.type == "1"{
             let cel = cell as! ReceiverTableViewCell
            cel.lblMessage.text = ds.message ?? ""
        }else{
             let cel = cell as! SenderTableViewCell
            cel.lblMessage.text = ds.message ?? ""
        }
    }
    
  
}

extension ChatViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIView.animate(
          withDuration: 0.3,
          delay: 0,
          options: [.curveEaseInOut],
          animations: {
            textField.resignFirstResponder()
            if self.messages.count > 0{
                self.tblView.scrollToRow(at: IndexPath.init(row: self.messages.count-1, section: 0), at: .bottom, animated: false)
            }
            self.textAreaBottom.constant = -12
            self.view.layoutIfNeeded()
        })
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == " " {
            return false
        }
        return true
    }
    
    
}


extension String {

  func toLengthOf(length:Int) -> String {
            if length <= 0 {
                return self
            } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
                let newStr = String(self[..<to])
                   print(newStr)
                    return newStr
            } else {
                return ""
            }
        }
}
