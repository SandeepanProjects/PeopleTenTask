//
//  ViewController.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var lunchCollectionView: UICollectionView!
    
    var viewModelUser = UserViewModel()
    var photos:[Base] = []
    var arrData:[Restaurants] = []
    var cache:NSCache<AnyObject, AnyObject>!

    private let pendingOperations = PendingOperations()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModelUser.fetchPhotoDetails() { [weak self] (eventsData) in
            self?.photos.append(eventsData)
            self?.arrData = eventsData.restaurants ?? []
            self?.cache = NSCache()

           // print(self?.photos)
                   DispatchQueue.main.async {
                    self?.lunchCollectionView.reloadData()
                   }
               }
        }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           setupNavBar()
       }
    
    
    func setupNavBar() {
              self.navigationController?.navigationBar
                  .barTintColor = UIColor(red: 67.0/255.0, green: 232.0/255.0, blue: 149.0/255.0, alpha: 1.0)

              self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

              self.title = Strings.LunchTitle.rawValue
          }
}


extension ViewController:UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let collectionWidth = self.view.frame.width
        return CGSize(width: collectionView.bounds.width, height: 180)
    }
}

extension ViewController:UICollectionViewDataSource{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrData.count
 }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell : LunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.lunchCell.rawValue, for: indexPath) as! LunchCell
    
    cell.fillCellBy(photoRecord: arrData[indexPath.item],indexPath: indexPath)
    cell.reloadDelegate = self
    return cell
 }
}

//MARK: select item for display

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: Strings.DetailViewController.rawValue) as? DetailViewController
        
        vc?.dictFromViewController = arrData[indexPath.item]  //emptyDictionary
        self.navigationController?.pushViewController (vc!, animated: true)

        
    }
}

// MARK: Reload collectionview Delegate

extension ViewController: ReloadCollectionDelegate {
    func reloadCollection(at indexPath: IndexPath) {
        lunchCollectionView.reloadItems(at: [indexPath])
    }
}


