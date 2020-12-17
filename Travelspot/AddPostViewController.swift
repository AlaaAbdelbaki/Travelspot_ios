//
//  AddPostViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/17/20.
//

import UIKit
import Alamofire

class AddPostViewController: UIViewController {

    @IBAction func addImage(_ sender: Any) {
    }
    @IBOutlet weak var postBody: UITextView!
    @IBAction func addPost(_ sender: Any) {
        let post = Post()
        post.body = postBody.text
        post.userId = 1
        post.tripId = 1
        post.location = "Tunis"
        let postJSON = post.toJSONString()
        let params = jsonToDictionary(from: postJSON!) ?? [String:Any]()
        Alamofire.request(Statics.BASE_URL_SERVICES+"addPost",method: .post,parameters: params,encoding: JSONEncoding.default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
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
