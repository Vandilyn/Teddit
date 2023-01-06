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
    
    var username = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [Topic]()

    @IBOutlet weak var tableViews: UITableView!
    static var curr = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.frame = view.bounds
        print("HIyA: \(username)")
        userText.text = username
        getAllItems()
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
        let dest = segue.destination as! postViewController
        dest.topic = models[TopicViewController.curr]
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
