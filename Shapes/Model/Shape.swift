//
//  Shape.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import Foundation

struct Shape: Identifiable {

    enum DimensionRatio {
        case equal
        case notEqual
    }
    
    let id: UUID
    let dimensionRatio: DimensionRatio
    let numberOfEdges: Int
    
    var name: String {
        switch numberOfEdges {
        case 1:
            return dimensionRatio == .equal ? "Circle" : "Oval"
        case 3:
            return "Triangle"
        case 4:
            return "Square"
        case 5:
            return "Pentagon"
        case 6:
            return "Hexagon"
        case 7:
            return "Heptagon"
        case 8:
            return "Octagon"
        case 9:
            return "Nonagon"
        default:
            return "Unknown Shape Name"
        }
    }
}

extension Shape: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
