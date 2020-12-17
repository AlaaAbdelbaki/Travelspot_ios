//
//  RegisterViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/3/20.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBAction func signupBtn(_ sender: Any) {
        let user = User(firstName: firstNameInput.text!, lastName: lastNameInput.text!, email: emailInput.text!, password: passwordInput.text!)
        let userJSON = user.toJSONString()
        let params = jsonToDictionary(from: userJSON!)
        Alamofire.request(Statics.BASE_URL_SERVICES+"signup",method: .post,parameters: params,encoding: JSONEncoding.default)
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
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

}
