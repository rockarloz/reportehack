//
//  AgentView.swift
//  Hack
//
//  Created by Carlos Castellanos on 28/01/17.
//  Copyright © 2017 Carlos Castellanos. All rights reserved.
//

import Foundation
import UIKit
class AgentView: UIView, DraggableViewDelegate {
        var exampleCardLabels: [String]!
        var allCards: [DraggableView]!
         var index = Int()
        let MAX_BUFFER_SIZE = 2
        let CARD_HEIGHT: CGFloat = 386
        let CARD_WIDTH: CGFloat = 290
        
        var cardsLoadedIndex: Int!
        var loadedCards: [DraggableView]!
        var menuButton: UIButton!
        var messageButton: UIButton!
        var checkButton: UIButton!
        var xButton: UIButton!
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            super.layoutSubviews()
            self.setupView()
            let defaults = UserDefaults.standard

            exampleCardLabels = ["first", "second", "third", "fourth", "last"]
            allCards = []
            loadedCards = []
            let question = ["question01.png","question02.png","question03.png","question04.png","question04.png"]
            let report = ["report01.png","report02.png","report03.png","report04.png","report04.png"]
            if ( defaults.object(forKey:"type") as! Int == 0 ){
                exampleCardLabels = report
            }
            else if ( defaults.object(forKey:"type") as! Int == 1 ){
                exampleCardLabels = question
            }
           
            cardsLoadedIndex = 0
            self.loadCards()
        }
        
        func setupView() -> Void {
            //self.backgroundColor =  UIColor(red: 20.0/255.0, green: 200.0/255.0, blue: 228.0/255.0, alpha: 1.0)
            xButton = UIButton(frame: CGRect(x:(self.frame.size.width/2) - (self.frame.size.width * 0.10) - 35, y:self.frame.size.height/2 + CARD_HEIGHT/2 + 0, width:self.frame.size.width * 0.15, height:self.frame.size.width * 0.15))
            xButton.setImage(UIImage(named: "nope.png"), for: UIControlState.normal)
            xButton.addTarget(self, action: #selector(AgentView.swipeLeft), for: UIControlEvents.touchUpInside)
            
            checkButton = UIButton(frame: CGRect(x:self.frame.size.width/2 + (self.frame.size.width * 0.10), y:self.frame.size.height/2 + CARD_HEIGHT/2 + 0, width: self.frame.size.width * 0.15 ,height: self.frame.size.width * 0.15))
            checkButton.setImage(UIImage(named: "oval.png"), for: UIControlState.normal)
            checkButton.addTarget(self, action: #selector(AgentView.swipeRight), for: UIControlEvents.touchUpInside)
            
            self.addSubview(xButton)
            self.addSubview(checkButton)
        }
        
        func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
            let draggableView = DraggableView(frame:  CGRect( x: 20, y: (self.frame.size.height * 0.25) + self.frame.size.width * 0.10 , width:self.frame.size.width - 40, height: self.frame.size.width - 40))
            draggableView.information.text = ""
            draggableView.imageView.image =  UIImage(named: exampleCardLabels[index])
            //set image
            
            
            draggableView.delegate = self
            return draggableView
            
        }
        func close(_ sender: UIButton!) {
            
            
            //self.dismiss(animated: false, completion: nil)
            self.removeFromSuperview()
            
        }
        
        
        func loadCards() -> Void {
            
            
            let avatar = UIImageView ()
            avatar.frame = CGRect(x: 20, y:20  , width: self.frame.size.width * 0.7, height: self.frame.size.width * 0.40)
                       avatar.center.x = self.center.x
            avatar.backgroundColor = .clear
            let defaults = UserDefaults.standard
          print( defaults.object(forKey:"index") as! Int + 1)
            avatar.image = UIImage(named: "avatarPerson" + String((defaults.object(forKey: "index") as! Int) + 1) + ".png")
            
            
            self.addSubview(avatar)
            
            if exampleCardLabels.count > 0 {
                let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
                for i in 0 ..< exampleCardLabels.count {
                    var newCard: DraggableView = self.createDraggableViewWithDataAtIndex(index: i)
                    allCards.append(newCard)
                    if i < numLoadedCardsCap {
                        loadedCards.append(newCard)
                    }
                }
                
                for i in 0 ..< loadedCards.count {
                    if i > 0 {
                        self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                    } else {
                        self.addSubview(loadedCards[i])
                    }
                    cardsLoadedIndex = cardsLoadedIndex + 1
                }
            }
        }
        
        func cardSwipedLeft(card: UIView) -> Void {
            loadedCards.remove(at: 0)
            
            if cardsLoadedIndex < allCards.count {
                loadedCards.append(allCards[cardsLoadedIndex])
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            }
            else{
                backEvaluation()
            }
        }
        
        func cardSwipedRight(card: UIView) -> Void {
            loadedCards.remove(at: 0)
            
            if cardsLoadedIndex < allCards.count {
                loadedCards.append(allCards[cardsLoadedIndex])
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            }
            else
            {
                backEvaluation()
            }
        }
    
        func backEvaluation()
        {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "finishedEvaluation"), object: nil)
        }
        func swipeRight() -> Void {
            if loadedCards.count <= 0 {
                 backEvaluation()
                return
                // se acabaron las cards
               
            }
            if (allCards[3] == loadedCards[0])
            {
                backEvaluation()
            }
            var dragView: DraggableView = loadedCards[0]
            dragView.overlayView.setMode(mode: GGOverlayViewMode.GGOverlayViewModeRight)
            UIView.animate(withDuration: 0.2, animations: {
                () -> Void in
                dragView.overlayView.alpha = 1
            })
            dragView.rightClickAction()
        }
        
        func swipeLeft() -> Void {
            if loadedCards.count <= 0 {
                backEvaluation()
                return
            }
            if (allCards[3] == loadedCards[0])
            {
                backEvaluation()
            }
            var dragView: DraggableView = loadedCards[0]
            dragView.overlayView.setMode(mode: GGOverlayViewMode.GGOverlayViewModeLeft)
            UIView.animate(withDuration: 0.2, animations: {
                () -> Void in
                dragView.overlayView.alpha = 1
            })
            dragView.leftClickAction()
        }
}
