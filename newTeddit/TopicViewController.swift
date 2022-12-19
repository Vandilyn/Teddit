//
//  TopicViewController.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//

import UIKit
import CoreData

class TopicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [TopicList]()

    @IBOutlet weak var tableViews: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.frame = view.bounds
        getAllItems()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.judul.text = model.topicName
        return cell
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
            models = try context.fetch(TopicList.fetchRequest())
            tableViews.reloadData()
        }catch{
            //error
        }
    }
    
    func createTopic(name: String){
        let newTopic = TopicList(context: context)
        newTopic.topicName = name
        newTopic.createdAt = Date()
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }

}
