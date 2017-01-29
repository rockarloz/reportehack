//
//  MapViewController.swift
//  SuperCivicos
//
//  Created by Carlos Castellanos on 17/09/16.
//  Copyright © 2016 Carlos Castellanos. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    var data: NSDictionary! = nil
    let containerMap = UIView ()
    let btncloseMap = UIButton(type: .custom)
    let mapViewFS =  MKMapView()
    let screenSize : CGRect = UIScreen.main.bounds
    var customBar = UIView ()
    var img = UIImage ()
    let lblTitle = UILabel()
    let btnclose = UIButton(type: .custom)
    let btnLocation = UIButton(type: .custom)
        let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCumtombar()
        
        
        //added map
        mapViewFS.frame = CGRect(x: 0,y: 64, width: screenSize.width,height: screenSize.height-64)
        mapViewFS.mapType = MKMapType.standard
        mapViewFS.isZoomEnabled = true
        mapViewFS.isScrollEnabled = true
        mapViewFS.showsUserLocation = true
        mapViewFS.delegate = self
        self.view.addSubview(mapViewFS)
        
        
        let markerLocation = CLLocationCoordinate2DMake(data.object(forKey: "latitude") as! Double, data.object(forKey: "longitude")as! Double)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = markerLocation
        
        mapViewFS.addAnnotation(dropPin)
        let regionRadius: CLLocationDistance = 400
        func centerMapOnLocation(_ location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapViewFS.setRegion(coordinateRegion, animated: true)
        }
     
        let initialLocation = CLLocation(latitude: dropPin.coordinate.latitude, longitude: dropPin.coordinate.longitude)
        centerMapOnLocation(initialLocation)

        btnLocation.frame = CGRect(x: self.view.frame.size.width - 51, y: self.view.frame.size.height - 51, width: 41, height: 41)
        btnLocation.setImage(UIImage(named: "icGpsFixedGreen.png"), for: UIControlState())
        btnLocation.backgroundColor = UIColor.white
        btnLocation.setTitleColor(UIColor.white, for: UIControlState())
        btnLocation.layer.cornerRadius = 4
        btnLocation.clipsToBounds = true
        btnLocation.addTarget(self, action: #selector(MapViewController.showUser(_:)), for: .touchUpInside)
        self.view.addSubview(btnLocation)
}
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        let detailButton: UIButton = UIButton(type: UIButtonType.detailDisclosure)
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if  annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
                   }
        else {
            annotationView!.annotation = annotation
        }
      
        
        let auxTypeD =  data.object(forKey: "type") as! NSDictionary
        
        let url = URL(string: ((auxTypeD.object(forKey: "image"))! as! String))

        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            print("dabe cambiar")
            DispatchQueue.main.async(execute: {
                annotationView!.image = UIImage(named:"pin.png")//UIImage(data: data!)
                annotationView?.frame = CGRect(x: annotationView!.frame.origin.x, y: annotationView!.frame.origin.y, width: 40, height: 40)
                annotationView!.contentMode = .scaleAspectFit
                
                print("dabe cambiar")
            });
        }
        return annotationView
    }
    func setupCumtombar(){
     
        
        customBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        customBar.backgroundColor = Colors.green
        self.view.addSubview(customBar)
        
        UIElements.setGradient(customBar, c1: Colors.greentop , c2: Colors.greenbottom)
        
        
        btnclose.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
        btnclose.setImage(UIImage(named: "icArrowBack.png"), for: UIControlState())
        btnclose.backgroundColor = UIColor.clear
        btnclose.setTitleColor(UIColor.white, for: UIControlState())
        
        btnclose.clipsToBounds = true
        btnclose.addTarget(self, action: #selector(MapViewController.close(_:)), for: .touchUpInside)
        self.customBar.addSubview(btnclose)
        
        
      
         lblTitle.frame = CGRect(x: 0, y: 32, width: self.view.frame.size.width, height: 22)
        lblTitle.text = "UBICACIÓN"
        lblTitle.textAlignment = .center
        lblTitle.font = Fonts.MR16
        
        lblTitle.textColor = UIColor.white
        self.customBar.addSubview(lblTitle)
        
    }
    
    func close(_ sender: UIButton!) {
        self.dismiss(animated: false, completion: nil)
    }
    func showUser (_ sender: UIButton!)
    {
          var center = CLLocationCoordinate2D()
        #if (arch(i386) || arch(x86_64)) && os(iOS)
           /// let DEVICE_IS_SIMULATOR = true
            center = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        #else
           // let DEVICE_IS_SIMULATOR = false
           center = CLLocationCoordinate2D(latitude: self.locationManager.location!.coordinate.latitude, longitude: self.locationManager.location!.coordinate.longitude)
        #endif
        
    
    
      
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapViewFS.setRegion(region, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
