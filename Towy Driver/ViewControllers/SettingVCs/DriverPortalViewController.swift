//
//  DriverPortalViewController.swift
//  Oyla Captain
//
//  Created by apple on 11/26/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit
import SwiftDate
import DatePicker

class DriverPortalViewController: UIViewController {
    
    
    @IBOutlet weak var lblNoOfTrips: UILabel!
    @IBOutlet weak var lblNoOfCreditTrips: UILabel!

    @IBOutlet weak var lblNoOfPassengerCancel: UILabel!
    @IBOutlet weak var lblBouns: UILabel!
    @IBOutlet weak var lblLastMonthAdjust: UILabel!
    @IBOutlet weak var lblNoOfTripsCancelled: UILabel!
    @IBOutlet weak var lblDriverCancelAmount: UILabel!
    @IBOutlet weak var lblCashTripAmount: UILabel!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblTax:UILabel!
    @IBOutlet weak var lblCreditTripsAmount:UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var cashReceivedByHand: UILabel!
    @IBOutlet weak var collectionV : UICollectionView!
    @IBOutlet weak var passengerCancelAmount: UILabel!
    @IBOutlet weak var payableReceivable: UILabel!
    @IBOutlet weak var btnNext:UIButton!
    @IBOutlet weak var segmentController:UISegmentedControl!
    @IBOutlet weak var btnPrevious:UIButton!
    @IBOutlet weak var imgPrevious:UIButton!
    @IBOutlet weak var btnStartDate:UIButton!
    @IBOutlet weak var btnEndDate:UIButton!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var bottomViewConstraint:NSLayoutConstraint!

    
    @IBOutlet weak var lblCashReceivedByPartner: UILabel!
    @IBOutlet weak var lblCashpPaidByPartner: UILabel!
    @IBOutlet weak var lblRemainings: UILabel!

    
    var datasoutce = [PortalData]()
    
    var DF = "yyyy-MM-dd"
    var serverDF = "yyyy-MM-dd HH:mm:ss"
    var currency = Constants.Currency
    var startOfWeek:String!
    var endOfWeek:String!
    var isCurrentWeek = true
    var startDate = ""
    var endDate = ""
    
