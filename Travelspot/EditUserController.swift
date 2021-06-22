//
//  EditUserController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/3/20.
//

import UIKit
import Alamofire
import MobileCoreServices

class EditUserController: UIViewController{
    
    
    
    var user:User?
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    var imagePicker = UIImagePickerController()
    @IBAction func uploadImage(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    
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
    func returnMimeType(fileExtenstion : String)->String{
        if let oUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtenstion as NSString, nil)?.takeRetainedValue(){
            if let mimeType = UTTypeCreatePreferredIdentifierForTag(oUTI, kUTTagClassMIMEType, nil)?.takeRetainedValue(){
                return mimeType as! String
            }
        }
        return ""
    }

}


extension EditUserController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    struct RequestBodyFormDataKeyValue{
        var sKey : String
        var sValue : Int
        var dBlobData : Data
    }
    
    func showImagePickerControllerActionSheet(){
        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default, handler: {(action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        })
        let cameraAction = UIAlertAction(title: "Take a picture", style: .default, handler: {(action) in
            self.showImagePickerController(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction,cameraAction,cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType:UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
        var bodyKeyValue = [RequestBodyFormDataKeyValue]()
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "id", sValue: self.user!.id!, dBlobData: Data()))
        
        let fileArray = uploadedImage.image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            uploadedImage.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            uploadedImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
