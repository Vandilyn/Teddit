//
//  SignUpViewController.swift
//  newTeddit
//
//  Created by prk on 12/20/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
    }
    
    var users = [User]()
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func onRegister(_ sender: Any) {
        validation()
    }
    
    func validation(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
   
        if(password.text?.isEmpty == true){
            alert.message = "Password is empty!"
        }
        if(email.text?.isEmpty == true){
            alert.message = "Email is empty!"
        }
        if(username.text?.isEmpty == true){
            alert.message = "Username is empty!"
        }
        if(email.text?.isEmpty == false){
            if(!validateEmailStructure(email: email.text!)){
                alert.message = "Invalid email structure! (example@example.com)"
            }else{
                for i in 0...users.count-1{
                    if(users[i].email == email.text){
                        alert.message = "Email has already taken"
                        break
                    }
                }
            }
        }
        if(password.text?.isEmpty == false){
            if(!validatePasswordStructure(password: password.text!)){
                alert.message = "Invalid password structure!"
            }
        }
        if(alert.message!.isEmpty){
            saveData()
            alert.message = "Account berhasil dibuat!"
        }
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            alert.dismiss(animated: true,completion:nil)
        }
    }
    
    func checkUser(){
        do{
            users = try context.fetch(User.fetchRequest())
        }catch{
            //ehe
        }
    }
    
    func saveData(){
        let newUser = User(context: context)
        newUser.email = email.text
        newUser.password = password.text
        newUser.username = username.text
        do{
            try context.save()
        }catch{
            //hiya
        }
    }
    
    func validateEmailStructure(email: String) -> Bool{
        let emailSplit = email.split(separator: "@")
        let size = emailSplit.count
        if(size==2 && emailSplit[1].hasSuffix(".com")){
            return true
        }
        return false
    }
    
    func validatePasswordStructure(password: String) -> Bool{
        let size = password.count
        for i in 0...size-1{
            print("I adalah \(i)")
        }
        if(size<8){
            return false
        }else{
            return true
        }
    }
}
