//
//  DetailViewController.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/16/24.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
