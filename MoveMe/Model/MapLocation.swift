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

let MapLocations = [
    MapLocation(
        name: "목적지",
        latitude: Double(Constant.latitude) ?? 0,
        longitude: Double(Constant.longitude) ?? 0)
]
