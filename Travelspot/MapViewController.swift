//
//  MapViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/9/20.
//

import UIKit
import Mapbox
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MGLMapViewDelegate {
    
    private var locationManager:CLLocationManager?
    
    var lat = 0.0
    var long = 0.0
    var mapView :MGLMapView!
    var coordinates: [CLLocationCoordinate2D]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserLocation()
        locationManager?.delegate = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    
    func getUserLocation() {
           locationManager = CLLocationManager()
           locationManager?.requestAlwaysAuthorization()
           locationManager?.startUpdatingLocation()
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
            debugPrint(lat)
            debugPrint(long)
            let url = URL(string: "mapbox://styles/mapbox/streets-v11")
            mapView = MGLMapView(frame: view.bounds, styleURL: url)
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: long), zoomLevel: 5, animated: false)
            view.addSubview(mapView)
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
            for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
            }
            mapView.addGestureRecognizer(singleTap)
        }
    }
    
   @IBAction func handleMapTap(sender: UITapGestureRecognizer){
        let tapPoint: CGPoint = sender.location(in: mapView)
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        print("You tapped at : \(tapCoordinate.latitude), \(tapCoordinate.longitude)")
    
    var coordinates: [CLLocationCoordinate2D] = [mapView.centerCoordinate,tapCoordinate]
    coordinates.append(tapCoordinate)
    for coordinate in coordinates{
        print("latitude is \(coordinate.latitude) and longitude is \(coordinate.longitude)")
    }
    long = tapCoordinate.longitude
    lat = tapCoordinate.latitude
    mapView.setCenter(tapCoordinate, animated: true)
    /*if mapView.annotations?.count != nil, let existingAnnotations =
        mapView.annotations{
        mapView.removeAnnotations(existingAnnotations)
    }*/
    let polyline = MGLPolyline(coordinates: &coordinates, count:
                                UInt(coordinates.count))
    mapView.addAnnotation(polyline)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
