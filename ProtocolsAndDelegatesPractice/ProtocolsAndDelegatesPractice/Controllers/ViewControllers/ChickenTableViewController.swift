//
//  ChickenTableViewController.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import UIKit

class ChickenTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ChickenController.sharedInstance.loadFromPresistenceStore()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChickenController.sharedInstance.Chickens.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chickenCell", for: indexPath)
        
        let currentChicken = ChickenController.sharedInstance.Chickens[indexPath.row]
        
        cell.textLabel?.text = currentChicken.name
        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let chicken = ChickenController.sharedInstance.Chickens[indexPath.row]
            ChickenController.sharedInstance.deleteChicken(chicken: chicken)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellToDetails"{
            guard let destination = segue.destination as? DetailsViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            destination.chicken = ChickenController.sharedInstance.Chickens[indexPath.row]
            
        } else if segue.identifier == "toGame" {
            if ChickenController.sharedInstance.Chickens.count < 4{
                
                let buttonMessages = [
                    "Crap",
                    "shoot",
                    "darnit",
                    "I agree I need more",
                    "Can you even have enough?",
                    "Dagnit"
                ]
                
                let alert = UIAlertController(title: "You don't have enough chickens", message: "You don't have enough chickens to play this game", preferredStyle: .alert)
                let okay = UIAlertAction(title: buttonMessages.randomElement(), style: .cancel, handler: nil)
                alert.addAction(okay)
                present(alert, animated: true, completion: nil)
            }
        }
    }

}
