//
//  dbManager.swift
//  sqliteTestApp
//
//  Created by Mac on 17/12/18.
//  Copyright © 2018 tops. All rights reserved.
//

import UIKit

class dbManager{

    private var databasePath = "" //appdelegate
    private var dbPointer:OpaquePointer?
    
    static var shared:dbManager = dbManager()
    
    init() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        self.databasePath = appDel.dbPath
    }
    
    //open data
    private func dbOpen() -> Bool {
        
        if sqlite3_open(self.databasePath, &dbPointer) == SQLITE_OK{
            return true
        }
        else{
            return false
        }
        
    }
    
    
    //insert, update and delete command
    public func runCommand(_ cmd:String) -> Bool{
        
        print(cmd)
        
        if self.dbOpen(){
            
            //stmt
            var stmt:OpaquePointer?
            
            if sqlite3_prepare_v2(self.dbPointer, cmd, -1, &stmt, nil) == SQLITE_OK{
                
                //perform or fire
                sqlite3_step(stmt)
                
                sqlite3_finalize(stmt)
                
                sqlite3_close(dbPointer)
                
            }
            else{
                print("Error in prepare stmt!")
                return false
            }
            
            
        }
        else{
            print("Error not able to open database")
            return false
        }
        
        
        return true
        
    }
    
    
    public func runQuery(_ query:String) -> [[String:Any]]{
        
        var list = [[String:Any]]()
        
        print(query)
        
        if self.dbOpen(){
            
            //stmt
            var stmt:OpaquePointer?
            
            if sqlite3_prepare_v2(self.dbPointer, query, -1, &stmt, nil) == SQLITE_OK{
                
                //perform or fire
                while sqlite3_step(stmt) == SQLITE_ROW{
                    //let id = sqlite3_column_int(stmt, 0) // that is column id from table
                    var row = [String:Any]()
                    for colNo in 0..<sqlite3_column_count(stmt)
                    {
                        let colName = String.init(cString:sqlite3_column_name(stmt, colNo))
                        let colText = String.init(cString: sqlite3_column_text(stmt, colNo))
                        
                        row[colName] = colText
                        
                    }
                    
                    list.append(row)
                    
                }
                
                sqlite3_finalize(stmt)
                
                sqlite3_close(dbPointer)
                
            }
            else{
                print("Error in prepare stmt!")

            }
            
            
        }
        else{
            print("Error not able to open database")

        }
        
        
        return list
        
    }
    
    
}
