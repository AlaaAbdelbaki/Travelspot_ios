//
//  HomeViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import MapboxGeocoder
import CoreLocation
import Alamofire

class HomeViewController: UIViewController,CLLocationManagerDelegate {
    private var locationManager:CLLocationManager?
    var coordinates: [CLLocationCoordinate2D]?
    
    let geocoder = Geocoder(accessToken: "sk.eyJ1IjoiYWxhYWFiIiwiYSI6ImNraWF2OHQ3MzAyMjUyenBvbTVsa2FmeTgifQ.545ZPew-d8DmUkrWgoWljg")

    var lat = 0.0
    var long = 0.0
    
    @IBOutlet weak var userPorfilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBAction func addPost(_ sender: Any) {
        performSegue(withIdentifier: "addPost", sender: self)
    }
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(Statics.BASE_URL_SERVICES + "getUser?email=" + UserDefaults.standard.string(forKey: "email")!).responseObject{
            (response: DataResponse<User>) in
            let user = response.result.value
            self.username.text = "Welcome back \(user!.firstName!)"
            if(user!.profilePicture == nil){
                let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
                self.userPorfilePic.kf.setImage(with: url)
            }else{
                let url = URL(string: Statics.BASE_URL+user!.profilePicture!)
                self.userPorfilePic.kf.setImage(with: url)
            }
        }
        
        getUserLocation()
        
        let options = ReverseGeocodeOptions(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
        geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }

            print(placemark.imageName ?? "")
                // telephone
            print(placemark.genres?.joined(separator: ", ") ?? "")
                // computer, electronic
            print(placemark.administrativeRegion?.name ?? "")
            self.city.text = placemark.administrativeRegion!.name
                // New York
            print(placemark.administrativeRegion?.code ?? "")
                // US-NY
            print(placemark.place?.wikidataItemIdentifier ?? "")
                // Q60
        }
        
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
        }
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
