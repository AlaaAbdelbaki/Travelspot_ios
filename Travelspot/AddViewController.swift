//
//  AddViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import Mapbox
import Alamofire


class AddViewController: UIViewController {

    
    @IBOutlet weak var tripTitleInput: UITextField!
    @IBOutlet weak var tripDestination : UITextField!
    @IBOutlet weak var startDateInput: UIDatePicker!
    @IBOutlet weak var endDateInput: UIDatePicker!
    @IBAction func openMap(_ sender: Any) {
        performSegue(withIdentifier: "openMap", sender: self)
    }
    @IBAction func addTrip(_ sender: Any){
        print(startDateInput.date)
        print(endDateInput.date)
        
        let trip = Trip(
            title: tripTitleInput.text!,
            startDate: startDateInput.date.timeIntervalSince1970,
            endDate: endDateInput.date.timeIntervalSince1970,
            location: tripDestination.text!,
            userId: Statics.user.id!
        )
        
        let tripJSON = trip.toJSONString(prettyPrint: true)
        let params = jsonToDictionary(from: tripJSON!) ?? [String : Any]()
        print("params: "+tripJSON!)
        Alamofire.request(Statics.BASE_URL_SERVICES+"addtrip",method: .post,parameters: params ,encoding: JSONEncoding.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "openMap"){
            let destination = segue.destination as! MapViewController
            destination.endDate = endDateInput.date
            destination.startDate = startDateInput.date
            destination.tripTitle = tripTitleInput.text
        }
    }
    
    
}
