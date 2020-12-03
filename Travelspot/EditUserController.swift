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
    let baseUrl = "http://127.0.0.1/services/"
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
            
            //Alamofire.request(baseUrl,method: .put,parameters: user,encoding: JSONEncoding.default)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(user!.id != nil){
            emailInput.text = user!.email
            lastNameInput.text = user!.lastName
            firstNameInput.text = user!.firstName
        }
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
