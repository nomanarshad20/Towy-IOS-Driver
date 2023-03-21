//
//  ServiceManager.swift
//  Towy Driver
//
//  Created by Macbook Pro on 03/11/2022.
//

import Foundation


import Foundation
import Alamofire
import SwiftyJSON

class ServiceManager{
    static var manager = ServiceManager()
    
    func getServicesTypes(completionHandler:@escaping (_ result : [Service]?, _ message:String?)-> Void)
    {
       
        let header = UtilityManager().getAuthHeader()
        SHOW_CUSTOM_LOADER()
        let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.GET_SERVICES_LIST
        
        
        
        webServiceManager.manager.getData(url: baseUrl, param: nil, headers: header) { (mainDict, err) in
            HIDE_CUSTOM_LOADER()
            if let data = mainDict?["data"].arrayObject
            {
                completionHandler(Service.getServiceArr(dict: data as! [[String:Any]]),nil)

            }else{
                completionHandler(nil,err)
            }
        }
    }
        func saveServices(serviceIds:[Int], completionHandler:@escaping (_ result : Bool?, _ message:String?)-> Void)
        {
           
            let header = UtilityManager().getAuthHeader()
            SHOW_CUSTOM_LOADER()
            let baseUrl = Constants.HTTP_CONNECTION_ROOT + Constants.SAVE_SERVICES_LIST
            
            
//            ["vehicle_type_id":truckId]
            webServiceManager.manager.postData(url: baseUrl, param: ["services":serviceIds], headers: header) { (mainDict, err) in
                HIDE_CUSTOM_LOADER()
                if let data = mainDict?["data"].dictionary
                {
                    var services = UserDefaults.standard.array(forKey: "services") as? [[String:Any]]
                    let newServices =  data["services"]?.arrayObject as! [[String:Any]]
                    for i in newServices{
                        services?.append(i)
                    }
                    UserDefaults.standard.set(services, forKey: "services")
                    completionHandler(true,nil)

                }else{
                    completionHandler(nil,err)
                }
            }
            
        }
        
}
