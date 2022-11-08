//
//  InternetsViewController.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit
import WebKit


class InternetsViewController: UIViewController,WKUIDelegate {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let myURL = DataSource.urlForWebview
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.uiDelegate = self
        
    }
    
    func setupUI() {
           self.view.backgroundColor = .white
           self.view.addSubview(webView)
           
           NSLayoutConstraint.activate([
               webView.topAnchor
                   .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
               webView.leftAnchor
                   .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
               webView.bottomAnchor
                   .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
               webView.rightAnchor
                   .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
           ])
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       setupNavBar()
       setUpBarButtons()
        
    }
    
    
    func setUpNavBar(){
        self.navigationController?.navigationBar
            .barTintColor = UIColor(red: 67.0/255.0, green: 232.0/255.0, blue: 149.0/255.0, alpha: 1.0)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    func setUpBarButtons(){
        let forwardBarItem = UIBarButtonItem(image:UIImage(named: "forward"), style: .plain, target: self, action: #selector(onRightLeftClick(_ :) ))
                  
        let backBarItem = UIBarButtonItem(image:UIImage(named: "backward"), style: .plain, target: self, action: #selector(onRightLeftClick(_ :) ))
                          
        let reloadBarItem = UIBarButtonItem(image:  UIImage(named: "reload"), style: .plain, target: self, action: #selector(onRightLeftClick(_ :)))
        
        forwardBarItem.tag = 1
        backBarItem.tag = 2
        reloadBarItem.tag = 3
        
        self.navigationItem.leftBarButtonItems = [backBarItem,reloadBarItem,forwardBarItem]

    }
       
       func setupNavBar() {
           self.navigationController?.navigationBar
               .barTintColor = UIColor(red: 67.0/255.0, green: 232.0/255.0, blue: 149.0/255.0, alpha: 1.0)

           self.navigationController?.navigationBar
               .tintColor = .white
       }
    
    // MARK: - Actions
    
    @objc func onRightLeftClick(_ sender: UIBarButtonItem){
        if sender.tag == 1{
             if webView.canGoForward {
                       webView.goForward()
             }
        }else if sender.tag == 2{
           if webView.canGoBack {
                webView.goBack()
            }
        }
        else if sender.tag == 3{
            if (webView.reload() != nil) {
                webView.reload()
            }
        }
    }
       
    
    // MARK: - Properties
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
        
}

