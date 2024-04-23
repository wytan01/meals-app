//
//  DetailViewController.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/16/24.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    var post: Post!
    
    @IBAction func didTapCompleteButton(_ sender: UIButton) {
        // Set the button's isSelected state to the opposite of it's current value.
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            post.addToCompleted()
        } else {
            post.removeFromCompleted()
        }
    }
    
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        // Set the button's isSelected state to the opposite of it's current value.
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            post.addToFavorites()
        } else {
            post.removeFromFavorites()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the button's corner radius to be 1/2  it's width. This will make a square button round.
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        
        let favorites = Post.get(forKey: "Favorites")

        if favorites.contains(post) {
            favoriteButton.isSelected = true
        } else { 
            favoriteButton.isSelected = false
        }
        
        completeButton.layer.cornerRadius = completeButton.frame.width / 2
        let completed = Post.get(forKey: "Completed")
        if completed.contains(post) {
            completeButton.isSelected = true
        } else {
            completeButton.isSelected = false
        }

        postCaption.text = post.caption.trimHTMLTags()
        
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: postImage)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
