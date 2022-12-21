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
        saveData()
        print("Berhasil berhasil berhasil hore we did it...")
        
    }
    
    func validation(){
        
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
