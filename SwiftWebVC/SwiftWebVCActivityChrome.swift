//
//  SwiftWebVCActivityChrome.swift
//
//  Created by Myles Ringle on 24/06/2015.
//  Transcribed from code used in SVWebViewController.
//  Copyright (c) 2015 Myles Ringle & Sam Vermette. All rights reserved.
//

import UIKit

class SwiftWebVCActivityChrome : SwiftWebVCActivity {

    override var activityTitle : String {
        return NSLocalizedString("Open in Chrome", tableName: "SwiftWebVC", comment: "")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for activityItem in activityItems {
            if activityItem is URL, UIApplication.shared.canOpenURL(URL(string: "googlechrome://")!) {
                return true;
            }
        }
        return false;
    }
    
    override func perform() {
        guard let inputURL = URLToOpen, let scheme = inputURL.scheme else {
            return
        }
        
        // Replace the URL Scheme with the Chrome equivalent.
        let chromeScheme: String;
        if scheme == "http" {
            chromeScheme = "googlechrome"
        }
        else if scheme == "https" {
            chromeScheme = "googlechromes"
        }
        else {
            chromeScheme = ""
        }
        
        // Proceed only if a valid Google Chrome URI Scheme is available.
        if !chromeScheme.isEmpty, let urlNoScheme = (inputURL as NSURL).resourceSpecifier, let chromeURL = URL(string: "\(chromeScheme):\(urlNoScheme)") {
            
            // Open the URL with Chrome.
            UIApplication.shared.openURL(chromeURL)
        }
    }
}
