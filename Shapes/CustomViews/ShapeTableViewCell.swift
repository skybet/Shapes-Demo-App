//
//  ShapeTableViewCell.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

class ShapeTableViewCell: UITableViewCell {

    static let identifier = "ShapeTableViewCell"
    
    private var shape: Shape?
    private var shapeView: ShapeView!
    private var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShapeView()
        setupTitleLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShapeView() {
        shapeView = ShapeView(frame: .zero)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shapeView)
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 26.0)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shapeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            shapeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            shapeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            shapeView.widthAnchor.constraint(equalToConstant: 64.0),
            shapeView.heightAnchor.constraint(equalToConstant: 64.0),
            
            titleLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: shapeView.trailingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
    }
    
    func configure(withShape shape: Shape) {
        self.shape = shape
        
        titleLabel.text = shape.name
        shapeView.configure(withShape: shape)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
