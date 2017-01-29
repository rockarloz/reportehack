//
//  FeedBackViewController.swift
//  Hack
//
//  Created by Carlos Castellanos on 29/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {
    let panel = UIImageView ()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        
        let lblFeed = UILabel ()
        lblFeed.frame = CGRect(x: 20, y: 30  , width: self.view.frame.size.width - 40, height: 100)
        lblFeed.text = "Gracias"
        lblFeed.font = lblFeed.font.withSize(18)
        lblFeed.textColor = .white
        lblFeed.sizeToFit()
        lblFeed.center.x = self.view.center.x
        lblFeed.backgroundColor = UIColor.clear
        self.view.addSubview(lblFeed)
        
        let lblFeed2 = UILabel ()
        lblFeed2.frame = CGRect(x: 30, y: lblFeed.frame.size.height + lblFeed.frame.origin.y + 50  , width: self.view.frame.size.width - 60, height: 60)
        lblFeed2.text = "Hemos terminado de registrar toda la información"
        lblFeed2.numberOfLines = 2
        lblFeed2.textAlignment = .center
        lblFeed2.font = lblFeed.font.withSize(22)
        lblFeed2.textColor = UIColor(red: 12.0/255.0, green: 215.0/255.0, blue: 216.0/255.0, alpha: 1.0)

        //lblFeed2.sizeToFit()
        lblFeed2.center.x = self.view.center.x
        lblFeed2.backgroundColor = UIColor.clear
        self.view.addSubview(lblFeed2)

        panel.frame = CGRect( x: 0, y: lblFeed2.frame.size.height + lblFeed2.frame.origin.y + 100, width: self.view.frame.size.width * 0.5  , height: self.view.frame.size.width * 0.5)
        panel.image = UIImage(named: "bigIconLike.png")
        panel.center.x = self.view.center.x
        self.view.addSubview(panel)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0,y: self.view.frame.size.height * 0.9, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.1)
        btn.setImage(UIImage(named: "end.png"), for: UIControlState())
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.addTarget(self, action: #selector(FeedBackViewController.close), for: .touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(){
        self.dismiss(animated: false, completion: {       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closePeople"), object: nil)})

        //self.present(evaluation, animated: false, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
