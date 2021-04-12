//
//  NewsViewController.swift
//  PecodeTest
//
//  Created by Volodymyr Mendyk on 08.04.2021.
//

import UIKit
import SDWebImage
import Alamofire

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedCountry: UISegmentedControl!
    
    
    var articles = [Article]()
    
    var service = Service()
    var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let cell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "NewsCell")
        performSearch()
        
    }
   
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    @IBAction func segmentedCountry(_ sender: UISegmentedControl) {
        performSearch()
    }
    
    func performSearch() {
       dataTask?.cancel()
        let session  = URLSession.shared
        guard let url = service.newsURL(searchText: searchBar.text!, category: segmentedControl.selectedSegmentIndex, country: segmentedCountry.selectedSegmentIndex) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error as NSError?, error.code == 100 {
                print("REQUEST CANCELED: \(error.localizedDescription)")
                return
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let data = data {
                self.articles = self.service.parse(data: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        dataTask?.resume()
    }
}


extension NewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        cell.configureCell(for: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow
        guard index != nil else { return }
        let selectedArticle = articles[index!.row]
        let detailVC = DetailsViewController()
        detailVC.newsURL = selectedArticle.url
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
