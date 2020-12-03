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
        var user:User?
        user?.email = emailInput.text
        user?.password = passwordInput.text
        user?.firstName = firstNameInput.text
        user?.lastName = lastNameInput.text
    }
    @IBAction func loginBtn(_ sender: Any) {
        
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

}
