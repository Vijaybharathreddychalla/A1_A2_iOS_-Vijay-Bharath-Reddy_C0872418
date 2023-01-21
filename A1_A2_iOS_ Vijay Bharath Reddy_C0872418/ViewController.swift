//
//  ViewController.swift
//  A1_A2_iOS_ Vijay Bharath Reddy_C0872418
//
//  Created by Vijay Bharath Reddy Challa on 2023-01-20.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let point = ["A","B","C"]
    
    
    var locationManager = CLLocationManager()
    var dropPinCount = 1
    var locationsArray = [CLLocationCoordinate2D]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
            
            addSingleTap()

}
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(viewRegion, animated: true)
            }

    }
    
    
    
    
    //single tap func
func addSingleTap() {
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
    singleTap.numberOfTapsRequired = 1
    mapView.addGestureRecognizer(singleTap)
}
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        if(dropPinCount <= 3){
            // add annotation
            let touchPoint = sender.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            let loc: CLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            var address = " "
            
            CLGeocoder().reverseGeocodeLocation(loc) { [self] (placemarks, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let placemark = placemarks?[0] {
                        
                        if placemark.locality != nil {
                            address += placemark.locality! + "\n"
                        }
                        
                        annotation.title = point.randomElement()
                    }
                    
                }
            }
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            // add coordinate to locationArr
            
            locationsArray.append(coordinate)
            
        }
        
        if( dropPinCount == 3){
           // addPolygon()
         //   DistanceBetweenMapPoints()
//
        }
        
        dropPinCount += 1
        //destination = coordinate
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        
//        map.removeAnnotations(map.annotations)
    }
    
    
   
    
    
    func DistanceBetweenMapPoints(){
        
        
        let coordinate1 = CLLocation(latitude: locationsArray[0].latitude, longitude: locationsArray[0].longitude)
        let coordinate2 = CLLocation(latitude: locationsArray[1].latitude, longitude: locationsArray[1].longitude)
        let coordinate3 = CLLocation(latitude: locationsArray[2].latitude, longitude: locationsArray[2].longitude)

        let distanceInMetersFirst = Int(coordinate1.distance(from: coordinate2))
        let distanceInMetersSecond = Int(coordinate2.distance(from: coordinate3))
        let distanceInMetersThird = Int(coordinate3.distance(from: coordinate1))
        
        // display distance between first two points
        
        let latitudeMidOne = ((locationsArray[0].latitude + locationsArray[1].latitude) / 2)
        let longitudeMidOne = ((locationsArray[0].longitude + locationsArray[1].longitude) / 2)
        
        let location1 = CLLocationCoordinate2D(latitude: latitudeMidOne, longitude: longitudeMidOne)
        let annotation1 = MKPointAnnotation()
        annotation1.title = String(distanceInMetersFirst) + " m"
        annotation1.coordinate = location1
        
        //mapView.addAnnotation(annotation1)
        
        // display distance between second third points
        
        let latitudeMidTwo = ((locationsArray[1].latitude + locationsArray[2].latitude) / 2)
        let longitudeMidTwo = ((locationsArray[1].longitude + locationsArray[2].longitude) / 2)
        
        let location2 = CLLocationCoordinate2D(latitude: latitudeMidTwo, longitude: longitudeMidTwo)
        let annotation2 = MKPointAnnotation()
        annotation2.title = String(distanceInMetersSecond) + " m"
        annotation2.coordinate = location2
       // mapView.addAnnotation(annotation2)
        
        // display distance between second third points
        
        let latitudeMidThree = ((locationsArray[2].latitude + locationsArray[0].latitude) / 2)
        let longitudeMidThree = ((locationsArray[2].longitude + locationsArray[0].longitude) / 2)
        
        let location3 = CLLocationCoordinate2D(latitude: latitudeMidThree, longitude: longitudeMidThree)
        let annotation3 = MKPointAnnotation()
        annotation3.title = String(distanceInMetersThird) + " m"
        annotation3.coordinate = location3
        //mapView.addAnnotation(annotation3)
        
        
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   



