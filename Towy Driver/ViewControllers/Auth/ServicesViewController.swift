//
//  ServicesViewController.swift
//  Towy Driver
//
//  Created by Macbook Pro on 03/11/2022.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var btnContinue:UIButton!
    @IBOutlet weak var btnCancelH:NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle:UILabel!
    
    var isEdit = false
    
    
    var datasource :[Service] = []
    
    
    var serviceIds : [Int] = []{
        didSet{
            if serviceIds.count > 0{
                btnContinue.isUserInteractionEnabled = true
                btnContinue.backgroundColor = .black
            }else{
                btnContinue.isUserInteractionEnabled = false
                btnContinue.backgroundColor = .lightGray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if isEdit{
            btnContinue.setTitle("Add", for: .normal)
            lblTitle.text = "Which services you want to add?"
        }else{
            btnCancelH.constant = 0
        }
        
        tblView.estimatedRowHeight = 600
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib.init(nibName: "TruckTypeTableViewCell", bundle: .main), forCellReuseIdentifier: "TruckTypeTableViewCell")
        getServicesTypes()
    }
    
    @IBAction func nextTapped(_ sender:UIButton){
        setServices()
    }

    @IBAction func backTapped(_ sender:UIButton){
        UtilityManager.manager.moveBack(self)
    }

    func getServicesTypes(){
        SHOW_CUSTOM_LOADER()
        ServiceManager.manager.getServicesTypes(completionHandler: { result, message in
            HIDE_CUSTOM_LOADER()
            if message == nil{
                if result?.count ?? 0 > 0{
                    
                    self.datasource = result!
                    self.tblView.reloadData()
                }
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "Error Getting Trucks Type Form Server.", title: Constants.APP_NAME)
            }
        })
        
    }
    
    
}

extension ServicesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckTypeTableViewCell", for: indexPath) as! TruckTypeTableViewCell
        let ds = datasource[indexPath.row]
        cell.lblName.text = ds.name
        cell.lblDescription.text = ds.description
        if serviceIds.contains(datasource[indexPath.row].id!){
            cell.backView.backgroundColor = .black
            cell.lblName.textColor = .white
            cell.lblDescription.textColor = .white
        }else{
            cell.backView.backgroundColor = .white
            cell.lblName.textColor = .black
            cell.lblDescription.textColor = .darkGray
        }
        cell.imgaeIcon.kf.setImage(with: URL.init(string: Constants.HTTP_CONNECTION_ROOT_ASSETS+ds.image!), placeholder: nil, options: nil, progressBlock: nil) { image, error, cacheType, imageURL in
            if image != nil{
                cell.imgaeIcon.image = image!
            }else{
                cell.imgaeIcon.image = UIImage.init(named: "Mask Group 110")
                
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cel = cell as! TruckTypeTableViewCell
        if serviceIds.contains(datasource[indexPath.row].id!){
            cel.backView.backgroundColor = .black
            cel.lblName.textColor = .white
            cel.lblDescription.textColor = .white
        }else{
            cel.backView.backgroundColor = .white
            cel.lblName.textColor = .black
            cel.lblDescription.textColor = .darkGray
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if serviceIds.contains(datasource[indexPath.row].id!){
            if let itemToRemoveIndex = serviceIds.firstIndex(of: datasource[indexPath.row].id!) {
                   serviceIds.remove(at: itemToRemoveIndex)
               }
        }else{
            self.serviceIds.append(datasource[indexPath.row].id ?? 0)
        }
        
        
        
        tblView.reloadData()
        
    }
   
    
    
    
    func setServices(){
        ServiceManager.manager.saveServices(serviceIds: self.serviceIds) { result, message in
            if result ?? false{
                if self.isEdit{
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationObservers.NEW_SERVICE_ADDED.rawValue), object: nil, userInfo: nil)
                    self.dismiss(animated: true)
                }else{
                    UtilityManager.manager.gotoVC(from: self, identifier: "SSNViewController", storyBoard: UtilityManager.manager.getAuthStoryboard())
                }
            }else{
                UtilityManager.manager.showAlert(self, message: message ?? "error saving Services.", title: "Oops")
            }
        }
    }
    
}
