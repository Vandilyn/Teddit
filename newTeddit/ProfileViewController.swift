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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            alert.dismiss(animated: true,completion:nil)
        }
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        performSegue(withIdentifier: "backToLogin", sender: self)
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
            
            updatePost(currName: currName, name: name)
            try context.save()
        }catch{
            //ehe
        }
    }
    
    func updatePost(currName: String, name: String){
        let posts: Post!
        
        let fetchPost = Post.fetchRequest()
        fetchPost.predicate = NSPredicate(format: "author = %@", currName)
        
        let results = try? context.fetch(fetchPost)
        
        if(results?.count == 0){
            //ehe
        }
        else if(results?.count == 1){
            posts = results?.first
            posts.author = name
        }else{
            for i in 0...results!.count-1{
                results![i].author = name
            }
        }
    }
    
}
