//
//  ViewController.swift
//  sqliteTestApp
//
//  Created by Mac on 17/12/18.
//  Copyright © 2018 tops. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//name,id,emailid,mobile
    
    var editRecord = [String:Any]()
    
    @IBOutlet weak var txtId: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtEmailId: UITextField!
    
    
    @IBOutlet weak var txtMobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editRecord["id"] != nil{
            txtId.text = "\(editRecord["id"]!)"
            txtName.text = "\(editRecord["name"]!)"
            txtEmailId.text = "\(editRecord["emailid"]!)"
            txtMobile.text = "\(editRecord["mobile"]!)"
            txtId.isEnabled = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnSaveAction(_ sender: UIBarButtonItem) {
   
        if editRecord["id"] == nil{
            let res = dbManager.shared.runCommand("insert into infoMaster(id,name,emailid,mobile) values(\(txtId.text!),'\(txtName.text!)','\(txtEmailId.text!)','\(txtMobile.text!)')")
        
            if res{
                print("Data Saved!")
            }
            else
            {
                print("Not able to Save!")
            }
        }
        else
        {
            let res = dbManager.shared.runCommand("update infoMaster set name = '\(txtName.text!)', emailid = '\(txtEmailId.text!)',mobile='\(txtMobile.text!)' where id = \(txtId.text!)")
        
            if res{
                print("Data updated!")
            }
            else
            {
                print("Not able to update!")
            }
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

