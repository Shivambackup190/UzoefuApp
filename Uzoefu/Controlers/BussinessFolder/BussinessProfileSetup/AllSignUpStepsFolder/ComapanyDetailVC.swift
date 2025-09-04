import UIKit
import MapKit
import CoreLocation

class ComapanyDetailVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapUiView: UIView!

    private var mapView: MKMapView!
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupLocationManager()
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
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
