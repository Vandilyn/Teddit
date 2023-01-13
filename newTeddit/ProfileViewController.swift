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
    
    @IBAction func onEdit(_ sender: Any) {
        let alert = UIAlertController(
            title: "New username", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: {[weak self]_ in guard
            let field = alert.textFields?.first,
            let text = field.text, !text.isEmpty else{
            return
        }
            self?.updateUsername(currName: self!.username, name: text)
            self?.username = text
            self?.loadAll()
        }))
        present(alert, animated: true)
    }
    
    func updateUsername(currName: String, name: String){
        let users: User!
        let fetchUser = User.fetchRequest()
        fetchUser.predicate = NSPredicate(format: "username = %@", currName)
        
        let results = try? context.fetch(fetchUser)
        users = results?.first
        do{
            users.username = name
            username = name
            TopicViewController.username = name
            try context.save()
        }catch{
            //ehe
        }
    }
}
