//
//  Transaction.swift
//  TOWY Driver
//
//  Created by Macbook Pro on 29/06/2021.
//  Copyright © 2022 TOWY. All rights reserved.
//

import Foundation


class Transaction:Codable{
   

var id:Int?
var driver_type : String?
var driver_id: Int?
var franchise_id: Int?
var booking_id : Int?
var type : String?
var amount : Double?
var payment_type : String?
var wallet_pay_amount : Double?
var franchise_share_amount : Double?
var tax_amount : Double?
var total_amount : Double?
var extra_amount : Double?
var cancel_panelty_user : Double?
var is_passenger_extrapay : Int?
var description : String?
var currency : String?
var created_at : String?
var updated_at : String?


    internal init(id: Int? = nil, driver_type: String? = nil, driver_id: Int? = nil, franchise_id: Int? = nil, booking_id: Int? = nil, type: String? = nil, amount: Double? = nil, payment_type: String? = nil, wallet_pay_amount: Double? = nil, franchise_share_amount: Double? = nil, tax_amount: Double? = nil, total_amount: Double? = nil, extra_amount: Double? = nil, cancel_panelty_user: Double? = nil, is_passenger_extrapay: Int? = nil, description: String? = nil, currency: String? = nil, created_at: String? = nil, updated_at: String? = nil) {
        self.id = id
        self.driver_type = driver_type
        self.driver_id = driver_id
        self.franchise_id = franchise_id
        self.booking_id = booking_id
        self.type = type
        self.amount = amount
        self.payment_type = payment_type
        self.wallet_pay_amount = wallet_pay_amount
        self.franchise_share_amount = franchise_share_amount
        self.tax_amount = tax_amount
        self.total_amount = total_amount
        self.extra_amount = extra_amount
        self.cancel_panelty_user = cancel_panelty_user
        self.is_passenger_extrapay = is_passenger_extrapay
        self.description = description
        self.currency = currency
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    init(dict:[String:Any]) {
        self.id = dict["id"] as? Int ?? nil
        self.driver_type = dict["driver_type"] as? String ?? nil
        self.driver_id = dict["driver_id"] as? Int ?? nil
        self.franchise_id = dict["franchise_id"] as? Int ?? nil
        self.booking_id = dict["booking_id"] as? Int ?? nil
        self.type = dict["type"] as? String ?? nil
        self.amount = dict["amount"] as? Double ?? nil
        self.payment_type = dict["payment_type"] as? String ?? nil
        self.wallet_pay_amount = dict["wallet_pay_amount"] as? Double ?? nil
        self.franchise_share_amount = dict["franchise_share_amount"] as? Double ?? nil
        self.tax_amount = dict["tax_amount"] as? Double ?? nil
        self.total_amount = dict["total_amount"] as? Double ?? nil
        self.extra_amount = dict["extra_amount"] as? Double ?? nil
        self.cancel_panelty_user = dict["cancel_panelty_user"] as? Double ?? nil
        self.is_passenger_extrapay = dict["is_passenger_extrapay"] as? Int ?? nil
        self.description = dict["description"] as? String ?? nil
        self.currency = dict["currency"] as? String ?? nil
        self.created_at = dict["created_at"] as? String ?? nil
        self.updated_at = dict["updated_at"] as? String ?? nil
    }
    
    
    
    class func getTransactionFromDict(dict:[String:Any])->[String:[Transaction]]{
        
        var transaction = [String:[Transaction]]()
        
        var cash = [Transaction]()
        var wallet = [Transaction]()
        var bounce = [Transaction]()
        
        if let cT = dict["CashTransaction"] as? [[String:Any]]{
            for i in cT{
                cash.append(Transaction.init(dict: i))
            }
            cash.reverse()
            transaction.updateValue(cash, forKey: "CashTransaction")
        }
        
        if let cT = dict["WalletTransaction"] as? [[String:Any]]{
            for i in cT{
                wallet.append(Transaction.init(dict: i))
            }
            wallet.reverse()
            transaction.updateValue(wallet, forKey: "WalletTransaction")
        }
        if let cT = dict["BonusTransaction"] as? [[String:Any]]{
            for i in cT{
                bounce.append(Transaction.init(dict: i))
            }
            bounce.reverse()
            transaction.updateValue(bounce, forKey: "BonusTransaction")
        }
        
        return transaction
    }
    
    
}
