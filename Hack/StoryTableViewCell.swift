//
//  StoryTableViewCell.swift
//  
//
//  Created by Carlos Castellanos on 08/06/16.
//
//


import UIKit
import QuartzCore
import Alamofire
class StoryTableViewCell: UITableViewCell {
    
    var mainView = UIView()
    var authorLabel = UILabel()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var profilePictureView = UIImageView()
    var videoImage = UIImageView()
    var lblType = UILabel()
    var lblSubType = UILabel()
    var lblTime = UILabel()
    var lblLikes = UILabel()
    var star = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainView)
        mainView.addSubview(profilePictureView)
        mainView.addSubview(authorLabel)
        mainView.addSubview(titleLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(videoImage)
        mainView.addSubview(lblTime)
        mainView.addSubview(lblType)
       //mainView.addSubview(lblSubType)
        mainView.addSubview(lblLikes)
        mainView.addSubview(star)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)


        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)

   
    }
    
    func useData(_ story:NSDictionary) {
        // Round those corners
        mainView.layer.cornerRadius = 5;
        mainView.layer.masksToBounds = true;
        
        mainView.frame = CGRect(x: 10, y: 5, width: self.frame.size.width - 20 , height: self.frame.size.height - 10 )
        mainView.backgroundColor = UIColor.white
      
      
        videoImage.frame  =  CGRect(x:0, y:0, width: 100 , height: 100)
        videoImage.backgroundColor = UIColor.lightGray
        let auxVideo = story.object(forKey: "recording") as! NSDictionary
        let url = URL(string: auxVideo.object(forKey: "thumb") as! String)
       
        UIElements.downloadImage(url:  url!, imageF: self.videoImage) 
          mainView.layer.insertSublayer(videoImage.layer, at: 0)
      //  videoImage.setImageWithUrl( URL(string: (story.object(forKey: "video_")?.object(forKey: "thumb") as? String)!)!, placeHolderImage: nil, width: videoImage.frame.size.width, height: videoImage.frame.size.height)
        lblType.frame = CGRect(x: videoImage.frame.size.width + 11, y: 12, width: self.frame.size.width - 136 , height: 100)
        let auxType = story.object(forKey: "type") as! NSDictionary
        lblType.text = " " + (auxType.object(forKey: "name")! as! String) + " "
        lblType.backgroundColor = Colors.green
        lblType.font = Fonts.MB12
        lblType.textColor = UIColor.white
        lblType.layer.cornerRadius = 4;
        lblType.numberOfLines = 2;
        lblType.layer.masksToBounds = true;
        lblType.sizeToFit()
    
        lblSubType.frame = CGRect(x: lblType.frame.size.width + lblType.frame.origin.x + 4, y: 12, width: 100, height: 100)
        let auxSubType = story.object(forKey: "subtype") as! NSDictionary
        lblSubType.text = "/" + ((auxSubType.object(forKey: "name"))! as! String)
        lblSubType.textColor = Colors.green
        lblSubType.font = Fonts.MR12
        lblSubType.sizeToFit()
        
        descriptionLabel.frame = CGRect(x: videoImage.frame.size.width + 11, y: lblType.frame.size.height + lblType.frame.origin.y + 10, width:  mainView.frame.size.width - videoImage.frame.size.width - 11 - 6, height: 32)
        descriptionLabel.text = story.object(forKey: "body") as? String
        descriptionLabel.textColor = Colors.gray
        descriptionLabel.font = UIFont(name: "Lora-Regular", size:12)
        descriptionLabel.numberOfLines = 2
        
        let strDate = story.object(forKey: "created_at") as? String//"2015-11-01T00:00:00Z" //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        
        
        
   
        
        lblTime.frame = CGRect(x: videoImage.frame.size.width + 11, y: descriptionLabel.frame.size.height + descriptionLabel.frame.origin.y + 13, width: 100 , height: 50)
        
        
        
        let locale = NSLocale.current
        
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
        
        if dateFormat.range(of: "a") != nil {
            print("12 hour")
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
            let generatedDate = formatter.date(from: strDate!)!
            let generatedString = formatter.string(from: generatedDate)
            print(generatedString)
            lblTime.text =  timeAgoSinceDate(generatedDate , numericDates: true)
        }
        else {
            print("24 hour")
             lblTime.text =  timeAgoSinceDate(dateFormatter.date( from: strDate! )! , numericDates: true)
        }

        
       
        lblTime.font = Fonts.MR12
        lblTime.numberOfLines = 2
        lblTime.sizeToFit()
        
        let likes =  story.object(forKey: "stars") as? NSDictionary
        lblLikes.frame = CGRect(x: mainView.frame.size.width - 23, y: descriptionLabel.frame.size.height + descriptionLabel.frame.origin.y + 14, width: 100 , height: 50)
        if (likes != nil) {
            let totalLikes = likes?.object(forKey: "total")
            lblLikes.text = String(describing: totalLikes!)
        }else{
            lblLikes.text = "0"
        }
      
        lblLikes.font = Fonts.MR12
        lblLikes.numberOfLines = 2
        lblLikes.textColor = Colors.red
        lblLikes.sizeToFit()
        
        star.frame = CGRect(x: mainView.frame.size.width - 21, y: descriptionLabel.frame.size.height + descriptionLabel.frame.origin.y + 13, width: 16 , height: 16)
        star.image = UIImage(named:"icStar.png")!
        lblLikes.frame = CGRect(x: lblLikes.frame.origin.x - lblLikes.frame.size.width, y: lblLikes.frame.origin.y, width: lblLikes.frame.size.width, height: lblLikes.frame.size.height)
    }
    
     func timeAgoSinceDate(_ date:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "Hace \(components.year!) años"
        } else if (components.year! >= 1){
            if (numericDates){
                return "Hace 1 año"
            } else {
                return "El año pasado"
            }
        } else if (components.month! >= 2) {
            return "Hace \(components.month!) meses"
        } else if (components.month! >= 1){
            if (numericDates){
                return "Hace 1 mes"
            } else {
                return "El mes pasado"
            }
        } else if (components.weekOfYear! >= 2) {
            return "Hace \(components.weekOfYear!) semanas"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "Hace 1 semana"
            } else {
                return "La semana pasada"
            }
        } else if (components.day! >= 2) {
            return "Hace \(components.day!) días"
        } else if (components.day! >= 1){
            if (numericDates){
                return "Hace 1 día"
            } else {
                return "Ayer"
            }
        } else if (components.hour! >= 2) {
            return "Hace \(components.hour!) horas"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "Hace 1 hora"
            } else {
                return "Hace 1 hora"
            }
        } else if (components.minute! >= 2) {
            return "Hace \(components.minute!) minutos"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "Hace 1 minuto"
            } else {
                return "Hace 1 minuto"
            }
        } else if (components.second! >= 3) {
            return "Hace \(components.second!) segundos"
        } else {
            return "Justo ahora"
        }
        
    }
    
        
}
