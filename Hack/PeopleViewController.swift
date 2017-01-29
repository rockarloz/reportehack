//
//  PeopleViewController.swift
//  Hack
//
//  Created by Carlos Castellanos on 29/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController ,UIScrollViewDelegate,ZCarouselDelegate {
        var images: ZCarousel!
        let scrollView = UIScrollView()
        let v1 = UIView()
        let v2 = UIView()
        var currenIndex :Int = 2
        var type :Int = 0
        
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        var pageControl : UIPageControl = UIPageControl(frame: CGRect(x: 50, y: 300, width: 200, height: 50))
        
        let defaults = UserDefaults.standard
        let credential = UIView ()
        let lblCredential = UILabel ()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(close(_:)),
                name: NSNotification.Name(rawValue: "closePeople"),
                object: nil)
            
            let btnclose = UIButton(type: .custom)
            btnclose.frame = CGRect(x: 0,y: 10, width: 64, height: 64)
            btnclose.setImage(UIImage(named: "icClear.png"), for: UIControlState())
            btnclose.backgroundColor = UIColor.clear
            btnclose.setTitleColor(UIColor.white, for: UIControlState())
            
            btnclose.clipsToBounds = true
            btnclose.addTarget(self, action: #selector(PeopleViewController.close(_:)), for: .touchUpInside)
            self.view.addSubview(btnclose)
            
            self.view.backgroundColor = UIColor(red: 93.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            
            let lblFeed = UILabel ()
            lblFeed.frame = CGRect(x: 20, y: 30  , width: self.view.frame.size.width - 40, height: 100)
            lblFeed.text = "Valoración de servicio"
            lblFeed.font = lblFeed.font.withSize(18)
            lblFeed.textColor = .white
            lblFeed.sizeToFit()
            lblFeed.center.x = self.view.center.x
            lblFeed.backgroundColor = UIColor.clear
            self.view.addSubview(lblFeed)
            
            let lblTime = UILabel ()
            lblTime.frame = CGRect(x: 20, y: lblFeed.frame.size.height + lblFeed.frame.origin.y + 20  , width: self.view.frame.size.width - 40, height: 100)
            lblTime.text = "00:00:59"
            lblTime.textColor = .white
            lblTime.sizeToFit()
            lblTime.center.x = self.view.center.x
            lblTime.backgroundColor = UIColor.purple
            
            //self.view.addSubview(lblTime)
            
            
            let lblDesc = UILabel ()
            lblDesc.frame = CGRect(x: 60, y: lblFeed.frame.size.height + lblFeed.frame.origin.y + 0  , width: self.view.frame.size.width - 120, height: 100)
            lblDesc.text = "Evalúa a los agentes que te han atendido"
            lblDesc.font = lblDesc.font.withSize(22)
            lblDesc.textColor =  UIColor(red: 12.0/255.0, green: 215.0/255.0, blue: 126.0/255.0, alpha: 1.0)
            lblDesc.numberOfLines = 2
            lblDesc.textAlignment = .center
            //lblDesc.sizeToFit()
            lblDesc.center.x = self.view.center.x
            lblDesc.backgroundColor = UIColor.clear
            
            self.view.addSubview(lblDesc)
            
            
            scrollView.frame = CGRect(x: 0, y:  self.view.frame.size.height * 0.2 , width: self.view.frame.size.width,  height:  self.view.frame.size.height * 0.7)
            
            scrollView.backgroundColor = UIColor.blue
            scrollView.delegate = self
            
            
            images = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
                                              y: self.view.frame.size.height * 0.28,
                                              width: self.view.frame.size.width * 0.65,
                                              height: self.view.frame.size.width * 0.75))
            v1.frame = CGRect( x: 0,
                               y: self.view.frame.size.height * 0.28,
                               width: self.view.frame.size.width * 0.10,
                               height: self.view.frame.size.width * 0.75)
            v1.backgroundColor = .white
            v1.alpha = 0.5
            
            v2.frame = CGRect( x: self.view.frame.size.width - 10,
                               y: self.view.frame.size.height * 0.28,
                               width: self.view.frame.size.width * 0.10,
                               height: self.view.frame.size.width * 0.75)
            v2.backgroundColor = .white
            v2.alpha = 0.5
            
            
            
            images.ZCdelegate = self
            images.addImages(["card_1", "card_2", "card_3", "card_4","card_5"])
            self.view.addSubview(images)
            //self.view.addSubview(v1)
            //self.view.addSubview(v2)
            
            let btn1 = UIButton(type: .custom)
            btn1.frame = CGRect(x: self.view.frame.size.width/2 - ( self.view.frame.size.width * 0.15) - 10 ,y:scrollView.frame.size.height + ( self.view.frame.size.width * 0.10), width:  self.view.frame.size.height * 0.20, height:  self.view.frame.size.height * 0.10)
            btn1.center.x =  self.view.frame.size.width/2 - (self.view.frame.size.height * 0.10) - 10
            btn1.setImage(UIImage(named: "btReport.png"), for: UIControlState())
            btn1.setTitleColor(UIColor.white, for: UIControlState())
            btn1.addTarget(self, action: #selector(PeopleViewController.openEvaluation), for: .touchUpInside)
            
            self.view.addSubview(btn1)
            
            let btn2 = UIButton(type: .custom)
            btn2.frame = CGRect(x:  self.view.frame.size.width/2 + ( self.view.frame.size.width * 0.15) + 10 ,y: scrollView.frame.size.height + ( self.view.frame.size.width * 0.10), width:  self.view.frame.size.height * 0.20, height:  self.view.frame.size.height * 0.10)
            btn2.center.x =  self.view.frame.size.width/2 + (self.view.frame.size.height * 0.10) + 10
            btn2.setImage(UIImage(named: "btReportCopy.png"), for: UIControlState())
            btn2.setTitleColor(UIColor.white, for: UIControlState())
            btn2.addTarget(self, action: #selector(PeopleViewController.openEvaluation2), for: .touchUpInside)
            
            self.view.addSubview(btn2)
            
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0,y: self.view.frame.size.height * 0.9, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.1)
            btn.setImage(UIImage(named: "buttonFluor.png"), for: UIControlState())
            btn.setTitleColor(UIColor.white, for: UIControlState())
            btn.addTarget(self, action: #selector(PeopleViewController.openEvaluation3), for: .touchUpInside)
            self.view.addSubview(btn)
            
            
            for index in 0..<4 {
                
                let animation = UIImageView ()
                animation.frame = CGRect( x: self.view.frame.size.width * CGFloat(index) + 45, y: 0, width: self.view.frame.size.width - 90 , height: scrollView.frame.size.height * 0.8 )
                animation.image = UIImage(named: "buttonFluor.png")
                animation.layer.cornerRadius = 40
                self.scrollView.isPagingEnabled = true
                self.scrollView.contentInset = .zero
                self.scrollView.alwaysBounceHorizontal = false
                self.scrollView.addSubview(animation)
                
                
            }
            
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 4, height: self.scrollView.frame.size.height)
            
            // pageControl.addTarget(self, action: #selector(LoginViewController.changePage(_:)), for: UIControlEvents.valueChanged)
            
            pageControl.frame = CGRect(x: self.view.center.x, y: self.view.frame.size.height/3 * 2 + 5, width: 100, height: 40)
            pageControl.center.x = self.view.center.x
            configurePageControl()
            
            
            
        }
        
        func configurePageControl() {
            // The total number of pages that are available is based on how many available colors we have.
            self.pageControl.numberOfPages = 4
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.red
            //self.pageControl.pageIndicatorTintColor = Colors.light_grey
            //self.pageControl.currentPageIndicatorTintColor = Colors.green
            //self.view.addSubview(pageControl)
            
        }
        
        // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
        func changePage(_ sender: AnyObject) -> () {
            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
            
        }
        
        func close(_ sender: UIButton!) {
            
            
            self.dismiss(animated: false, completion: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        func ZCarouselShowingIndex(_ scrollview: ZCarousel, index: Int) {
            
            print("Showing Image at index \(index)")
            //images.subviews
            for subview: AnyObject in images.subviews {
                if subview is UIView {
                    
                    //print(subview)
                }
            }
            currenIndex = index
            defaults.set(index, forKey: "index")
        }
        func openEvaluation(){
            defaults.set(0, forKey: "type")
            let evaluation = EvaluationViewController()
            evaluation.index = currenIndex
            evaluation.type =  0
            self.present(evaluation, animated: false, completion: nil)
            
        }
        
        func openEvaluation2(){
            defaults.set(1, forKey: "type")
            let evaluation = EvaluationViewController()
            evaluation.index = currenIndex
            evaluation.type =  1
            self.present(evaluation, animated: false, completion: nil)
            
        }
        
        func openEvaluation3(){
            defaults.set(2, forKey: "type")
            let evaluation = EvaluationViewController()
            evaluation.index = currenIndex
            evaluation.type =  2
            self.present(evaluation, animated: false, completion: nil)
           
        }
}

