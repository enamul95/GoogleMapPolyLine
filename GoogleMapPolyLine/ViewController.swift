//
//  ViewController.swift
//  GoogleMapPolyLine
//
//  Created by Enamul Haque on 11/30/19.
//  Copyright © 2019 HQUTEIT. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class ViewController: UIViewController {
//GMSMapViewDelegate
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
              let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
              view = mapView
        
    // Create a rectangular path
    let rect = GMSMutablePath()
    rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
    rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
    rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
    rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))

    // Create the polygon, and assign it to the map.
    let polygon = GMSPolygon(path: rect)
    polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
    polygon.strokeColor = .black
    polygon.strokeWidth = 2
    polygon.map = mapView
}
    
    
    
     func loadView1() {
       // Create a GMSCameraPosition that tells the map to display the
       // coordinate -33.86,151.20 at zoom level 6.
       let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
       let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
       view = mapView

       // Creates a marker in the center of the map.
//       let marker = GMSMarker()
//       marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//       marker.title = "Sydney"
//       marker.snippet = "Australia"
//       marker.map = mapView
        
        let path = GMSMutablePath()
        path.addLatitude(-37.81319, longitude: 144.96298)
        path.addLatitude(-31.95285, longitude: 115.85734)

        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 10.0
        polyline.geodesic = true
        polyline.map = mapView
        
        
        
//       let circleCenter = CLLocationCoordinate2D(latitude: 37.35, longitude: -122.0)
//       let circ = GMSCircle(position: circleCenter, radius: 1000)
//       circ.map = mapView
     }


    func drawRectange(){
   let path = GMSMutablePath()
   path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
   path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
   path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
   path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
   path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))

//   let polyLine = GMSPolyline(path: path)
//         polyLine.isTappable = true
//      polyLine.strokeColor = .black
//         polyLine.strokeWidth = 10.0
//     polyLine.map = mapView
//        mapView.settings.myLocationButton = true
        
        let polygon = GMSPolygon(path: path)
        polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
        polygon.strokeColor = .black
        polygon.strokeWidth = 10
        polygon.map = mapView
        
        
//        let polyLine: GMSPolyline = GMSPolyline(path: path)
//        polyLine.isTappable = true
//        polyline.zIndex = 0
//        polyline.map = mapView
    }

    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
      
    }
}



