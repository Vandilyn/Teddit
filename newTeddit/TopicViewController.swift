//
//  TopicViewController.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//

import UIKit
import CoreData

class TopicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userText: UILabel!
    
    static var username = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [Topic]()

    @IBOutlet weak var tableViews: UITableView!
    static var curr = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameText()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.frame = view.bounds
        userText.text = TopicViewController.username
        let tap = UITapGestureRecognizer(target: self, action: #selector(TopicViewController.tapFunction))
        userText.isUserInteractionEnabled = true
        userText.addGestureRecognizer(tap)
        getAllItems()
    }
    
    func usernameText(){
        let users: User!
        let fetchUser = User.fetchRequest()
        fetchUser.predicate = NSPredicate(format: "email = %@", ViewController.email)
        
        let results = try? context.fetch(fetchUser)
        users = results?.first
        TopicViewController.username = users.username!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllItems()
    }
    
    @objc func tapFunction(){
        performSegue(withIdentifier: "profile", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.judul.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TopicViewController.curr =  indexPath.row
        performSegue(withIdentifier: "toPost", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toPost"){
            let dest = segue.destination as! postViewController
            dest.topic = models[TopicViewController.curr]
        }
        if(segue.identifier == "profile"){
            let dest = segue.destination as! ProfileViewController
            dest.username = userText.text!
        }
    }
    
    
    @IBAction func addOnTap(_ sender: Any) {
        let alert = UIAlertController(
            title: "New topic", message: "Enter topic name", preferredStyle: .alert
        )
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: {[weak self]_ in guard
            let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
            return
        }
            self?.createTopic(name: text)
        }))
        present(alert, animated: true)
    }
    
    func getAllItems(){
        do{
            models = try context.fetch(Topic.fetchRequest())
            tableViews.reloadData()
            userText.text = TopicViewController.username
        }catch{
            //error
        }
    }
    
    func createTopic(name: String){
        let newTopic = Topic(context: context)
        newTopic.name = name
        newTopic.dateCreated = Date()
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }

}
