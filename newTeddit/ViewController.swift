//
//  ViewController.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//

import UIKit

class ViewController: UIViewController {

    var userList = [User]()
    static var currUser = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var emailSignInTxtfield: UITextField!
    @IBOutlet weak var passwordSignInTxtField: UITextField!
    
    static var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        do{
            userList = try context.fetch(User.fetchRequest())
        }catch{
            //hiya
        }
        
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
       
    }
    @IBAction func signInBtn(_ sender: Any) {
        //flag harusnya 0
        var flag = 0
        let emailSignIn = emailSignInTxtfield.text!
        let passwordSignIn = passwordSignInTxtField.text!

        if (!emailValidation(emailSignIn)){
            let alert = UIAlertController(title: "Error", message: "Email is not registered!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                alert.dismiss(animated: true,completion:nil)
            }
        }
        else if (!passwordValidation(passwordSignIn)){
            let alert = UIAlertController(title: "Error", message: "Password invalid!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                alert.dismiss(animated: true,completion:nil)
            }
        }
        else {
            for (index,data) in userList.enumerated(){
                if(emailSignIn == data.email && passwordSignIn == data.password){
                    flag = 1
                    ViewController.currUser = index
                    ViewController.email = emailSignIn
                    print("user ditemukan")
                    break
                }else{
                    print("Error")
                }
            }
            if(flag == 1){
                performSegue(withIdentifier: "goToTopic", sender: self)
                
            }else{
                print("Salah bego")
            }
        }
    }
    
    func emailValidation(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        return true
    }
    func passwordValidation(_ password : String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return true
    }
}

