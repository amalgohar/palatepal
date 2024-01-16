//
//  GroceryMapViewController.swift
//  PalatePal
//
//  Created by Amal Gohar on 12/3/23.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class GroceryMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    let groceryStoreCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 38.850033, longitude: -77.312957),
        // Coordinate 1
        CLLocationCoordinate2D(latitude: 38.900205, longitude: -77.259052),
        // Coordinate 2
        // Add more coordinates as needed
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true

        showRandomGroceryStore()
    }

    func showRandomGroceryStore() {
        guard let randomCoordinate = groceryStoreCoordinates.randomElement() else { return }

        let region = MKCoordinateRegion(center: randomCoordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = randomCoordinate
        annotation.title = "Grocery Store"
        mapView.addAnnotation(annotation)
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "groceryStoreAnnotation"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
