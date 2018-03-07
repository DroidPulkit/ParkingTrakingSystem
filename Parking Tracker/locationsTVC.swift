//
//  LocationsTVC.swift
//  Parking Tracker
//
//  Created by MacStudent on 2018-03-05.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import MapKit

class locationsTVC: UITableViewController {
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var regionRadius:CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("rows : \(matchingItems.count)")
        return matchingItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        // Configure the cell...
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = selectedItem.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationCenter = matchingItems[indexPath.row].placemark.location
        let locationTitle = matchingItems[indexPath.row].name
        let locationSubTitle = matchingItems[indexPath.row].placemark.title
        print("location : \(String(describing: locationCenter)) \n location Title : \(String(describing: locationTitle)) \n location subtitle : \(String(describing: locationSubTitle))")
        
        centerMapOnLocation(location: locationCenter!, title: locationTitle!, subTitle: locationSubTitle!)
        
    }
    
}

extension locationsTVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        print("Searching for \(String(describing: request.naturalLanguageQuery)) around \(request.region)")
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print("\(response.mapItems)")
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
    }
    
    //center map on specified location
    func centerMapOnLocation(location: CLLocation, title: String, subTitle: String){
        //get the location cordinates
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        
        //focus the map on specified location
        mapView?.setRegion(coordinateRegion, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        myAnnotation.title = title
        myAnnotation.subtitle = subTitle
        //display pin on location
        mapView?.addAnnotation(myAnnotation)
        
        let lotAAnnotation: MKPointAnnotation = MKPointAnnotation()
        lotAAnnotation.coordinate = CLLocationCoordinate2D(latitude:43.7774392, longitude: -79.336438)
        lotAAnnotation.title = "Lot A"
        lotAAnnotation.subtitle = "Parking Lot A"
         mapView?.addAnnotation(lotAAnnotation)
        
        let lotBAnnotation: MKPointAnnotation = MKPointAnnotation()
        lotBAnnotation.coordinate = CLLocationCoordinate2D(latitude:43.773523, longitude: -79.334563)
        lotBAnnotation.title = "Lot B"
        lotBAnnotation.subtitle = "Parking Lot B"
        mapView?.addAnnotation(lotBAnnotation)
        
        let lotCAnnotation: MKPointAnnotation = MKPointAnnotation()
        lotCAnnotation.coordinate = CLLocationCoordinate2D(latitude:43.773223, longitude: -79.331834)
        lotCAnnotation.title = "Lot C"
        lotCAnnotation.subtitle = "Parking Lot C"
        mapView?.addAnnotation(lotCAnnotation)
        
        //437774392, -79336438- A, 43773523, -79334563- B, 43773223, -79331834- C
        
        
    }
}
