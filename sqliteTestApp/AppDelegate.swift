//
//  AppDelegate.swift
//  sqliteTestApp
//
//  Created by Mac on 17/12/18.
//  Copyright © 2018 tops. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dbPath = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //bundle group db -> dbInfo.db copy -> installed dir (document)
        
        let arrDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        //first document dir
        
        self.dbPath = arrDir[0] + "/dbInfo.db"
        
        //need to copy at first time
        if FileManager.default.fileExists(atPath: self.dbPath) == false{
            
            //need to copy
            let fromBundle = Bundle.main.path(forResource: "dbInfo", ofType: "db")
            
            do{
                try FileManager.default.copyItem(atPath: fromBundle!, toPath: self.dbPath)
                print("File Copied!")
            }
            catch let err as NSError{
                print(err.localizedDescription)
            }
            
        }
        else
        {
            print("Allready exist")
        }
        
        
        print(self.dbPath)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

