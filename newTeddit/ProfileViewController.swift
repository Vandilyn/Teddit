//
//  ProfileViewController.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var usernameTxt: UILabel!
    
    var username = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAll()
    }
    
    func loadAll(){
        usernameTxt.text = username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! UINavigationController
        let tujuan = dest.viewControllers.first as! TopicViewController
        tujuan.username = usernameTxt.text!
    }
    
    @IBAction func onEdit(_ sender: Any) {
        let alert = UIAlertController(
            title: "New username", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: {[weak self]_ in guard
            let field = alert.textFields?.first,
            let text = field.text, !text.isEmpty else{
            return
        }
            self?.username = text
            self?.loadAll()
            self?.updateUsername(name: text)
        }))
        present(alert, animated: true)
    }
    
    func updateUsername(name: String){
        
    }
}
