//
//  SignUpViewController.swift
//  newTeddit
//
//  Created by prk on 12/20/22.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userList = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        do{
            userList = try context.fetch(User.fetchRequest())
            for data in userList{
                print(data.username as Any)
            }
        }catch{
            //hiya
        }
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    @IBAction func onRegister(_ sender: Any) {
        let emailSignUp = email.text!
        let passwordSignUp = password.text!
        let usernameSignUp = username.text!
        
        if (usernameSignUp.isEmpty){
            let alert = UIAlertController(title: "Error", message: "Username is empty!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){alert.dismiss(animated: true,completion:nil)}
        }
        else if(!emailValidation(emailSignUp)){
            let alert = UIAlertController(title: "Error", message: "Email invalid!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){alert.dismiss(animated: true,completion:nil)}
        }
        else if(!passwordValidation(passwordSignUp)){
            let alert = UIAlertController(title: "Error", message: "Password invalid!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){alert.dismiss(animated: true,completion:nil)}
        }
        else{
            for dataList in userList{
                if(dataList.username == usernameSignUp){
                    let alert = UIAlertController(title: "Error", message: "Username has been taken try another one", preferredStyle: .alert)
                    present(alert, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){alert.dismiss(animated: true,completion:nil)}
                }else if(dataList.email == emailSignUp){
                    let alert = UIAlertController(title: "Error", message: "Email has already registered!", preferredStyle: .alert)
                    present(alert, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){alert.dismiss(animated: true,completion:nil)}
                }else{
                    print("Berhasil ngab")
                    saveData()
                    break
                }
            }
        }
    }
    
    
    func emailValidation(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func passwordValidation(_ password : String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func saveData(){
        let newUser = User(context: context)
        newUser.email = email.text
        newUser.password = password.text
        newUser.username = username.text
        do{
            try context.save()
            loadData()
        }catch{
            //hiya
        }
    }
    
}
