//
//  LocationManager.swift
//  ZeemDriver
//
//  Created by Narendra Kumar on 09/04/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
  
    private var locationManager: CLLocationManager?

    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.requestWhenInUseAuthorization()
        } else {
            print("Location services are not enabled.")
        }
    }

    func startLocationUpdates() {
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are not enabled.")
            return
        }
        
        locationManager?.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        print("Latitude: \(lat), Longitude: \(long)")
        
        // Saving the coordinates to UserDefaults
        UserDefaults.standard.setValue(lat, forKey: "lat")
        UserDefaults.standard.setValue(long, forKey: "long")
        
        // Reverse geocode to get the full address, city, country name, and country code
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let street = placemark.thoroughfare ?? "Unknown street"
                let city = placemark.locality ?? "Unknown city"
                let state = placemark.administrativeArea ?? "Unknown state"
                let country = placemark.country ?? "Unknown country"
                let postalCode = placemark.postalCode ?? "Unknown postal code"
                
                // Constructing the full address
                let fullAddress = "\(street), \(city), \(state) \(postalCode), \(country)"
                UserDefaults.standard.setValue(fullAddress, forKey: "fullAddress")
                
                // Print the full address
                print("Full Address: \(fullAddress)")
            } else {
                print("Can't fetch location")
            }
        }
    }

    // Delegate method called when authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location services are denied or restricted.")
        case .notDetermined:
            print("Location authorization not determined.")
        @unknown default:
            break
        }
    }
}
