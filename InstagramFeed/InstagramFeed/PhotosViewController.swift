//
//  PhotosViewController.swift
//  InstagramFeed
//
//  Created by Shawn Zhu on 8/26/15.
//  Copyright (c) 2015 Jasen Salcido. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var photos: NSArray?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var clientId = "05ab649339fd49618ed83857fdfeff25"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            self.photos = responseDictionary["data"] as? NSArray
            self.tableView.rowHeight = 320
            self.tableView.reloadData()
            
            println("response: \(self.photos)")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("com.lab1.PhotoPrototypeCell", forIndexPath: indexPath) as! PhotoCell
        
        let photo = photos![indexPath.row]
        
        let url = NSURL(string: (photo.valueForKeyPath("images.low_resolution.url") as! String))!
        cell.photoImageView.setWithImageUrl(url)
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
