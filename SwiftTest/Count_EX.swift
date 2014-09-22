//
//  Count_EX.swift
//  SwiftTest
//
//  Created by Eric McConkie on 9/21/14.
//  Copyright (c) 2014 ericmcconkie.com. All rights reserved.
//
import UIKit
import Foundation
import CoreData
extension Count{

    class func createWithCount(count:Int32,context : NSManagedObjectContext)->Count!{
        
        let ent = NSEntityDescription.entityForName("Count", inManagedObjectContext: context)
        let cnt = Count(entity: ent!, insertIntoManagedObjectContext: context)
        cnt.count = NSNumber(int: count)
        cnt.date = NSDate()
        var error: NSError? = nil
        context.save(&error)
        return cnt
    }
    
    class func fetchall()-> [AnyObject]?{
        let appd = UIApplication.sharedApplication().delegate as AppDelegate
        let ctx = appd.managedObjectContext!
        let fReq = NSFetchRequest(entityName: "Count")

        var anError: NSError?
        var result = ctx.executeFetchRequest(fReq, error: &anError)

        if let anError = anError {
            println("Unresolved error \(anError), \(anError.userInfo)")

        }
        return result 
    }
    
    class func destroy(obj:NSManagedObject){
        let appd = UIApplication.sharedApplication().delegate as AppDelegate
        let ctx = appd.managedObjectContext!
        ctx.deleteObject(obj)
    }
    
    func prettydate()->String{
        let dateformat = NSDateFormatter()
        dateformat.dateFormat = "MMM, d 'at' HH:mm"
        let datestring = dateformat.stringFromDate(date)
        return datestring
    }
}