//
//  ViewController.swift
//  ios101-eggcellent-cook
//
//  Created by Weiyi Tan on 4/16/24.
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        fetchPosts()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: Get favorite movies and display in table view
//        let posts = Post.get(forKey: "Favorites")
//        // 2.
//        self.posts = posts
//        // 3.
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = posts[indexPath.row]
        let favorites = Post.get(forKey: "Favorites")
        cell.favoriteButton.layer.cornerRadius = cell.favoriteButton.frame.width / 2

        if favorites.contains(post) {
            cell.favoriteButton.isSelected = true
        } else {
            cell.favoriteButton.isSelected = false
        }

        cell.summaryLabel.text = post.summary

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
        let selectedPost = posts[selectedIndexPath.row]

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.post = selectedPost
    }

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/mysecretrecipebook/posts/photo?offset=4&limit=30&api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts
                    self?.posts = posts
                    self?.tableView.reloadData()

                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }


}

