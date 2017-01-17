//
//  ViewController.swift
//  Project7
//
//  Created by Badr BOUAZZI on 1/13/17.
//  Copyright © 2017 Badr BOUAZZI. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [[String : String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.addBorder(side: .bottom, thickness: 0.3, color: UIColor.black)
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://newsapi.org/v1/articles?source=the-verge&sortBy=latest&apiKey=05476739b23846a59a5ec699a2f06b5f"

        } else {
            urlString = "https://newsapi.org/v1/articles?source=the-verge&sortBy=top&apiKey=05476739b23846a59a5ec699a2f06b5f"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["status"].stringValue == "ok" {
                    parse(json: json)
                    return
                }
            }
        }
        
        showError()
    }
    
    func parse (json : JSON){
        
        for article in json["articles"].arrayValue {
            let author = article["author"].stringValue
            let title = article["title"].stringValue
            let body = article["description"].stringValue
            let articleUrl = article["url"].stringValue
            let imgUrl = article["urlToImage"].stringValue
            let date = article["publishedAt"].stringValue
            let obj = ["author": author, "title": title, "body": body, "url": articleUrl, "imgUrl": imgUrl, "publishedAt": date ]
            petitions.append(obj)
        }
        
        tableView.reloadData()
    
    }
    
    //  TableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.updateUI()
        let petition = petitions[indexPath.row]
        cell.articleTitle.text = petition["title"]
        cell.articleDescription.text = petition["body"]
        cell.articleAuthor.text = petition["author"]
        cell.articlePublishedAt.text = getArticleDate(petition["publishedAt"]!)
       
        
        let url = URL(string: petition["imgUrl"]!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.articleImage.image = UIImage(data: data!)!
            }
        }
        return (cell)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        // initial state
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        // Animated state
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func getArticleDate(_ dateString: String)-> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "E MMM dd' at 'HH:mm"
        return dateFormatter.string(from: dateObj!)
    }
    
}

