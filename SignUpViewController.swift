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
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func onRegister(_ sender: Any) {
        validation()
        print("Berhasil berhasil berhasil hore we did it...")
        
    }
    
    func validation(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        if(username.text?.isEmpty == true){
            alert.message = "Username is empty!"
        }else if(email.text?.isEmpty == true){
            alert.message = "Email is empty!"
        }else if(password.text?.isEmpty == true){
            alert.message = "Password is empty!"
        }else{
            alert.message = "Account berhasil dibuat!"
            saveData()
        }
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
            alert.dismiss(animated: true,completion:nil)
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
    
}
