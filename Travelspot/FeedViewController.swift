//
//  FeedViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import Alamofire
import Kingfisher

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    var posts : [Post?] = []
    var user : User?
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"post")
        let contentView = cell?.contentView
        
        //let profilePic = contentView?.viewWithTag(0) as! UIImageView
        let username = contentView?.viewWithTag(1) as! UILabel
        let postContent = contentView?.viewWithTag(2) as! UILabel
        let profilePic = contentView?.viewWithTag(4) as! UIImageView
        let likeBtn = contentView?.viewWithTag(3) as! UIButton
        Alamofire.request(Statics.BASE_URL_SERVICES+"getUserById?id=\(posts[indexPath.row]!.userId!)",method: .get).responseObject{
            (response : DataResponse<User>) in
            self.user = response.result.value!
            username.text = "\(self.user!.firstName!) \(self.user!.lastName!)"
            if(self.user!.profilePicture == nil){
                let url = URL(string: Statics.BASE_URL+"uploads/default.jpg")
                profilePic.kf.setImage(with: url)
            }else{
                let url = URL(string: Statics.BASE_URL+self.user!.profilePicture!)
                profilePic.kf.setImage(with: url)
            }
            
        }
        postContent.text = posts[indexPath.row]!.body
        debugPrint("\(posts[indexPath.row]!.userId!)")
        
        likeBtn.addTarget(self, action: #selector(likePost(postId:)), for: .touchUpInside)
        
        return cell!
    }
    
    @objc func likePost(postId : Int){
        
    }

    func getAllPosts(){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getposts").responseArray{
            (response : DataResponse<[Post]>) in
            self.posts = response.result.value!
            for post in self.posts {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func getUser(userId : Int ){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getUserById?id=\(userId)",method: .get).responseObject{
            (response : DataResponse<User>) in
            self.user = response.result.value!
            debugPrint("hello this is \(self.user!.email!)")
        }
    }

    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllPosts()
        debugPrint(posts.count)
        tableView.reloadData()        
    }
    

    
}