    var WeekNo:Int? = 0{
        didSet{
            if WeekNo == 0 {
                isCurrentWeek = true
                
                if #available(iOS 13.0, *) {
                    btnNext.setImage(UtilityManager.manager.getSystemIcon(name: "chevron.right.circle.fill", scale: .medium, weight: .regular, pointSize: 23), for: .normal)
                } else {
                    // Fallback on earlier versions
                    btnNext.setImage(UIImage.init(named: "arrowLeftYellow"), for: .normal)
                }
            }else{
                isCurrentWeek = false
                btnNext.setImage(UIImage.init(named: "rightArrowTheme"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            segmentController.selectedSegmentTintColor = UIColor.init(named: Constants.AssetsColor.ThemeBtnColor.rawValue)
            segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

        }
        lblName.text = UtilityManager.manager.getUserName()
        btnNext.isHidden = true
        btnPrevious.isHidden = true
        imgPrevious.isHidden = true
        btnEndDate.isHidden = true
        btnStartDate.isHidden = true
        lblTo.isHidden = true
        bottomViewConstraint.constant = 20
        getTodaysEarning()
    }
    
    func getTodaysEarning(){
        
       segmentController.selectedSegmentIndex = 0
        let date = "\(Date.init().toFormat(DF))"
        lblRange.text = ""
         getDriverPortalData(startDate:date + " 00:00:00",endDate:date + " 23:59:59")
        
    }
  
    //MARK :- IBACTIONS
    
    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    
    @IBAction func profileTapped(_ sender:UIButton){
        UtilityManager.manager.navigateToVc(from: self, identifier: "ProfileDetailsViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
    }
    
    @IBAction func historyTapped(_ sender:UIButton){
        UtilityManager.manager.navigateToVc(from: self, identifier: "HistoryViewController", storyBoard: UtilityManager.manager.getMainStoryboard())
    }
    
    
    @IBAction func previousWeek(_ sender: Any) {
    
        getPreviousWeekStart()
        
    }
    
    @IBAction func currentWeek(_ sender: Any) {
  
       getNextWeekStart()
        
    }
    
    @IBAction func btnStartDateTapped(_ sender: UIButton) {
           let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 01, year: 2010)!
           let today = Date()
           let datePicker = DatePicker()
        datePicker.setup(beginWith: today, min: minDate, max: today) { [self] (selected, date) in
               if selected, let selectedDate = date {
                startDate = selectedDate.toFormat(DF)
                btnStartDate.setTitle(startDate, for: .normal)
                if endDate != "" {
                    getDriverPortalData(startDate: startDate + " 00:00:00", endDate: endDate + " 23:59:59")
                }
               } else {
                   print("Cancelled")
               }
           }
           datePicker.show(in: self, on: sender)
       }
    
    @IBAction func btnEndDateTapped(_ sender: UIButton) {
           let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 01, year: 2010)!
           let today = Date()
           let datePicker = DatePicker()
        datePicker.setup(beginWith: today, min: minDate, max: today) { [self](selected, date) in
               if selected, let selectedDate = date {
                self.endDate = selectedDate.toFormat(self.DF)
                self.btnEndDate.setTitle(self.endDate, for: .normal)
                if startDate != "" {
                    getDriverPortalData(startDate: startDate + " 00:00:00", endDate: endDate + " 23:59:59")
                }
               } else {
                   print("Cancelled")
               }
           }
           datePicker.show(in: self, on: sender)
       }
    
    @IBAction func changeViewType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
//        case 0:
//            btnNext.isHidden = true
//            btnPrevious.isHidden = true
//            imgPrevious.isHidden = true
//            UtilityManager.manager.showAlertView(title: "Oops", message: "Coming soon")
        case 0:
            UIView.animate(withDuration: 0.5) { [self] in
                bottomViewConstraint.constant = 20
                btnEndDate.isHidden = true
                btnStartDate.isHidden = true
                lblTo.isHidden = true
                self.view.layoutIfNeeded()
            } completion: { (b) in
             
            }
            startOfWeek = nil
            endOfWeek = nil
            WeekNo = 0
            btnNext.isHidden = true
            btnPrevious.isHidden = true
            imgPrevious.isHidden = true
            getTodaysEarning()
        case 1:
            startDate = ""
            endDate = ""
            btnStartDate.setTitle("Start Date", for: .normal)
            btnEndDate.setTitle("End Date", for: .normal)
            btnStartDate.isHidden = false
            btnEndDate.isHidden = false
            lblTo.isHidden = false
            UIView.animate(withDuration: 0.5) { [self] in
                bottomViewConstraint.constant = 72.5
                self.view.layoutIfNeeded()
            } completion: { (b) in
             
            }

            
            
//            btnNext.isHidden = false
//            btnPrevious.isHidden = false
//            imgPrevious.isHidden = false
            
//            if UtilityManager.manager.checkIfSunday() && WeekNo == 0{
//                endOfWeek =  Date().toFormat(serverDF)
//                startOfWeek = Date().dateByAdding(-6, .day).toFormat(serverDF)
//                lblRange.text = Date().dateByAdding(-6, .day).toFormat(DF) + " TO " + Date().toFormat(DF)
//            }else{
//                startOfWeek =  Date.init().startOfWeek!.toFormat(DF)
//                endOfWeek = Date.init().endOfWeek?.dateByAdding(1, .day).toFormat(DF)
//                lblRange.text = "\(Date.init().startOfWeek!.toFormat(DF))" + " TO " + "\(Date.init().endOfWeek?.dateByAdding(1, .day).toFormat(DF) ?? "")"
//            }
//            getDriverPortalData(startDate: startOfWeek + " 00:00:00", endDate: endOfWeek + " 23:59:59")
            
        default:
            print("")
        }
    }
    
    func getPreviousWeekStart(){
        
        
        let dateString = startOfWeek!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DF

        let dateObj = dateFormatter.date(from: dateString)?.addingTimeInterval(-86400*2)
        
        startOfWeek =  dateObj?.startOfWeek!.toFormat(DF)
        endOfWeek = dateObj?.endOfWeek?.dateByAdding(1, .day).toFormat(DF)
        
        DispatchQueue.main.async {
            self.lblRange.text = self.getFormattedDate(date: self.startOfWeek) + " TO " + self.getFormattedDate(date: self.endOfWeek)
        }
        WeekNo! -= 1
        self.getDriverPortalData(startDate: startOfWeek, endDate: endOfWeek)
    }
 
    
    func getNextWeekStart(){
        
        if !isCurrentWeek{
            let dateString = endOfWeek!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DF

            let dateObj = dateFormatter.date(from: dateString)?.addingTimeInterval(86400*2)
            
            startOfWeek =  dateObj?.startOfWeek!.toFormat(DF)
            endOfWeek = dateObj?.endOfWeek?.dateByAdding(1, .day).toFormat(DF)
            
            DispatchQueue.main.async {
                self.lblRange.text = self.getFormattedDate(date: self.startOfWeek) + " TO " + self.getFormattedDate(date: self.endOfWeek)
            }
            WeekNo! += 1
            self.getDriverPortalData(startDate: startOfWeek + " 00:00:00", endDate: endOfWeek+" 23:59:59")
        }
    }
    
    
   
    
    
    func getFormattedDate(date:String)->String{
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DF

        let dateObj = dateFormatter.date(from: dateString)

        dateFormatter.dateFormat = DF
        
       return dateFormatter.string(from: dateObj!)
        
    }
    
    
    
    func dayRangeOf(weekOfYear: Int, for date: Date) -> Range<Date>
    {
        let calendar = Calendar.current
        let year = calendar.component(.yearForWeekOfYear, from: date)
        let startComponents = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: year)
        let startDate = calendar.date(from: startComponents)!
        let endComponents = DateComponents(day:7, second: -1)
        let endDate = calendar.date(byAdding: endComponents, to: startDate)!
        return startDate..<endDate
    }

    func getPreviousWeekEndDay() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date.init()))
        return gregorian.date(byAdding: .day, value: -1, to: sunday!)!
    }
    
    
