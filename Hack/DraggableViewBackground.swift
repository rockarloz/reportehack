//
//  DraggableViewBackground.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import Foundation
import UIKit

class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    
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
        let agency = ["agency01.png","agency02.png","agency03.png","agency04.png","agency05.png","agency05.png"]
        let question = ["question01.png","question02.png","question03.png","question04.png"]
        let report = ["report01.png","report02.png","report03.png","report04.png"]
    
        exampleCardLabels = agency
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }
    
    func setupView() -> Void {
        self.backgroundColor =  UIColor(red: 233.0/255.0, green: 35.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        xButton = UIButton(frame: CGRect(x:(self.frame.size.width/2) - (self.frame.size.width * 0.10) - 35, y:self.frame.size.height/2 + CARD_HEIGHT/2 + 0, width:self.frame.size.width * 0.15, height:self.frame.size.width * 0.15))
        xButton.setImage(UIImage(named: "nope.png"), for: UIControlState.normal)
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), for: UIControlEvents.touchUpInside)
        
        checkButton = UIButton(frame: CGRect(x:self.frame.size.width/2 + (self.frame.size.width * 0.10), y:self.frame.size.height/2 + CARD_HEIGHT/2 + 0, width: self.frame.size.width * 0.15 ,height: self.frame.size.width * 0.15))
        checkButton.setImage(UIImage(named: "oval.png"), for: UIControlState.normal)
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), for: UIControlEvents.touchUpInside)
        
        self.addSubview(xButton)
        self.addSubview(checkButton)
    }
    
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame:  CGRect( x: 20, y: (self.frame.size.height * 0.20) + self.frame.size.width * 0.20 , width:self.frame.size.width - 40, height: self.frame.size.width - 40))
        draggableView.information.text = ""
        //set image
        
        draggableView.imageView.image =  UIImage(named: exampleCardLabels[index])
        
        draggableView.delegate = self
        return draggableView
        
    }
    func close(_ sender: UIButton!) {
        
        
        //self.dismiss(animated: false, completion: nil)
        self.removeFromSuperview()
        
    }
    
    
    func loadCards() -> Void {
        
      
        
        let lblTime = UILabel ()
        lblTime.frame = CGRect(x: 20, y: 20  , width: self.frame.size.width - 40, height: 100)
        lblTime.text = "Evalúa el servicio global"
        lblTime.textColor =  UIColor(red: 12.0/255.0, green: 215.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        lblTime.sizeToFit()
        lblTime.center.x = self.center.x
        lblTime.backgroundColor = UIColor.clear
        
        self.addSubview(lblTime)
        
        
        let lblDesc = UILabel ()
        lblDesc.frame = CGRect(x: 35, y:50  , width: self.frame.size.width - 70, height: self.frame.size.height * 0.20)
        lblDesc.text = "Agencia de Ministerio Público CUH5"
        lblDesc.textColor = .white
        lblDesc.numberOfLines = 2
        lblDesc.layer.cornerRadius = 10
        lblDesc.layer.masksToBounds = true
        lblDesc.textAlignment = .center
        //lblDesc.sizeToFit()
        lblDesc.center.x = self.center.x
        lblDesc.backgroundColor = UIColor(red: 117.0/255.0, green: 133.0/255.0, blue: 243.0/255.0, alpha: 1.0)

        
        self.addSubview(lblDesc)
        
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
    
    func backEvaluation()
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "finishedEvaluationAgency"), object: nil)
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
        else{
            backEvaluation()
        }
    }
    
    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        if (allCards[5] == loadedCards[0])
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
            return
        }
        if (allCards[5] == loadedCards[0])
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
