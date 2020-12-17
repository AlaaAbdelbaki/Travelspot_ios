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
import Kingfisher
import MaterialComponents

class ProfileViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    

    
    var userA:User?
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var countries: UILabel!
    @IBAction func userCard(_ sender: MDCCard) {
        performSegue(withIdentifier: "editProfileSegue", sender:self)
    }
    
    @IBOutlet weak var postProfilePic: UIImageView!
    @IBOutlet weak var postUsername: UILabel!
    @IBOutlet weak var postLocation: UILabel!
    @IBOutlet weak var postBody: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
        Alamofire.request(Statics.BASE_URL_SERVICES + "getUser?email=" + UserDefaults.standard.string(forKey: "email")!).responseObject{
            (response: DataResponse<User>) in
            let user = response.result.value
            self.userA = response.result.value
            self.username.text = user!.firstName! + " " + user!.lastName!
            if(user!.profilePicture == nil){
                let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
                self.profilePicture.kf.setImage(with: url)
            }else{
                let url = URL(string: Statics.BASE_URL+user!.profilePicture!)
                self.profilePicture.kf.setImage(with: url)
            }
            /*Alamofire.request(self.baseUrl + "getFollowers?id=\(user!.id!)").responseArray{
                (response: DataResponse<[Follower]>) in
                let followers = response.result.value
                self.profileDetails.itemSubtitle = "\(followers!.count) followers"
                
            }*/
            Alamofire.request(Statics.BASE_URL_SERVICES + "getCountries?id=\(user!.id!)").responseArray{
                (response: DataResponse<[Country]>) in
                let countries = response.result.value
                self.countries.text = "Visited \(countries!.count) countries"
                
            }
            
            Alamofire.request(Statics.BASE_URL_SERVICES+"getpostsbyuser?id=\(user!.id!)").responseArray{
                (response: DataResponse<[Post]>) in
                let posts = response.result.value
                if(user!.profilePicture == nil){
                    let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
                    self.postProfilePic.kf.setImage(with: url)
                }else{
                    let url = URL(string: Statics.BASE_URL+user!.profilePicture!)
                    self.postProfilePic.kf.setImage(with: url)
                }
                self.postBody.text = posts![0].body
                self.postLocation.text = posts![0].location
                self.postUsername.text = "\(user!.firstName!) \(user!.lastName!)"
            }
            
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        
        //profileDetails.buttonText = "Update Profile"
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
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


