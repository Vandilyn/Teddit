//
//  CommentViewController.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let models = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentTableViewCell
        cell.username.text = "ANON"
        cell.comment.text = models.text
        return cell
    }
    

    @IBOutlet weak var judulPost: UILabel!
    @IBOutlet weak var isiPost: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var peopleComment: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var posts : Post?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var author : String = ""
    var judul : String = ""
    var content : String = ""
    private var comments = [Comment] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAll()
        tableView.delegate = self
        tableView.dataSource = self
        getAllData()
    }
    
    func loadAll(){
        authorName.text = author
        isiPost.text = content
        judulPost.text = judul
    }
    
    func getAllData(){
        comments = posts!.comments!.allObjects as! [Comment]
        tableView.reloadData()
    }

    @IBAction func postComment(_ sender: Any) {
        let newComment = Comment(context: context)
        newComment.sender = "ANON"
        newComment.text = peopleComment.text
        newComment.date = Date()
        posts?.addToComments(newComment)
        do{
            try context.save()
            getAllData()
        }catch{
            //error
        }
    }
}
