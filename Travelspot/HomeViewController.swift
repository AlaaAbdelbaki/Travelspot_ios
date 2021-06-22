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

class HomeViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    var trips : [Trip] = []
    var user : User?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trip")
        let contentView = cell?.contentView
        
        let countryName = contentView?.viewWithTag(1) as! UILabel
        let visitDate = contentView?.viewWithTag(3) as! UILabel
        
        if(trips.count > 0){
            countryName.text = trips[indexPath.row].location!
            //visitDate.text = DateFormatter().string(from: Date(timeIntervalSince1970: trips[indexPath.row].startDate!))
            visitDate.text = "23/06/2021"
        }
        
        return cell!
    }
    
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
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request(Statics.BASE_URL_SERVICES + "getUser?email=" + UserDefaults.standard.string(forKey: "email")!).responseObject{
            (response: DataResponse<User>) in
            let user = response.result.value
            Statics.user = user!
            self.user = user!
            self.username.text = "Welcome back \(user!.firstName!)"
            //debugPrint("\(user!.profilePicture!)")
            if(user!.profilePicture == nil){
                let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
                self.userPorfilePic.kf.setImage(with: url)
            }else{
                let url = URL(string: Statics.BASE_URL+user!.profilePicture!)
                //debugPrint("\(url!)")
                self.userPorfilePic.kf.setImage(with: url)
            }
        }
        
        if(trips.isEmpty){
            getAllTrips()
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
    
    func getAllTrips(){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getTripsByUser?userId=1").responseArray{
            (response : DataResponse<[Trip]>) in
            self.trips = response.result.value!
            
            print(self.trips.count)
            self.tableView.reloadData()
        }
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
