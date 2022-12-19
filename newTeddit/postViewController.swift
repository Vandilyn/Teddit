//
//  postViewController.swift
//  newTeddit
//
//  Created by prk on 18/12/22.
//

import UIKit
import CoreData

class postViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    private var models = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        getAllItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.judulPost.text = model.judul
        cell.authorName.text = model.author
        return cell
    }
    
    @IBAction func addOnTap(_ sender: Any) {
        let alert = UIAlertController(
            title: "New Post", message: "Enter post title", preferredStyle: .alert
        )
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: {[weak self]_ in guard
            let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
            return
        }
            self?.createPost(name: text)
        }))
        present(alert, animated: true)
    }
    
    func getAllItems(){
        do{
            models = try context.fetch(Posts.fetchRequest())
            tableView.reloadData()
        }catch{
            //error
        }
    }
    
    func createPost(name: String){
        let newPost = Posts(context: context)
        newPost.judul = name
        newPost.author = "ANON"
//        newPost.topic =
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }
}
