//
//  RegisterViewController.swift
//  newTeddit
//
//  Created by prk on 12/19/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var emailSignUpTxtField: UITextField!
    @IBOutlet weak var passwordSignUpTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let username = userTxtField.text!
        let emailSignUp = emailSignUpTxtField.text!
        let passwordSignUp = passwordSignUpTxtField.text!
        
        if (!emailValidation(emailSignUp)){
            let alert = UIAlertController(title: "Error", message: "Email invalid!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                alert.dismiss(animated: true,completion:nil)
            }
        }
        else if (!passwordValidation(passwordSignUp)){
            let alert = UIAlertController(title: "Error", message: "Password invalid!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                alert.dismiss(animated: true,completion:nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Message", message: "Account create succesfully!", preferredStyle: .alert)
            present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                alert.dismiss(animated: true,completion:nil)
                self.performSegue(withIdentifier: "goToSignInUnwind", sender: self)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
