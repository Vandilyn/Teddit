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
   
    private var models = [Post]()
    var topic: Topic?
    var curr = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        getAllItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curr  = indexPath.row
        performSegue(withIdentifier: "detailSection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! CommentViewController
        dest.author = models[curr].author!
        dest.judul = models[curr].judul!
        dest.content = models[curr].content!
        dest.posts = models[curr]
    }
    
    @IBAction func addOnTap(_ sender: Any) {
        let alert = UIAlertController(
            title: "New Post", message: "Post detail", preferredStyle: .alert
        )
        alert.addTextField{ field in
            field.placeholder = "Post Title"
            field.returnKeyType = .next
        }
        
        alert.addTextField{ field in
            field.placeholder = "Post content"
            field.returnKeyType = .continue
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {[weak self]_ in
            guard let fields = alert.textFields, fields.count == 2 else {
            return
        }
            let postTitle = fields[0]
            let postContent = fields[1]
            guard let title = postTitle.text, !title.isEmpty,
                  let content = postContent.text, !content.isEmpty else{
                print("Error")
                return
            }
            self?.createPost(name: title, content: content)
        }))
        present(alert, animated: true)
    }
    
    func getAllItems(){
        models = topic!.posts!.allObjects as! [Post]
        tableView.reloadData()
    }
    
    @IBAction func unwindToPost(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func createPost(name: String, content: String){
        let newPost = Post(context: context)
        newPost.judul = name
        newPost.author = TopicViewController.username
        newPost.content = content
        topic?.addToPosts(newPost)
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }
    
}
