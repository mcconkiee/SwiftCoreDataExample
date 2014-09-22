//
//  ViewController.swift
//  SwiftTest
//
//  Created by Eric McConkie on 9/21/14.
//  Copyright (c) 2014 ericmcconkie.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    var counter : Int32 = 0
    var tableView : UITableView?
    var data : [Count]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        println("application Docs path = \(urls)")
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerClass(NSClassFromString(UITableViewCell.description()), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
        
        let bttn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        let img = UIImage(named: "test");
        let imageview = UIImageView(image: img);
        bttn.addSubview(imageview);
        bttn.frame = CGRectMake(self.view.frame.size.width - 70, 20, 50, 50);
        bttn.clipsToBounds = true
        bttn.addTarget(self, action: "onbuttontap:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.view.addSubview(bttn);
        self.updateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(){
        let results = Count.fetchall()
        self.data = results as [Count]?
        self.tableView?.reloadData()
    }
    func onbuttontap(sender:UIButton!){
        let alert = UIAlertView(title: "tap", message: "tap ok to create a Count object", delegate: self, cancelButtonTitle: "ok")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appdelegate.managedObjectContext!
        var errror:NSError?
        counter += 1
        let ctt = Count.createWithCount(counter, context: context) as Count
        println("Created new Count object : " + ctt.description)        
        self.updateData()
        
        
    }
    
    // MARK: - tableview delegagte
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Int(self.data!.count)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let countobject = self.data![indexPath.row] as Count
        
        cell.textLabel?.text = countobject.prettydate()
        return cell
    }
    
    func  tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let countobject = self.data![indexPath.row] as Count
        Count.destroy(countobject);
        self.updateData();
    }
}

