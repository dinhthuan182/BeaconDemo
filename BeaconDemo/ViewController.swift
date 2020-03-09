//
//  ViewController.swift
//  BeaconDemo
//
//  Created by Vu Dinh Thuan on 3/6/20.
//  Copyright © 2020 Vu Dinh Thuan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "D546DF97-4757-47EF-BE09-3E2DCBDD0C77")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: "hhhh")

        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: uuid))
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if beacons.count > 0 {
            
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                print("mau xam")
                self.view.backgroundColor = UIColor.gray

            case .far:
                print("mau xanh")
                self.view.backgroundColor = UIColor.blue

            case .near:
                print("mau cam")
                self.view.backgroundColor = UIColor.orange

            case .immediate:
                print("mau do")
                self.view.backgroundColor = UIColor.red
            }
        }
    }
    
}


