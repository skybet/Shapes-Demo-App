//
//  ShapeView.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

class ShapeView: UIView {

    private var shape: Shape?
    private var shapeLayer: CAShapeLayer?

    var fillColor: UIColor = .systemRed {
        didSet {
            guard let shapeLayer = shapeLayer else { return }
            shapeLayer.fillColor = fillColor.cgColor
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    func configure(withShape shape: Shape) {
        self.shape = shape
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        shapeLayer?.removeFromSuperlayer()
        guard let shape = shape else { return }
        
        let shapeLayer = CAShapeLayer()
        let shapeRect = shape.dimensionRatio == .equal ? rect : rect.insetBy(dx: 0.0, dy: rect.height * 0.1)
        let shapeBounds = CGRect(origin: .zero, size: shapeRect.size)
       
        if shape.numberOfEdges == 1 {
            shapeLayer.path = UIBezierPath(ovalIn: shapeBounds).cgPath
        } else {
            let bezierPath = UIBezierPath.init(roundedRegularPolygon: shapeBounds, numberOfSides: shape.numberOfEdges, cornerRadius: 2.0)
            bezierPath.applyRotation(45.0)
            shapeLayer.path = bezierPath.cgPath
        }
        
        shapeLayer.frame = shapeBounds
        shapeLayer.position = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        self.shapeLayer = shapeLayer
        layer.addSublayer(shapeLayer)
    }
}
