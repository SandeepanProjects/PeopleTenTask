//
//  UserViewModel.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import Foundation
import UIKit

class UserViewModel{
    //static let sharedInstance = UserViewModel()
   // weak var vc: ViewController?
    
    func fetchPhotoDetails(completionhandler:(( _ eventsdata:Base)->Void)?){
                let request = URLRequest(url: DataSource.url)
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let task = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            
//            let alertController = UIAlertController(title: Strings.oops.rawValue,
//                                                    message: Strings.fetchError.rawValue,
//                                                    preferredStyle: .alert)
//            let okAction = UIAlertAction(title: Strings.ok.rawValue, style: .default)
//            alertController.addAction(okAction)
            
            if let data = data {
                
                do {
                    
                    let userResponse = try JSONDecoder().decode(Base.self, from: data)
                   // var     percentageList = userResponse.map { item.percentage }

                    completionhandler?(userResponse)
                    
//                    self.photos.append(userResponse)
//                    DispatchQueue.main.async{
//                        self.vc?.lunchCollectionView.reloadData()
//                    }
//                    let datasourceDictionary =
//                        try PropertyListSerialization.propertyList(from: data,
//                                                                   options: [],
//                                                                   format: nil) as! [String: String]
//
//                    for (name, value) in datasourceDictionary {
//                        let url = URL(string: value)
//                        if let url = url {
//                            let photoRecord = PhotoRecord(name: name, url: url)
//                            self.photos.append(photoRecord)
//                        }
//                    }
                    
                   // DispatchQueue.main.async {
                        
//                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                        self.vc?.lunchCollectionView.reloadData()                    }
                } catch {
//                    DispatchQueue.main.async {
//                        self.present(alertController, animated: true, completion: nil)
//                    }
                }
            }
            
            if error != nil {
//                DispatchQueue.main.async {
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    self.present(alertController, animated: true, completion: nil)
//                }
            }
        }
        task.resume()
    }
    
}
