//
//  GameCollectionViewCell.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textView: UITextView!
    

func setText(_ text: String){
    textView.text = text
}
}
