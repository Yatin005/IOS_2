//
//  LocationHelper.swift
//  Lab_7
//
//  Created byyatin PArulkaron on 2025-08-01.
//
import Foundation
import CoreLocation
import Contacts

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let geoCoder = CLGeocoder()
    
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        self.checkPermission()
        if (CLLocationManager.locationServicesEnabled() && (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)) {
            self.locationManager.startUpdatingLocation()
        } else {
            self.requestPermission()
        }
    }
    
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission() {
        switch self.locationManager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            self.requestPermission()
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            self.currentLocation = locations.last!
        } else {
            self.currentLocation = locations.first
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while trying to get location updates: \(error)")
    }
    
    func doForwardGeocoding(address: String, completionHandler: @escaping (CLLocation?, NSError?) -> Void) {
        self.geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if (error != nil) {
                print("Unable to obtain location coordinates for given address string - \(error!)")
                completionHandler(nil, error as NSError?)
            } else {
                if let place = placemarks?.first {
                    let matchedLocation = place.location!
                    completionHandler(matchedLocation, nil)
                } else {
                    completionHandler(nil, error as NSError?)
                }
            }
        })
    }
    
    // Add this new function for Reverse Geocoding
    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping (String?, NSError?) -> Void) {
        self.geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if (error != nil) {
                print("Unable to obtain street address for given coordinates - \(error!)")
                completionHandler(nil, error as NSError?)
            } else {
                if let placemarkList = placemarks, let firstPlace = placemarkList.first {
                    let address = CNPostalAddressFormatter.string(from: firstPlace.postalAddress!, style: .mailingAddress)
                    completionHandler(address, nil)
                } else {
                    completionHandler(nil, error as NSError?)
                }
            }
        })
    }
    
    deinit {
        self.locationManager.stopUpdatingLocation()
    }
}
