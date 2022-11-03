//
//  LunchCell.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit

protocol ReloadCollectionDelegate: AnyObject {
    func reloadCollection(at indexPath:IndexPath)
}

class LunchCell: UICollectionViewCell {
    
    @IBOutlet weak var luncImage: UIImageView!
    @IBOutlet weak var restrauntName: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var cache:NSCache<AnyObject, AnyObject>!

    private let pendingOperations = PendingOperations()
    public weak var reloadDelegate: ReloadCollectionDelegate?
    
    private func startOperations(for photoRecord: Restaurants, at indexPath: IndexPath) {
           switch (photoRecord.state) {
           case .new:
               startDownload(for: photoRecord, at: indexPath)
           case .downloaded:
               startFiltration(for: photoRecord, at: indexPath)
           default:
               NSLog("do nothing")
           }
       }
    
    private func startDownload(for photoRecord: Restaurants, at indexPath: IndexPath) {
           
           guard pendingOperations.downloadsInProgress[indexPath] == nil else {
               return
           }
//           self.cache = NSCache()
//        
//        if (self.cache.object(forKey: (indexPath as NSIndexPath).item as AnyObject) != nil){
//
//        }
           let downloader = ImageDownloader(photoRecord)
           
           downloader.completionBlock = {
               if downloader.isCancelled {
                   return
               }
               
               DispatchQueue.main.async {
                   self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                   self.reloadDelegate?.reloadCollection(at: indexPath)//(at: indexPath)
               }
           }
           
           pendingOperations.downloadsInProgress[indexPath] = downloader
           pendingOperations.downloadQueue.addOperation(downloader)
       }
       
       private func startFiltration(for photoRecord: Restaurants, at indexPath: IndexPath) {
              guard pendingOperations.filtrationsInProgress[indexPath] == nil else {
                  return
              }
              
              let filterer = ImageFilteration(photoRecord)
              filterer.completionBlock = {
                  if filterer.isCancelled {
                      return
                  }
                  
                  DispatchQueue.main.async {
                      self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                      self.reloadDelegate?.reloadCollection(at: indexPath)//(at: indexPath)
                  }
              }
              
              pendingOperations.filtrationsInProgress[indexPath] = filterer
              pendingOperations.filtrationQueue.addOperation(filterer)
              
          }
    
    public func fillCellBy(photoRecord: Restaurants, indexPath: IndexPath) {
        
        restrauntName.text = photoRecord.name
        categoryLabel.text = photoRecord.category
        luncImage.image = photoRecord.image
        
        switch (photoRecord.state) {
        case .filtered:
            indicator.stopAnimating()
            indicator.isHidden = true
        case .failed:
            indicator.stopAnimating()
            restrauntName.text = Strings.failedToLoad.rawValue
            categoryLabel.text = Strings.failedToLoad.rawValue
        case .new, .downloaded:
            indicator.startAnimating()
            startOperations(for: photoRecord, at: indexPath)
        }
    }
}
