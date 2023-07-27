//
//  MapLocation.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/27.
//

import Foundation
import CoreLocation

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
