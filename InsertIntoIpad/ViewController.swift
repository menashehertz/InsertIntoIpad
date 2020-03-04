//
//  ViewController.swift
//  InsertIntoIpad
//
//  Created by Steven Hertz on 3/3/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    // MARK: - properties of the ViewController
    var dbs : CKDatabase {
        return CKContainer(identifier: "iCloud.com.dia.cloudKitExample.open").publicCloudDatabase
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
         addRecord()
        // upDateRecord2()
        //useModifyOperation()
    }
    
       fileprivate func addRecord() {
           // Do any additional setup after loading the view.
           
           // make a ckrecord
           let record = CKRecord(recordType: "iPad")
           record["currentUser"] = NSString("Mevy")
           record["identifier"] =  NSString("qqqq")
           record["userLevel"] =   NSString("qqqq")
           
           dbs.save(record) { (record, error) in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               print("added succesfully")
               print(record as Any)
           }
       }
    
    fileprivate func upDateRecord()  {
        let recordID = CKRecord.ID(recordName: "01d9c633046fbfba766df508eccb6ed0e6dad548")

        dbs.fetch(withRecordID: recordID) { record, error in

            if let record = record, error == nil {
                
                print(record["name"] as Any)
                dump(record)
                record["currentUser"] = NSString("zzzz")
                record["identifier"] =  NSString("oooooo")
                record["userLevel"] =   NSString("l01")

                self.dbs.save(record) { (savedRecord, error) in
                    if let _ = savedRecord, error == nil{
                        print("Record Saved")
                    } else {
                        print("received error")
                    }
                }

                //update your record here

            }
        }
    }

    fileprivate func upDateRecord2()  {
        print("start")
        let recordID = CKRecord.ID(recordName: "01d9c633046fbfba766df508eccb6ed0e6dad548")
        
        let record = CKRecord(recordType: "iPad", recordID: recordID)
        record["currentUser"] = NSString("aaaaa")
        record["identifier"] =  NSString("bbbbb")
        record["userLevel"] =   NSString("ccccc")
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.modifyRecordsCompletionBlock = { (records, recordsID, error) in
           if error != nil {
              print("Error uploading records")
            print(error?.localizedDescription as Any)
           } else {
              print("success records")
           }
        }
        self.dbs.add(operation)
        
//        dbs.save(record) { (record, error) in
//            if let record = record, error == nil {
//                print("Record Saved")
//            } else {
//                print("received error")
//            }
//        }
    }
    
    
    fileprivate func useModifyOperation() {
        let recid = CKRecord.ID(recordName: "01d9c633046fbfba766df508eccb6ed0e6dad548" )
        let record1 = CKRecord(recordType: "ipPad", recordID: recid)
        record1["currentUser"] = NSString("aaaaa")
        record1["identifier"] =  NSString("bbbbb")
        record1["userLevel"] =   NSString("ccccc")
        
        let record2 = CKRecord(recordType: "iPad")
        record2["currentUser"] = NSString("dddd")
        record2["identifier"] =  NSString("eeee")
        record2["userLevel"] =   NSString("ffff")
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record1, record2], recordIDsToDelete: nil)
        operation.modifyRecordsCompletionBlock = { (records, recordsID, error) in
           if error != nil {
              print("Error uploading records")
            print(error?.localizedDescription as Any)
           } else {
              print("success records")
           }
        }
        self.dbs.add(operation)
        


        
    }
}


