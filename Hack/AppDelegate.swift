//
//  AppDelegate.swift
//  Hack
//
//  Created by Carlos Castellanos on 28/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    /*http://localhost:3000/geocoder.json?latitude=19.4227361&longitude=-99.1383308
    func downloadDataFromServer(_ request: Int)  {
        var url = urlProduction + "/stories.json?fb_id=" + String (describing: ((defaults.object(forKey: "userData") as! NSMutableDictionary).object(forKey: "journalist_id"))!)
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        // Alamofire.request( urlProduction + "/types.json", headers: headers)
        /*RequestData from Server*/
        Alamofire.request( url, headers: headers)
            .responseJSON { response in
                print(response.request)  // origmapinal URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                switch response.result {
                case .success:
                    if let JSON = response.result.value {
                        self.indicator.stopAnimating()
                        self.indicator2.stopAnimating()
                        print("JSON: \(JSON)")
                        var stories = NSDictionary ()
                        stories = response.result.value as! NSDictionary
                        print(stories.object(forKey: "stories"))
                        let auxArray = stories.object(forKey: "stories") as! NSArray
                        self.data =  auxArray.mutableCopy() as! NSMutableArray
                        self.defaults.set(self.data, forKey: "cacheStories")
                        var page = NSDictionary()
                        page = stories.object(forKey: "pages") as! NSDictionary
                        if (request == 0 )
                        {
                            self.nextPage = page.object(forKey: "next")! as? Int
                        }else{
                            self.nextPageOrder = page.object(forKey: "next")! as? Int
                        }
                        //self.nextPage = page.objectForKey("next")! as? Int
                        self.table.reloadData()
                        
                        self.cortina.isHidden = true
                    }
                case .failure(let error):
                    print(error)
                    self.present(UIElements.sendAlert("Revisa tu conexión a internet"), animated: true, completion: nil)
                    
                    
                    self.indicator.stopAnimating()
                    self.indicator2.stopAnimating()
                    
                    if self.defaults.object(forKey: "cacheStories") is NSMutableArray {
                        
                        self.data =  self.defaults.object(forKey: "cacheStories") as! NSMutableArray
                        self.table.reloadData()
                    }
                    self.cortina.isHidden = true
                    
                    
                }
                
                
        }
    }*/


}

