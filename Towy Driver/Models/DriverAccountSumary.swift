//
//  DriverAccountSumary.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 26/02/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class DriverAccountSumary{
    

    var acceptRidesPercent : Double?
    var totalRejectRides : Double?
    var driverTotalBonus :Double?
    var totalIgnoreRides :Double?
    var totalAcceptRides :Double?
    var final_total_amount :Double?
    var ratingsAvg :Double?
    var totalReceivedRides: Double?
    var totalCompletedRides : Double?
    var totalDriverCancelRides : Double?
    var totalPassengerCancelRides : Double?
    var previous_total_amount : Double?
    var passengerPaidExtraAmount : Double?
    var totalCashCollectedByDriver: Double?
    var newSum : Double?
    var totalTaxAmount : Double?
    var remainings : Double?
    
    var totalDriverCreditAmount : Double?
    var amountReceivedFromDriver : Double?
    var totalPassengerCancelPenalty : Double?
    var totalDriverCashEarnings : Double?
    var totalRideActualAmount : Double?
    var completeRidesPercent : Double?
    var totalDriverWalletAmount : Double?
    var totalPassengerPaidExtraAmount : Double?
    var amountPaidToDriver : Double?
    var totalDriverCancelPenalty : Double?
    
    
    init(totalDriverCreditAmount: Double? = 0, amountReceivedFromDriver: Double? = 0, totalRideActualAmount: Double? = 0, totalDriverCashEarnings: Double? = 0, walletTotalAmount: Double? = 0, acceptRidesPercent: Double? = 0, totalRejectRides: Double? = 0, driverOylaSharePaid: Double? = 0, driverTotalBonus: Double? = 0, driverOylaShareDue: Double? = 0, totalIgnoreRides: Double? = 0, totalPassengerCancelPenalty: Double? = 0, totalAcceptRides: Double? = 0, final_total_amount: Double? = 0, totalLoginDurations: Double? = 0, ratingsAvg: Double? = 0, totalReceivedRides: Double? = 0, totalCompletedRides: Double? = 0, totalDriverCancelRides: Double? = 0, totalPassengerCancelRides: Double? = 0, totalSystemCancelRides: Double? = 0, totalLoginHours : String? = "00:00:00",previous_total_amount: Double? = 0,passengerCancelPenaltyAmount: Double? = 0, passengerPaidExtraAmount: Double? = 0, totalCashCollectedByDriver:Double? = 0, newSum : Double? = 0 ,  totalTaxAmount : Double? = 0,totalCashReceivedFromPartner: Double? = nil ,totalCashPaidToPartner: Double? = nil, remainings: Double? = nil,completeRidesPercent: Double? = nil,totalDriverWalletAmount:Double? = 0,totalPassengerPaidExtraAmount:Double? = 0,amountPaidToDriver:Double? = 0,totalDriverCancelPenalty:Double? = 0) {
        
       
        self.acceptRidesPercent = acceptRidesPercent
        self.totalRejectRides = totalRejectRides
        self.driverTotalBonus = driverTotalBonus
        self.totalIgnoreRides = totalIgnoreRides
        self.totalAcceptRides = totalAcceptRides
        self.final_total_amount = final_total_amount
        self.ratingsAvg = ratingsAvg
        self.totalReceivedRides = totalReceivedRides
        self.totalCompletedRides = totalCompletedRides
        self.totalDriverCancelRides = totalDriverCancelRides
        self.totalPassengerCancelRides = totalPassengerCancelRides
        self.previous_total_amount = previous_total_amount
        self.passengerPaidExtraAmount = passengerPaidExtraAmount
        self.totalCashCollectedByDriver = totalCashCollectedByDriver
        self.newSum = newSum
        self.totalTaxAmount = totalTaxAmount
        self.remainings = remainings
        
        self.totalDriverCreditAmount = totalDriverCreditAmount
        self.amountReceivedFromDriver = amountReceivedFromDriver
        self.totalPassengerCancelPenalty = totalPassengerCancelPenalty
        self.totalDriverCashEarnings = totalDriverCashEarnings
        self.totalRideActualAmount = totalRideActualAmount
        self.completeRidesPercent = completeRidesPercent
        self.totalDriverWalletAmount = totalDriverWalletAmount
        self.totalPassengerPaidExtraAmount = totalPassengerPaidExtraAmount
        self.amountPaidToDriver = amountPaidToDriver
        self.totalDriverCancelPenalty = totalDriverCancelPenalty
        
        
        
    }
    
    
    init(dict:[String:Any]) {
       
        self.acceptRidesPercent = dict["acceptRidesPercent"] as? Double ?? 0
        self.totalRejectRides = dict["totalRejectRides"] as? Double ?? 0
        self.driverTotalBonus = dict["driverTotalBonus"] as? Double ?? 0
        self.totalIgnoreRides = dict["totalIgnoreRides"] as? Double ?? 0
        self.totalAcceptRides = dict["totalAcceptRides"] as? Double ?? 0
        self.final_total_amount = dict["final_total_amount"] as? Double ?? 0
        self.ratingsAvg = dict["ratingsAvg"] as? Double ?? 0
        self.totalReceivedRides = dict["totalReceivedRides"] as? Double ?? 0
        self.totalCompletedRides = dict["totalCompletedRides"] as? Double ?? 0
        self.totalDriverCancelRides = dict["totalDriverCancelRides"]  as? Double ?? 0
        self.totalPassengerCancelRides = dict["totalPassengerCancelRides"] as? Double ?? 0
        self.previous_total_amount = dict["previous_total_amount"] as? Double ?? 0
        self.passengerPaidExtraAmount = dict["passengerPaidExtraAmount"] as? Double ?? 0.0
        self.totalCashCollectedByDriver = dict["totalCashCollectedByDriver"] as? Double ?? 0.0
        self.newSum = dict["newSum"] as? Double ?? 0.0
        self.totalTaxAmount = dict["totalTaxAmount"] as? Double ?? 0.0
        self.remainings = dict["remainings"] as? Double ?? 0.0
        
        self.totalDriverCreditAmount =  dict["totalDriverCreditAmount"] as? Double ?? 0.0
        self.amountReceivedFromDriver =  dict["amountReceivedFromDriver"] as? Double ?? 0.0
        self.totalPassengerCancelPenalty =  dict["totalPassengerCancelPenalty"] as? Double ?? 0.0
        self.totalDriverCashEarnings =  dict["totalDriverCashEarnings"] as? Double ?? 0.0
        self.totalRideActualAmount =  dict["totalRideActualAmount"] as? Double ?? 0.0
        self.completeRidesPercent =  dict["completeRidesPercent"] as? Double ?? 0.0
        self.totalDriverWalletAmount =  dict["totalDriverWalletAmount"] as? Double ?? 0.0
        self.totalPassengerPaidExtraAmount =  dict["totalPassengerPaidExtraAmount"] as? Double ?? 0.0
        self.amountPaidToDriver =  dict["amountPaidToDriver"] as? Double ?? 0.0
        self.totalDriverCancelPenalty =  dict["totalDriverCancelPenalty"] as? Double ?? 0.0
        
    }
    
    
}




