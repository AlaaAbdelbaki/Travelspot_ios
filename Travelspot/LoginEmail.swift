//
//  LoginEmail.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/25/20.
//

import UIKit
import Alamofire


class LoginEmail: UIViewController{

    let baseUrl = "http://127.0.0.1:3000/services/checkLogin?email="
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    @IBAction func signUpBtn(_ sender: Any) {
    }
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailInput.text
        let password = passwordInput.text
        let request = AF.request(baseUrl+email!+"&pass="+password!)
        request.responseString { (response) in
            debugPrint(response.value!)
            if(response.value! == "true"){
                UserDefaults.standard.set(email,forKey: "email")
                if self.rememberMe.isOn {
                    UserDefaults.standard.set(true,forKey:"isRemembered")
                }
                self.performSegue(withIdentifier: "homeSegue", sender: LoginEmail.self)
            }else{
                let alert = UIAlertController(title: "Wrong password", message: "Please verify your credentials.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
//        if(true){
//
//        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
