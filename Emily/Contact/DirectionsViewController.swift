//
//  DirectionsViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/01.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var callus: UIButton!
    @IBOutlet weak var emailus: UIButton!
    @IBOutlet weak var directions: UIButton!
    
    var latitude = 35.713102
    var longitude = 139.700335
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callus.layer.cornerRadius = 5.0
        emailus.layer.cornerRadius = 5.0
        directions.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let pinAnn = MKPointAnnotation()
        pinAnn.coordinate = pinLocation
        pinAnn.title = "Emily"
        pinAnn.subtitle = "123 Street, London, Emily Restaurant"
        self.mapView.addAnnotation(pinAnn)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func callUs(_ sender: Any) {
        UIApplication.shared.open(URL(string: "tel://123456789")!, options: [:], completionHandler: nil)
    }
    
    
    
    
    
    
    
    
    
 

}
