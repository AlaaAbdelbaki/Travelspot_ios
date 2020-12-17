//
//  EditUserController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/3/20.
//

import UIKit
import Alamofire

class EditUserController: UIViewController {
    
    var user:User?
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBAction func updateBtn(_ sender: Any) {
        if(passwordInput.text == confirmPasswordInput.text){
            user?.email = emailInput.text
            user?.firstName = firstNameInput.text
            user?.lastName = lastNameInput.text
            if(passwordInput.text != ""){
                user?.password = passwordInput.text
            }
            
            let userJSON = user?.toJSONString()
            let params = jsonToDictionary(from: userJSON!)
            Alamofire.request(Statics.BASE_URL_SERVICES+"updateUser",method: .put,parameters: params,encoding: JSONEncoding.default)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(user!.id != nil){
            //debugPrint("\(user!.id!)")
            emailInput.text = user!.email
            lastNameInput.text = user!.lastName
            firstNameInput.text = user!.firstName
        }
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
