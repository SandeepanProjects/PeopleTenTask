//
//  DetailViewController.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 14/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit
import MapKit

struct Post {
    var restrauntNameForDetails:String?
    var categoryTypeForDetails:String?
}

var heightForHeader : CGFloat = 60

final class PlaceAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D, subtitle: String?, title: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region:MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class DetailViewController: UIViewController {

    @IBOutlet weak var restrauntMap: MKMapView!
    @IBOutlet weak var tableviewDetails: UITableView!
    
    var dictFromViewController:Restaurants?// = Dictionary<String, Any>()
    var arrayOfPosts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        arrayOfPosts = [Post.init(restrauntNameForDetails:dictFromViewController?.name, categoryTypeForDetails:dictFromViewController?.category)]
        
        setUpNavBar()
        SetBackBarButtonCustom()
        
        tableviewDetails.estimatedRowHeight = 130
        tableviewDetails.rowHeight = UITableView.automaticDimension
        tableviewDetails.tableFooterView = UIView()
        
        tableviewDetails.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpCoordinates()
     
    }
    
    func setUpNavBar(){
        self.navigationController?.navigationBar
            .barTintColor = UIColor(red: 67.0/255.0, green: 232.0/255.0, blue: 149.0/255.0, alpha: 1.0)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.title = Strings.LunchTitle.rawValue
    }
    
    func setUpCoordinates(){
        restrauntMap.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let coordinate = CLLocationCoordinate2D(latitude: (dictFromViewController?.location?.lat) as! CLLocationDegrees, longitude: dictFromViewController?.location?.lng as! CLLocationDegrees)
        let annotation = PlaceAnnotation(coordinate: coordinate, subtitle: dictFromViewController?.category, title: dictFromViewController?.name)
               restrauntMap.addAnnotation(annotation)
               restrauntMap.setRegion(annotation.region, animated: true)
    }
    
    func SetBackBarButtonCustom()
    {
        let image = UIImage(named: "backward")!.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backClicked(_ :) ))
    }
    
    @objc func backClicked(_ sender: UIBarButtonItem){
        //self.dismiss(animated: true, completion: nil);
        self.navigationController?.popViewController(animated: true)

    }
   
}

extension DetailViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfPosts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.DetailCell.rawValue, for: indexPath) as! DetailCell
        
        cell.addressLbl.text = dictFromViewController?.location?.address
        cell.formattedPhoneLbl.text = dictFromViewController?.contact?.formattedPhone
        cell.twitterLbl.text = dictFromViewController?.contact?.twitter
        return cell
    }
    
}


extension DetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = Bundle.main.loadNibNamed(Strings.HeaderViewForDetails.rawValue, owner: self, options: nil)?.first as? HeaderViewForDetails
        headerView?.categoryType.text = arrayOfPosts[section].categoryTypeForDetails
        headerView?.restrauntName.text = arrayOfPosts[section].restrauntNameForDetails
        return headerView
       }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

extension DetailViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let placeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView{
            placeAnnotationView.animatesWhenAdded = true
            placeAnnotationView.titleVisibility = .adaptive
            
            return placeAnnotationView
        }
        return nil
    }
}
