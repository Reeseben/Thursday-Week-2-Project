//
//  GameCollectionViewController.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import UIKit


class GameCollectionViewController: UICollectionViewController {

    //MARK: - Properties
    
    var correctChicken: Chicken?
    var gameChickens: [Chicken] = []
    var category: String?
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCards()
        updateViews()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameChickens.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell else {return UICollectionViewCell()}
        
        switch category {
        case "traits":
            cell.setText("\(gameChickens[indexPath.row].personalityTraits)")
        case "weights":
            cell.setText("\(gameChickens[indexPath.row].weight)")
        case "birthDay":
            let formatter = DateFormatter()
            formatter.dateFormat =  "MMMM/d/yyyy"
            cell.setText(formatter.string(from: gameChickens[indexPath.row].birthDate))
        default:
            cell.setText("\(gameChickens[indexPath.row].weight)")
        }
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: call alert correct or wrong item func.
        presentAlert(isCorrect: gameChickens[indexPath.row] == correctChicken)
    }

    
    //MARK: - Functions
    
    func shuffleCards(){
        gameChickens = Array(ChickenController.sharedInstance.Chickens.shuffled().prefix(4))
        correctChicken = gameChickens[0]
        gameChickens = gameChickens.shuffled()
    }
    
    func updateViews(){
        guard let correctChicken = correctChicken else {return}
        switch category {
        case "traits":
            let title = "Traits for: \(correctChicken.name)"
            self.title = title
            collectionView.reloadData()
        case "weights":
            let title = "Weight of: \(correctChicken.name)"
            self.title = title
            collectionView.reloadData()
        case "birthDay":
            let title = "Birthday of: \(correctChicken.name)"
            self.title = title
            collectionView.reloadData()
        default:
            let title = "Weight of: \(correctChicken.name)"
            self.title = title
            collectionView.reloadData()
        }
    }
    func presentAlert(isCorrect: Bool){
        let wrongMessages = [
            "Well you tried.",
            "Not Quite",
            "I would have guessed that one too.",
            "Wrong.",
            "This is rigged.",
            "I'm just as mad as you are.",
            "Its about the journey not the destination",
            "Stupid game anyways"
        ]
        let rightMessages = [
            "You did it!",
            "Congradulations!",
            "You're the best",
            "Nice",
            "Great Job!",
            "Its kind of sad that like me your only positive reinforcement comes from apps.",
            "Woot Woot!",
            "Noice"
        ]
        let buttonPositive = [
            "Yay!",
            "Woot Woot!",
            "Okay!",
            "I did it!",
            "I am the champion",
        ]
        let buttonNegative = [
            "Shoot!",
            "crap.",
            "oh poo",
            "darnit",
            "ok :(",
        ]
        
        let title: String
        let buttonText: String
        
        if isCorrect {
            title = rightMessages.randomElement() ?? "Good job!"
            buttonText = buttonPositive.randomElement() ?? "Okay"
        } else{
            title = wrongMessages.randomElement() ?? "Well Crap."
            buttonText = buttonNegative.randomElement() ?? "Okay"
        }
        
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: buttonText, style: .default) { _ in
            self.shuffleCards()
            self.updateViews()
        }
        alert.addAction(okay)
        present(alert, animated: true)
        
    }
    
    
    
}




//MARK: - Collection View Flow and Delegate Methods
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.45
        
        return CGSize(width: width, height: width * 4 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let width = view.frame.width * 0.45
        
        let cellTotalWidth = width * 2
        
        let leftoverWidth = view.frame.width - cellTotalWidth
        
        let inset = leftoverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
    
}

extension GameCollectionViewController: FilterViewControllerDelegate {
    func updateCategory(newCategory: String) {
        category = newCategory
        shuffleCards()
        updateViews()
    }
    
    
}

extension GameCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? FilterViewController
        destination?.delegate = self
    }
}
