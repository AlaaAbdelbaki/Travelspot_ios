//
//  ProfileViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import Cards
import Alamofire
import AlamofireObjectMapper

class ProfileViewController: UIViewController {
    let baseUrl = "http://127.0.0.1:3000/services/"

    @IBOutlet weak var profileDetails: CardHighlight!
    @IBOutlet weak var flags: CardArticle!
    @IBOutlet weak var achievements: CardArticle!
    @IBOutlet weak var latestPost: CardArticle!
    var userA:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileDetails.delegate = self
        flags.delegate = self
        achievements.delegate = self
        latestPost.delegate = self
        
        
        
        
        Alamofire.request(baseUrl + "getUser?email=" + UserDefaults.standard.string(forKey: "email")!).responseObject{
            (response: DataResponse<User>) in
            let user = response.result.value
            self.userA = response.result.value
            self.profileDetails.title = user!.firstName! + " " + user!.lastName!
            Alamofire.request(self.baseUrl + "getFollowers?id=\(user!.id!)").responseArray{
                (response: DataResponse<[Follower]>) in
                let followers = response.result.value
                self.profileDetails.itemSubtitle = "\(followers!.count) followers"
                
            }
            Alamofire.request(self.baseUrl + "getCountries?id=\(user!.id!)").responseArray{
                (response: DataResponse<[Country]>) in
                let countries = response.result.value
                self.profileDetails.itemTitle = "Visited \(countries!.count) countries"
                
            }
            
            
        }
        
        profileDetails.buttonText = "Update Profile"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditUserController
        destinationVC.user = userA
    }

}

extension ProfileViewController: CardDelegate {
    
    func cardDidTapInside(card: Card) {
        
        
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        
        performSegue(withIdentifier: "editProfileSegue", sender: ProfileViewController.self)
    }
    
}


