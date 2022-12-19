//
//  ViewController.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailSignInTxtField: UITextField!
    @IBOutlet weak var passwordSignInTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
       
    }
    @IBAction func signInBtn(_ sender: Any) {
        let emailSignIn = emailSignInTxtField.text!
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
            performSegue(withIdentifier: "goToTopic", sender: self)
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
}

