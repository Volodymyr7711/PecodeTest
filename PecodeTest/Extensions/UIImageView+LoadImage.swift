//
//  UIImageView+LoadImage.swift
//  PecodeTest
//
//  Created by Volodymyr Mendyk on 12.04.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(url: URL) -> URLSessionDownloadTask {
        
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url) { (url, response, error) in
            
            if let error = error {
                print("ERROR Loading image: \(error.localizedDescription)")
                return
            }
            
            if let url = url, let data = try? Data(contentsOf: url), let imageDownloaded = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.image = imageDownloaded
                }
            
            }
            
        }
        
        downloadTask.resume()
        return downloadTask
    }
}
