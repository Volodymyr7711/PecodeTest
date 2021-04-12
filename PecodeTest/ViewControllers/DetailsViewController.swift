//
//  DetailsViewController.swift
//  PecodeTest
//
//  Created by Volodymyr Mendyk on 08.04.2021.
//

import UIKit
import WebKit


class DetailsViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var newsURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        super.loadView()
        webView = WKWebView(frame: self.view.frame)
        webView!.uiDelegate = self
        webView!.navigationDelegate = self
        self.view = self.webView
        let url = URL(string: self.newsURL!)
        let request = URLRequest(url: url!)
        self.webView.load(request)
        }
}
