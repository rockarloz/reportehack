//
//  ProfileViewController.swift
//  Hack
//
//  Created by Carlos Castellanos on 29/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    let top = UIImageView ()
     let panel = UIImageView ()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        let btnclose = UIButton(type: .custom)
        btnclose.frame = CGRect(x: 0,y: 10, width: 64, height: 64)
        btnclose.setImage(UIImage(named: "iconLeft.png"), for: UIControlState())
        btnclose.backgroundColor = UIColor.clear
        btnclose.setTitleColor(UIColor.white, for: UIControlState())
        
        btnclose.clipsToBounds = true
        btnclose.addTarget(self, action: #selector(ProfileViewController.close(_:)), for: .touchUpInside)
  
        
        top.frame = CGRect( x: 0, y: 0, width: self.view.frame.size.width  , height: self.view.frame.size.width * 0.6)
        top.image = UIImage(named: "topBlock.png")

        panel.frame = CGRect( x: 0, y: self.view.frame.size.width * 0.6, width: self.view.frame.size.width  , height: self.view.frame.size.width * 0.8)
        panel.image = UIImage(named: "data.png")
        self.view.addSubview(top)
        self.view.addSubview(panel)
        self.view.addSubview(btnclose)

        
        let btnMap = UIButton(type: .custom)
        btnMap.frame = CGRect(x: 0,y: 300, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.15)
        btnMap.backgroundColor = .clear
        //btnMap.setImage(UIImage(named: "btEvaluarActivo.png"), for: UIControlState())
        btnMap.setTitleColor(UIColor.white, for: UIControlState())
        btnMap.addTarget(self, action: #selector(ProfileViewController.openMap), for: .touchUpInside)
        btnMap.center.x = self.view.center.x
        self.view.addSubview(btnMap)
        

        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0,y: self.view.frame.size.width * 1.40, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.25)
        btn.setImage(UIImage(named: "btEvaluarActivo.png"), for: UIControlState())
        btn.setTitleColor(UIColor.white, for: UIControlState())
        btn.addTarget(self, action: #selector(ProfileViewController.goToPeople), for: .touchUpInside)
        btn.center.x = self.view.center.x
        self.view.addSubview(btn)

        // Do any additional setup after loading the view.
    }

    
    func openMap(){
              self.present(MapViewController(), animated: false, completion: nil)

    }
    func goToPeople(){
        self.present(PeopleViewController(), animated: false, completion: nil)
        
    }
    
    
    
    
    func close(_ sender: UIButton!) {
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
