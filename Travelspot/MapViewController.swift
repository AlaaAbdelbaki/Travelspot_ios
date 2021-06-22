//
//  MapViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/9/20.
//

import UIKit
import Mapbox
import CoreLocation
import MapboxGeocoder

class MapViewController: UIViewController,CLLocationManagerDelegate,MGLMapViewDelegate {
    
    private var locationManager:CLLocationManager?
    
    var lat = 0.0
    var long = 0.0
    var mapView :MGLMapView!
    var coordinates: [CLLocationCoordinate2D]?
    var tripTitle : String?
    var cityName : String?
    var startDate : Date?
    var endDate : Date?
    let geocoder = Geocoder(accessToken: "sk.eyJ1IjoiYWxhYWFiIiwiYSI6ImNraWF2OHQ3MzAyMjUyenBvbTVsa2FmeTgifQ.545ZPew-d8DmUkrWgoWljg")
    
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
    /*let polyline = MGLPolyline(coordinates: &coordinates, count:
                                UInt(coordinates.count))
    mapView.addAnnotation(polyline)*/
    reverseGeocoding(long: long, lat: lat)
    if(self.cityName != nil){
        print("City is: "+self.cityName!)
    }
    //self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func reverseGeocoding(long:Double,lat:Double){
        let options = ReverseGeocodeOptions(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
        // Or perhaps: ReverseGeocodeOptions(location: locationManager.location)


        let task = geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }

            print(placemark.imageName ?? "")
                // telephone
            print(placemark.genres?.joined(separator: ", ") ?? "")
                // computer, electronic
            print(placemark.administrativeRegion?.name ?? "")
            self.cityName = placemark.administrativeRegion?.name ?? ""
                // New York
            print(placemark.administrativeRegion?.code ?? "")
                // US-NY
            print(placemark.place?.wikidataItemIdentifier ?? "")
                // Q60
            self.performSegue(withIdentifier: "backToAddTrip", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToAddTrip"){
            if let destination = segue.destination as? UITabBarController{
                destination.selectedIndex = 2
                let dest = destination.viewControllers![2] as! AddViewController
                dest.endDateInput?.date = self.endDate!
                dest.startDateInput?.date = self.startDate!
                dest.tripTitleInput?.text = self.tripTitle!
                dest.tripDestination?.text = self.cityName!
            }
            
        }
    }
    
    
}
