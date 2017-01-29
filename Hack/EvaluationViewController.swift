//
//  EvaluationViewController.swift
//  Hack
//
//  Created by Carlos Castellanos on 28/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

class EvaluationViewController: UIViewController {
    var index = Int()
    var type = Int()

    override func viewDidLoad() {
        print(index)
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(close(_:)),
            name: NSNotification.Name(rawValue: "finishedEvaluation"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentFeedBask(_:)),
            name: NSNotification.Name(rawValue: "finishedEvaluationAgency"),
            object: nil)
        let btnclose = UIButton(type: .custom)
        btnclose.frame = CGRect(x: 0,y: 10, width: 64, height: 64)
        btnclose.setImage(UIImage(named: "icClear.png"), for: UIControlState())
        btnclose.backgroundColor = UIColor.clear
        btnclose.setTitleColor(UIColor.white, for: UIControlState())
        
        btnclose.clipsToBounds = true
        btnclose.addTarget(self, action: #selector(DraggableViewBackground.close(_:)), for: .touchUpInside)
        self.view.addSubview(btnclose)
        
        if (type == 0 ){
        let lblFeed = UILabel ()
        lblFeed.frame = CGRect(x: 20, y: 30  , width: self.view.frame.size.width - 40, height: 100)
        lblFeed.text = "Denuncia de Agente"
        lblFeed.font = lblFeed.font.withSize(18)
        lblFeed.textColor = .white
        lblFeed.sizeToFit()
        lblFeed.center.x = self.view.center.x
        lblFeed.backgroundColor = UIColor.clear
        self.view.addSubview(lblFeed)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let draggableBackground: AgentView = AgentView(frame:CGRect(x: 0,y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60))
        self.view.addSubview(draggableBackground)
            draggableBackground.index = index
            self.view.backgroundColor =  UIColor(red: 233.0/255.0, green: 35.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        }
        else if (type == 1){
            let lblFeed = UILabel ()
            lblFeed.frame = CGRect(x: 20, y: 30  , width: self.view.frame.size.width - 40, height: 100)
            lblFeed.text = "Evaluacion de Agente"
            lblFeed.font = lblFeed.font.withSize(18)
            lblFeed.textColor = .white
            lblFeed.sizeToFit()
            lblFeed.center.x = self.view.center.x
            lblFeed.backgroundColor = UIColor.clear
            self.view.addSubview(lblFeed)
         
            
            // Do any additional setup after loading the view, typically from a nib.
            let draggableBackground: AgentView = AgentView(frame:CGRect(x: 0,y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60))
            draggableBackground.index = index
            self.view.addSubview(draggableBackground)
            self.view.backgroundColor =   UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            draggableBackground.backgroundColor =  UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        }
        else {
            
            let lblFeed = UILabel ()
            lblFeed.frame = CGRect(x: 20, y: 30  , width: self.view.frame.size.width - 40, height: 100)
            lblFeed.text = "Evaluación de Agencia"
            lblFeed.font = lblFeed.font.withSize(18)
            lblFeed.textColor = .white
            lblFeed.sizeToFit()
            lblFeed.center.x = self.view.center.x
            lblFeed.backgroundColor = UIColor.clear
            self.view.addSubview(lblFeed)
            
            
            // Do any additional setup after loading the view, typically from a nib.
            let draggableBackground: DraggableViewBackground = DraggableViewBackground(frame:CGRect(x: 0,y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60))
            self.view.addSubview(draggableBackground)
            self.view.backgroundColor =   UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            draggableBackground.backgroundColor =  UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(_ sender: UIButton!) {
        self.dismiss(animated: false, completion: nil)
    }
    func presentFeedBask(_ sender: UIButton!) {
        self.present(FeedBackViewController(), animated: false, completion: nil)
    }
    
}
