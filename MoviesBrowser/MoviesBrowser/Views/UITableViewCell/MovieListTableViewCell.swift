//
//  MovieListTableViewCell.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnailImageView.layer.borderWidth = 0.0
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width / 2.0
        thumbnailImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
