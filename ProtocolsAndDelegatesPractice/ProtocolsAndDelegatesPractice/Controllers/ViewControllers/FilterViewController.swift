//
//  FilterViewController.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func updateCategory(newCategory: String)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func traitsButtonPressed(_ sender: Any) {
        delegate?.updateCategory(newCategory: "traits")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func birthDayButtonPressed(_ sender: Any) {
        delegate?.updateCategory(newCategory: "birthDay")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func weightsButtonPressed(_ sender: Any) {
        delegate?.updateCategory(newCategory: "weights")
        dismiss(animated: true, completion: nil)
    }
    

}
