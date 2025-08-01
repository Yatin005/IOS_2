//
//  Extention.swift
//  Lab_7
//
//  Created by Deep Kaleka on 2025-08-01.
//

// Extensions.swift
import Foundation
import MapKit

extension MKPointAnnotation: Identifiable {
    public var id: String {
        return UUID().uuidString
    }
}
