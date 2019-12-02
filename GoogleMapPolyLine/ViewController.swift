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
import JJFloatingActionButton

class CustomButton: UIButton {
    var gps = ""
    override func awakeFromNib() {
        super.awakeFromNib()

        //TODO: Code for our button
    }
}
class ViewController: UIViewController ,GMSMapViewDelegate,CLLocationManagerDelegate{
//GMSMapViewDelegate
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var button_view: UIView!
    fileprivate let actionButton = JJFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.4, longitude:-122.0, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
         //mapView.myLocationEnabled = true
           mapView.settings.myLocationButton = true;
        self.view = mapView
        
        
        

          self.locationManager.delegate = self
           self.locationManager.startUpdatingLocation()
//
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
//        marker.title = "Cyberjaya"
//        marker.snippet = "Malaysia"
//        marker.map = mapView
 

        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        mapView.addSubview(self.button_view)
        
     
        
        // Create a rectangular path
        let rect = GMSMutablePath()
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))

        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
        polygon.strokeColor = UIColor.init(hue: 210, saturation: 88, brightness: 84, alpha: 1)
        //polygon.strokeColor = .black
        polygon.strokeWidth = 2
        polygon.map = mapView
        
        self.view.bringSubviewToFront(self.button_view)
        
        actionButton.buttonColor = .red

        actionButton.addItem(title: "Heart", image: nil) { item in
            //Helper.showAlert(for: item)
            print("ddd")
        }

  func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
      if marker.title != nil {

          let mapViewHeight = mapView.frame.size.height
          let mapViewWidth = mapView.frame.size.width


          let container = UIView()
        container.frame = CGRect(x: mapViewWidth - 100, y: mapViewHeight - 63, width: 65, height: 35)
        container.backgroundColor = UIColor.white
          self.view.addSubview(container)

          let googleMapsButton = CustomButton()
      //  googleMapsButton.setTitle("", for: .Normal)
       // googleMapsButton.setTitle("", for: UIControl.State.Normal)
        // googleMapsButton.setTitle(NSLocalizedString("", comment: ""), for: state)
       // googleMapsButton.setImage(UIImage(named: "googlemaps"), forState: .Normal)
        //googleMapsButton.setImage(UIImage(named: "play.png"), for: UIControl.State.Normal)
         googleMapsButton.setImage(UIImage.init(named: "uncheck"), for: UIControl.State.normal)
        //  googleMapsButton.setTitleColor(UIColor.blue, for: .Normal)
        googleMapsButton.frame = CGRect(x: mapViewWidth - 80, y: mapViewHeight - 70, width: 50, height: 50)
       // googleMapsButton.addTarget(self, action: Selector("markerClick:"), forControlEvents: .touchUpInside)
          googleMapsButton.gps = String(marker.position.latitude) + "," + String(marker.position.longitude)
         // googleMapsButton.title = marker.title
          googleMapsButton.tag = 0

         
          self.view.addSubview(googleMapsButton)
         // self.view.addSubview(directionsButton)
      }
      return true
  }

//        actionButton.display(inViewController: self)
//        
//        
//           let actionButton2 = JJFloatingActionButton()
//        
//        actionButton2.buttonColor = .red
//
//        actionButton2.addItem(title: "Heart", image: nil) { item in
//            //Helper.showAlert(for: item)
//            print("ddd")
//        }

        actionButton.display(inViewController: self)
        
//        let actionButton = JJFloatingActionButton()
//
//        actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
//          // do something
//        }
//
//        actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
//          // do something
//        }
//
//        actionButton.addItem(title: "item 3", image: nil) { item in
//          // do something
//        }
//
//        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        
//           let revealButton = UIButton()
//           let btnImage = UIImage(named: "reveal-icon")
//           revealButton.setImage(btnImage, for: .normal)
//           revealButton.frame = CGRect(x: 16, y: 38, width: 48, height: 41)
//           self.view.addSubview(revealButton)
        
       // getCurrentLocation()
        //23.7105556,90.4321393
        
    }
     
    
     func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("*******ddd","dddaaaaa")
        let location = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)

        self.mapView?.animate(to: camera)

        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
    
     


//    func getCurrentLocation() {
//        // Ask for Authorisation from the User.
//        self.locationManager.requestAlwaysAuthorization()
//
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//    }
    
}

//extension ViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("dddd","****dddd")
//           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//           print("locations = \(locValue.latitude) \(locValue.longitude)")
//
//    }
////
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        if let location = locations.last{
////            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
////
////        }
////    }
//}



