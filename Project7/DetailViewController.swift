//
//  DetailViewController.swift
//  Project7
//
//  Created by Badr BOUAZZI on 1/14/17.
//  Copyright © 2017 Badr BOUAZZI. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    var webView1 : WKWebView!
    var detailItem : [String : String]!
    
    override func loadView() {
        webView1 = WKWebView()
        view = webView1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard detailItem != nil else { return }
        
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 120%; text-align: justify;} img { width: 300px; display: block; margin: auto;}</style>"
            html += "</head>"
            html += "<body>"
            html += "<img src=\""
            html += detailItem["imgUrl"]!
            html += "\" alt=\"article img\""
            html += "<p>"
            html += body
            html += "</p>"
            html += detailItem["author"]!
            html += "<br />"
            html += "<a href=\""
            html += detailItem["url"]!
            html += "\">"
            html += "Link to article"
            html += "</a>"
            html += "</body>"
            html += "</html>"
            webView1.loadHTMLString(html, baseURL: nil)
        }
    }
    
    

}
