//
//  DiscoverViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import Alamofire
import Kingfisher

class DiscoverViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user")
        let contentView = cell?.contentView
        
        let profilePic = contentView?.viewWithTag(1) as! UIImageView
        let username = contentView?.viewWithTag(2) as! UILabel
        
        if(users[indexPath.row]!.profilePicture == nil){
            let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
            profilePic.kf.setImage(with:url )
        }else{
            let url = URL(string: Statics.BASE_URL+"uploads/\(users[indexPath.row]!.profilePicture!)")
            profilePic.kf.setImage(with: url)
        }
        username.text = "\(users[indexPath.row]!.firstName!) \(users[indexPath.row]!.lastName!)"
        
        
        return cell!
    }
    
    func getAllUsers(){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getUsers", method: .get).responseArray{
            (response: DataResponse<[User]>) in
            self.users = response.result.value!
            for _ in self.users{
                self.tableView.reloadData()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    var users : [User?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
        tableView.reloadData()

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

}