//MARK :- API CALLS
    
    
    func getDriverPortalData(startDate:String,endDate:String){
        
        SHOW_CUSTOM_LOADER()
        LedgerManager.manager.getLeadgerInfo(params: ["user_id":UtilityManager.manager.getId(),"fromDate":startDate,"tillDate":endDate]) { [self] (data, err) in
            HIDE_CUSTOM_LOADER()
            if err == nil{
                DispatchQueue.main.async {
                    self.populateData(data)
                }
                
            }
        }
    }
    
    func populateData(_ data:[String:Any]?){
        
//        let accountData = data?["driverAccountSummary"] as? [String:Any]
        let portalData = DriverAccountSumary.init(dict: data ?? [:])
        
        var percentage = 0.0
        
        if portalData.totalCompletedRides ?? 0 > 1 &&  portalData.totalReceivedRides ?? 0 > 1 {
            let a:Double = portalData.totalCompletedRides ?? 1
            let b:Double = portalData.totalReceivedRides ?? 1
            percentage = a/b * 100
        }
        
       
        
        self.datasoutce = PortalData.getData(dict: ["ratingsAvg":" \(portalData.ratingsAvg?.rounded(toPlaces: 2) ?? 0)","totalLoginHours": "0" ,"acceptRidesPercent":"\(portalData.acceptRidesPercent?.rounded(toPlaces: 2) ?? 0) %","percentage": percentage.rounded(toPlaces: 2)])

        self.collectionV.reloadData()
        self.lblCashTripAmount.text = "\(currency) \(portalData.totalDriverCashEarnings?.rounded(toPlaces: 2) ?? 0.0)"
        self.lblCreditTripsAmount.text = self.currency + " \(portalData.totalDriverWalletAmount?.rounded(toPlaces: 0) ?? 0)"
        self.lblLastMonthAdjust.text = self.currency + " \(portalData.previous_total_amount?.rounded(toPlaces: 0) ?? 0)"
        self.lblNoOfTrips.text = "\(portalData.totalCompletedRides ?? 0) X"
        self.lblNoOfTripsCancelled.text = "\(portalData.totalDriverCancelRides ?? 0) X"
        self.lblDriverCancelAmount.text = self.currency + " \(portalData.totalDriverCancelPenalty?.rounded() ?? 0.0)"
        self.lblBouns.text = self.currency + " \(portalData.driverTotalBonus?.rounded() ?? 0.0)"
        self.lblNoOfPassengerCancel.text = "\(portalData.totalPassengerCancelRides ?? 0) X"
        self.cashReceivedByHand.text = self.currency + " \(portalData.totalCashCollectedByDriver?.rounded() ?? 0)"
        self.grandTotal.text = self.currency + " \(portalData.newSum?.rounded(toPlaces: 0) ?? 0)"
//        let PR = Double((portalData.newSum?.rounded(toPlaces: 0) ?? 0)-portalData.totalCashCollectedByDriver!).rounded(toPlaces: 2) + (portalData.driverTotalBonus?.rounded(toPlaces: 2))!
        self.payableReceivable.text = self.currency + " \(portalData.final_total_amount?.rounded() ?? 0.0)"
        self.passengerCancelAmount.text = self.currency + " \(portalData.totalDriverCancelPenalty?.rounded(toPlaces: 2) ?? 0)"
        if portalData.final_total_amount ?? 0 < 0 {
            self.payableReceivable.textColor = UIColor.systemRed
            self.payableReceivable.text = self.currency + " \(portalData.final_total_amount?.rounded() ?? 0.0)"
        }else{
            self.payableReceivable.textColor = UIColor.systemGreen
        }
        
        if portalData.previous_total_amount?.rounded(toPlaces: 0) ?? 0.0 < 0.0{
            self.lblLastMonthAdjust.textColor = UIColor.systemRed
        }else{
            self.lblLastMonthAdjust.textColor = UIColor.systemGreen
        }
        
        lblTax.text = "\(currency) \(portalData.totalTaxAmount?.rounded(toPlaces: 0) ?? 0.0)"
        lblCashReceivedByPartner.text = "\(currency) \(portalData.amountPaidToDriver?.rounded(toPlaces: 0) ?? 0.0)"
        lblCashpPaidByPartner.text = "\(currency) \(portalData.amountReceivedFromDriver?.rounded(toPlaces: 0) ?? 0.0)"
        lblRemainings.text = "\(currency) \(portalData.remainings?.rounded(toPlaces: 0) ?? 0.0)"
    }
    
}

//MARK :- extensions

extension DriverPortalViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if datasoutce.count > 0 {
            return datasoutce.count
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptainProtalCollectionViewCell", for: indexPath as IndexPath) as! CaptainProtalCollectionViewCell
        if datasoutce.count > 0{
            cell.obj = datasoutce[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0
        collectionViewSize.height = 70
        return collectionViewSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0:
            print("")
        case 1:
            print("")
        case 2:
            print("")
        case 3:
            print("")
        default:
            print("")
        }
        
    }
    
}


extension Date {
    
    
//    var df : DateFormatter(){
//        df.dateFormat = "DD-MMM-YYYY"
//    }
    
    var startOfWeek: Date? {
        let localIdentifier = Locale.current.calendar.identifier
        let gregorian = Calendar(identifier: localIdentifier)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value:2, to: sunday)
    }

    var endOfWeek: Date? {
        let localIdentifier = Locale.current.calendar.identifier
        let gregorian = Calendar(identifier: localIdentifier)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}
