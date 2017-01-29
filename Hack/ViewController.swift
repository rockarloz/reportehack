//
//  ViewController.swift
//  Hack
//
//  Created by Carlos Castellanos on 28/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var table: UITableView  =   UITableView()
    
    let panel = UIImageView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panel.frame = CGRect( x: 0, y: 0, width: self.view.frame.size.width  , height: self.view.frame.size.width * 0.8)
        panel.image = UIImage(named: "panel.png")
        panel.backgroundColor = .clear
        
        self.view.addSubview(panel)
        table.delegate      =   self
        table.dataSource    =   self
        table.rowHeight     = 110
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor =  UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        //borrar
        table.frame         =   CGRect(x: 0, y: self.view.frame.size.width * 0.8, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.view.frame.size.width * 0.8));
        self.view.addSubview(table)
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:StoryTableViewCell?
        // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoryTableViewCell
        
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StoryTableViewCell
        cell?.useData()
        cell?.ImageA.image = UIImage(named: "venueItem" + String (indexPath.row + 1) + ".png")

        
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
               return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.present(ProfileViewController(), animated: true, completion: nil)
    }
    
              }

