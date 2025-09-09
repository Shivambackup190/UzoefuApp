import UIKit
import MapKit
import CoreLocation

class ComapanyDetailVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var addressTextfield: FloatingTextField!
    @IBOutlet weak var mapUiView: UIView!

    @IBOutlet weak var dtf: FloatingTextField!
    private var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        dtf.isUserInteractionEnabled = false
        setupMap()
        setupLocationManager()
        addTapGestureOnMap()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupMap() {
        mapView = MKMapView(frame: mapUiView.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapUiView.addSubview(mapView)
        mapView.showsUserLocation = true
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func addTapGestureOnMap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let locationInView = gestureRecognizer.location(in: mapView)
        let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        // Clear previous annotations
        mapView.removeAnnotations(mapView.annotations)
        
        // Add pin on tapped location
        let annotation = MKPointAnnotation()
        annotation.coordinate = tappedCoordinate
        mapView.addAnnotation(annotation)
        
        // Convert lat-long to address
        let location = CLLocation(latitude: tappedCoordinate.latitude, longitude: tappedCoordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first {
                var addressString = ""
                if let name = placemark.name { addressString += name + ", " }
                if let locality = placemark.locality { addressString += locality + ", " }
                if let administrativeArea = placemark.administrativeArea { addressString += administrativeArea + ", " }
                if let country = placemark.country { addressString += country }
                
                DispatchQueue.main.async {
                self.addressTextfield.text = addressString
                }
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            let region = MKCoordinateRegion(
//                center: location.coordinate,
//                latitudinalMeters: 1000,
//                longitudinalMeters: 1000
//            )
//            mapView.setRegion(region, animated: true)
//            locationManager.stopUpdatingLocation()
//        }
//    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
            
            // ✅ yahan se address textfield me dalna
            CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self else { return }
                if let placemark = placemarks?.first {
                    var addressString = ""
                    if let name = placemark.name { addressString += name + ", " }
                    if let locality = placemark.locality { addressString += locality + ", " }
                    if let administrativeArea = placemark.administrativeArea { addressString += administrativeArea + ", " }
                    if let country = placemark.country { addressString += country }
                    
                    DispatchQueue.main.async {
                        self.addressTextfield.text = addressString
                    }
                }
            }
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
