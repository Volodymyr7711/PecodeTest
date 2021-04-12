//
//  NewsTableViewCell.swift
//  PecodeTest
//
//  Created by Volodymyr Mendyk on 08.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsSource: UILabel!

    
    var downloadTask: URLSessionDownloadTask?
    
    func configureCell(for article: Article) {
        newsTitle.text = article.title
        newsDesc.text = article.description
        newsAuthor.text = article.author
        newsSource.text = String(article.source.name)
        if #available(iOS 13.0, *) {
            newsImg.image = UIImage(systemName: "newspaper")
        }
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            downloadTask = newsImg.loadImage(url: url)
        }
    }
}
