//
//  FavoritesViewController.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/22/24.
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    var favoritePosts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Anything in the defer call is guaranteed to happen last
        defer {
            // Show the "Empty Favorites" label if there are no favorite movies
            emptyFavoritesLabel.isHidden = !favoritePosts.isEmpty
        }

        // TODO: Get favorite movies and display in table view
        let posts = Post.get(forKey: "Favorites")
        // 2.
        self.favoritePosts = posts
        // 3.
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = favoritePosts[indexPath.row]
        // all favorited here
        cell.favoriteButton.layer.cornerRadius = cell.favoriteButton.frame.width / 2
        cell.favoriteButton.isSelected = true
        
        cell.summaryLabel.text = post.summary
        cell.titleLabel.text = post.caption.slice(from: "<b>", to: "<")!.trimHTMLTags()
        
        let completes = Post.get(forKey: "Completed")
        cell.completeButton.layer.cornerRadius = cell.completeButton.frame.width / 2

        if completes.contains(post) {
            cell.completeButton.isSelected = true
        } else {
            cell.completeButton.isSelected = false
        }
        
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: cell.postImageView)
        }

        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedPost = favoritePosts[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.post = selectedPost
    }

}
