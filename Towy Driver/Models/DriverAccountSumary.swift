//
//  DriverAccountSumary.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 26/02/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class DriverAccountSumary{
    
    var driverTotalCashReceived : Double?
    var driverTotalDueAmount : Double?
    var driverTotalExtras :Double?
    var driverTotalEarnings : Double?
    var walletTotalAmount : Double?
    var acceptRidesPercent : Double?
    var totalRejectRides : Double?
    var driverOylaSharePaid : Double?
    var driverTotalBonus :Double?
    var driverOylaShareDue : Double?
    var totalIgnoreRides :Double?
    var driverCancelPanelty : Double?
    var totalAcceptRides :Double?
    var final_total_amount :Double?
    var totalLoginDurations :Double?
    var ratingsAvg :Double?
    var totalReceivedRides: Double?
    var totalCompletedRides : Double?
    var totalDriverCancelRides : Double?
    var totalPassengerCancelRides : Double?
    var totalSystemCancelRides : Double?
    var totalLoginHours : String?
    var previous_total_amount : Double?
    var passengerCancelPenaltyAmount : Double?
    var passengerPaidExtraAmount : Double?
    var totalCashCollectedByDriver: Double?
    var newSum : Double?
    var totalTaxAmount : Double?
    var totalCashReceivedFromPartner : Double?
    var totalCashPaidToPartner : Double?
    var remainings : Double?
    
    init(driverTotalCashReceived: Double? = 0, driverTotalDueAmount: Double? = 0, driverTotalExtras: Double? = 0, driverTotalEarnings: Double? = 0, walletTotalAmount: Double? = 0, acceptRidesPercent: Double? = 0, totalRejectRides: Double? = 0, driverOylaSharePaid: Double? = 0, driverTotalBonus: Double? = 0, driverOylaShareDue: Double? = 0, totalIgnoreRides: Double? = 0, driverCancelPanelty: Double? = 0, totalAcceptRides: Double? = 0, final_total_amount: Double? = 0, totalLoginDurations: Double? = 0, ratingsAvg: Double? = 0, totalReceivedRides: Double? = 0, totalCompletedRides: Double? = 0, totalDriverCancelRides: Double? = 0, totalPassengerCancelRides: Double? = 0, totalSystemCancelRides: Double? = 0, totalLoginHours : String? = "00:00:00",previous_total_amount: Double? = 0,passengerCancelPenaltyAmount: Double? = 0, passengerPaidExtraAmount: Double? = 0, totalCashCollectedByDriver:Double? = 0, newSum : Double? = 0 ,  totalTaxAmount : Double? = 0,totalCashReceivedFromPartner: Double? = nil ,totalCashPaidToPartner: Double? = nil, remainings: Double? = nil) {
        
        self.driverTotalCashReceived = driverTotalCashReceived
        self.driverTotalDueAmount = driverTotalDueAmount
        self.driverTotalExtras = driverTotalExtras
        self.driverTotalEarnings = driverTotalEarnings
        self.walletTotalAmount = walletTotalAmount
        self.acceptRidesPercent = acceptRidesPercent
        self.totalRejectRides = totalRejectRides
        self.driverOylaSharePaid = driverOylaSharePaid
        self.driverTotalBonus = driverTotalBonus
        self.driverOylaShareDue = driverOylaShareDue
        self.totalIgnoreRides = totalIgnoreRides
        self.driverCancelPanelty = driverCancelPanelty
        self.totalAcceptRides = totalAcceptRides
        self.final_total_amount = final_total_amount
        self.totalLoginDurations = totalLoginDurations
        self.ratingsAvg = ratingsAvg
        self.totalReceivedRides = totalReceivedRides
        self.totalCompletedRides = totalCompletedRides
        self.totalDriverCancelRides = totalDriverCancelRides
        self.totalPassengerCancelRides = totalPassengerCancelRides
        self.totalSystemCancelRides = totalSystemCancelRides
        self.totalLoginHours = totalLoginHours
        self.previous_total_amount = previous_total_amount
        self.passengerCancelPenaltyAmount = passengerCancelPenaltyAmount
        self.passengerPaidExtraAmount = passengerPaidExtraAmount
        self.totalCashCollectedByDriver = totalCashCollectedByDriver
        self.newSum = newSum
        self.totalTaxAmount = totalTaxAmount
        self.totalCashReceivedFromPartner = totalCashReceivedFromPartner
        self.totalCashPaidToPartner = totalCashPaidToPartner
        self.remainings = remainings
    }
    
    
    init(dict:[String:Any]) {
        self.driverTotalCashReceived = dict["driverTotalCashReceived"] as? Double ?? 0
        self.driverTotalDueAmount = dict["driverTotalDueAmount"] as? Double ?? 0
        self.driverTotalExtras = dict["driverTotalExtras"] as? Double ?? 0
        self.driverTotalEarnings = dict["driverTotalEarnings"] as? Double ?? 0
        self.walletTotalAmount = dict["walletTotalAmount"] as? Double ?? 0
        self.acceptRidesPercent = dict["acceptRidesPercent"] as? Double ?? 0
        self.totalRejectRides = dict["totalRejectRides"] as? Double ?? 0
        self.driverOylaSharePaid = dict["driverOylaSharePaid"] as? Double ?? 0
        self.driverTotalBonus = dict["driverTotalBonus"] as? Double ?? 0
        self.driverOylaShareDue = dict["driverOylaShareDue"] as? Double ?? 0
        self.totalIgnoreRides = dict["totalIgnoreRides"] as? Double ?? 0
        self.driverCancelPanelty = dict["driverCancelPanelty"] as? Double ?? 0
        self.totalAcceptRides = dict["totalAcceptRides"] as? Double ?? 0
        self.final_total_amount = dict["final_total_amount"] as? Double ?? 0
        self.totalLoginDurations = dict["totalLoginDurations"] as? Double ?? 0
        self.ratingsAvg = dict["ratingsAvg"] as? Double ?? 0
        self.totalReceivedRides = dict["totalReceivedRides"] as? Double ?? 0
        self.totalCompletedRides = dict["totalCompletedRides"] as? Double ?? 0
        self.totalDriverCancelRides = dict["totalDriverCancelRides"]  as? Double ?? 0
        self.totalPassengerCancelRides = dict["totalPassengerCancelRides"] as? Double ?? 0
        self.totalSystemCancelRides = dict["totalSystemCancelRides"]  as? Double ?? 0
        self.totalLoginHours = dict["totalLoginHours"]  as? String ?? "00:00:00"
        self.previous_total_amount = dict["previous_total_amount"] as? Double ?? 0
        self.passengerCancelPenaltyAmount = dict["passengerCancelPenaltyAmount"] as? Double ?? 0.0
        self.passengerPaidExtraAmount = dict["passengerPaidExtraAmount"] as? Double ?? 0.0
        self.totalCashCollectedByDriver = dict["totalCashCollectedByDriver"] as? Double ?? 0.0
        self.newSum = dict["newSum"] as? Double ?? 0.0
        self.totalTaxAmount = dict["totalTaxAmount"] as? Double ?? 0.0
        self.totalCashReceivedFromPartner = dict["totalCashReceivedFromPartner"] as? Double ?? 0.0
        self.totalCashPaidToPartner = dict["totalCashPaidToPartner"] as? Double ?? 0.0
        self.remainings = dict["remainings"] as? Double ?? 0.0
    }
    
    
}
