//
//  ViewController.swift
//  CapitalCities
//
//  Created by Dmitry Reshetnik on 26.04.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", info: "Home to the 2012 Summer Olympics.", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275))
        let oslo = Capital(title: "Oslo", info: "Founded over a thousand years ago.", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75))
        let paris = Capital(title: "Paris", info: "Often called the City of Light.", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508))
        let rome = Capital(title: "Rome", info: "Has a whole country inside it.", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5))
        let washington = Capital(title: "Washington", info: "Named after George himself.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(changeMapType))
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { (_) in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { (_) in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { (_) in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Canel", style: .cancel))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.systemYellow
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
//        let placeName = capital.title
//        let placeInfo = capital.info
        
        if let vc = storyboard?.instantiateViewController(identifier: "WebView") as? WebViewController {
            vc.selectedWebsite = capital.title!
            navigationController?.pushViewController(vc, animated: true)
        }
        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }


}

