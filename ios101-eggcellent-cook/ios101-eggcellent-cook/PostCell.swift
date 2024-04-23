//
//  PostCell.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/16/24.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
//    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
//        // Set the button's isSelected state to the opposite of it's current value.
//        sender.isSelected = !sender.isSelected
//        
//        if sender.isSelected {
//            post.addToFavorites()
//        } else {
//            post.removeFromFavorites()
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
