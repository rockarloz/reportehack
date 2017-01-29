//
//  StoryTableViewCell.swift
//  
//
//  Created by Carlos Castellanos on 08/06/16.
//
//


import UIKit
import QuartzCore

class StoryTableViewCell: UITableViewCell {
    
    var mainView = UIView()

    var ImageA = UIImageView()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainView)
        mainView.addSubview(ImageA)
    

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)


        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)

   
    }
    
    func useData() {
        // Round those corners
        mainView.layer.cornerRadius = 5;
        mainView.layer.masksToBounds = true;
        
        mainView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width - 0 , height: self.frame.size.height - 0 )
        mainView.backgroundColor = UIColor.white
      
      
        ImageA.frame  =  CGRect(x:0, y:0, width: mainView.frame.size.width , height: mainView.frame.size.height)
        ImageA.backgroundColor = UIColor.white
        
    
    }
    
        
}
