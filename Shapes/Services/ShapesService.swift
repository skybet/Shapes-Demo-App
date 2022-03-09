//
//  ShapesService.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import Foundation

class ShapesService {
    
    private(set) var allShapes: [Shape]!
    
    init() {
        loadShapes()
    }
    
    private func loadShapes() {
        
        let circle   = Shape(id: UUID(uuidString: "3A2E347E-C37D-4817-8758-45CC2E3344A4")!, dimensionRatio: .equal, numberOfEdges: 1)
        let circle2  = Shape(id: UUID(uuidString: "2D31279A-8070-46DD-8CBB-CD08EDBA10A3")!, dimensionRatio: .notEqual, numberOfEdges: 1)
        let triangle = Shape(id: UUID(uuidString: "AFE47D2C-E19E-4471-B617-4C1D7AB60B3A")!, dimensionRatio: .equal, numberOfEdges: 3)
        let four     = Shape(id: UUID(uuidString: "FD123305-530A-4B08-971A-1F79341FC166")!, dimensionRatio: .equal, numberOfEdges: 4)
        let five     = Shape(id: UUID(uuidString: "068CEBB0-2ED4-46F8-BBF6-0E03265B9E85")!, dimensionRatio: .equal, numberOfEdges: 5)
        let six      = Shape(id: UUID(uuidString: "895830DB-0399-464B-AA33-AEA1E6F5F1A2")!, dimensionRatio: .equal, numberOfEdges: 6)
        let seven    = Shape(id: UUID(uuidString: "ACCAD46B-1580-4661-83EF-63E39C8ED84A")!, dimensionRatio: .equal, numberOfEdges: 7)
        let eight    = Shape(id: UUID(uuidString: "CB37EC5E-A017-4727-BEC3-F1A1FFDBF6CC")!, dimensionRatio: .equal, numberOfEdges: 8)
        let nine     = Shape(id: UUID(uuidString: "668F6F2F-F720-47CF-A116-C28E0E219D21")!, dimensionRatio: .equal, numberOfEdges: 9)

        allShapes = [circle, triangle, four, five, six, seven, eight, nine, circle2]
    }
}
