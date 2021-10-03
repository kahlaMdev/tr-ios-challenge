//
//  RecommendedCollectionViewCell.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recommendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        
    }
    
}
