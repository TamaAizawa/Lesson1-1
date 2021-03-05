//
//  ViewController.swift
//  Lesson1
//
//  Created by Takashi Aizawa on 2021/03/01.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 位置情報を取得する準備
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // デフォルトでの位置を取り敢えず設定
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.331741, -122.030333)
        mapView.setCenter(location ,animated:true)
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
         
        mapView.setRegion(region,animated:true)
        mapView.mapType = MKMapType.standard
    }

    // 位置関連ステータスのデリゲート関数
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print("authorized")
        case .notDetermined, .denied, .restricted:
           print("disabled")
        default:
            print("Others")
        }
    }

    //　位置の変更通知を受けるデリゲート関数
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        let currentLocation = CLLocationCoordinate2DMake(latitude!, longitude!)
        mapView.setCenter(currentLocation ,animated:true)
        locationManager.stopUpdatingLocation()
    }

}

