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
    
    
    
    
    var posts : [Post] = []
    var ids: [Int] = []
    var user : User?
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //debugPrint("Number of posts is \(posts.count)")
        return posts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"post")
        let contentView = cell?.contentView
        
        //let profilePic = contentView?.viewWithTag(0) as! UIImageView
        let username = contentView?.viewWithTag(1) as! UILabel
        let postContent = contentView?.viewWithTag(2) as! UITextView
        let profilePic = contentView?.viewWithTag(4) as! UIImageView
        let likeBtn = contentView?.viewWithTag(3) as! UIButton
        let likeCount = contentView?.viewWithTag(5) as! UILabel
        postContent.isEditable = false
        Alamofire.request(Statics.BASE_URL_SERVICES+"getUserById?id=\(posts[indexPath.row].userId!)",method: .get).responseObject{
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
        Alamofire.request(Statics.BASE_URL_SERVICES+"getPostLikes?post=\(self.posts[indexPath.row].id!)").responseString{
            (response) in
            //debugPrint(likesResponse)
            let likeCountValue = Int(response.value!) ?? 0
            //debugPrint("likeCount is : \(likeCountValue)")
            self.posts[indexPath.row].likeCount = likeCountValue
            //debugPrint("Post updated")
            likeCount.text = "\(self.posts[indexPath.row].likeCount!) Likes"
            postContent.text = self.posts[indexPath.row].body
            //debugPrint("\(posts[indexPath.row].userId!)")
            
            likeBtn.addTarget(self, action: #selector(self.likePost), for: .touchUpInside)
        }
    
        
        Alamofire.request(Statics.BASE_URL_SERVICES+"getLike?postId=\(posts[indexPath.row].id!)&userId=\(Statics.user.id!)", method: .get, encoding: JSONEncoding.default).responseObject{
            (response : DataResponse<Like>) in
            if (response.value != nil){
                likeBtn.setTitle("Unlike", for: UIControl.State.normal)
            }else{
                likeBtn.setTitle("Like", for: UIControl.State.normal)
            }
        }
        
        
        
        
        return cell!
    }
    @objc func likePost(sender : UIButton){
        var superview = sender.superview
            while let view = superview, !(view is UITableViewCell) {
                superview = view.superview
            }
            guard let cell = superview as? UITableViewCell else {
                print("button is not contained in a table view cell")
                return
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                print("failed to get index path for cell containing button")
                return
            }
            // We've got the index path for the cell that contains the button, now do something with it.
        //print("button is in row \(indexPath.row) and post id is = \(ids[indexPath.row])")
        let like = Like()
        
        like.postId = posts[indexPath.row].id!
        like.userId = Statics.user.id!
        //debugPrint("current user id is = \(like.userId!)")
        let likeJson = like.toJSONString(prettyPrint: true)
        let params = jsonToDictionary(from: likeJson!) ?? [String : Any]()
        Alamofire.request(Statics.BASE_URL_SERVICES+"likePost",method: .post,parameters: params,encoding: JSONEncoding.default).responseString{
            (response) in
            if (response.value! == "false"){
                Alamofire.request(Statics.BASE_URL_SERVICES+"unlikepost",method: .delete,parameters: params,encoding: JSONEncoding.default)
                let likeBtn = cell.contentView.viewWithTag(3) as! UIButton
                likeBtn.setTitle("Like", for: UIControl.State.normal)
            }
            
        }
        let likeCount = cell.contentView.viewWithTag(5) as! UILabel
        let likeBtn = cell.contentView.viewWithTag(3) as! UIButton
        likeBtn.setTitle("Unlike", for: UIControl.State.normal)
        likeCount.text = "\(self.posts[indexPath.row].likeCount!+1) Likes"
        tableView.reloadData()
        /*let postId = IndexPath(row: sender.tag, section: 0).row
        debugPrint("Post id : \(postId)")*/
    }
    
    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
    }
    
    

    func getAllPosts(){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getposts").responseArray{
            (response : DataResponse<[Post]>) in
            self.posts = response.result.value!.reversed()
            for post in self.posts {
                self.ids.append(post.id!)
                post.likeCount = 420
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func getUser(userId : Int ){
        Alamofire.request(Statics.BASE_URL_SERVICES+"getUserById?id=\(userId)",method: .get).responseObject{
            (response : DataResponse<User>) in
            self.user = response.result.value!
            //debugPrint("hello this is \(self.user!.email!)")
        }
    }
    
    
    

    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        activityIndicator.startAnimating() // Start animating
        if(posts.isEmpty){
            getAllPosts()
        }
        tableView.reloadData()
        activityIndicator.stopAnimating() // On response stop animating
        activityIndicator.removeFromSuperview() // remove the view
    }
    

    
}
