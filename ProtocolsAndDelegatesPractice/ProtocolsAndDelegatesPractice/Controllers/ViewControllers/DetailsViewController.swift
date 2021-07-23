//
//  DetailsViewController.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    
    //MARK: - Properties
    var chicken: Chicken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews(){
        guard let chicken = chicken else {return}
        nameTextField.text = chicken.name
        weightTextField.text = "\(chicken.weight)"
        birthDatePicker.date = chicken.birthDate
        detailsTextView.text = chicken.personalityTraits
    }

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              let weight = weightTextField.text,
              let details = detailsTextView.text else {return}
        
        if let chicken = chicken{
            ChickenController.sharedInstance.updateChicken(chicken: chicken, newName: name, newBirthDate: birthDatePicker.date, newWeight: Double(weight) ?? 0, newPersonalityTraits: details)
        }else {
            ChickenController.sharedInstance.createChicken(name: name, birthDate: birthDatePicker.date, weight: Double(weight) ?? 0.0, personalityTraits: details)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
