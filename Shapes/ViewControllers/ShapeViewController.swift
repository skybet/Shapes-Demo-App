//
//  ShapeViewController.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

class ShapeViewController: UIViewController {
    
    var shape: Shape!
    
    private var closeButton: UIButton!
    private var titleLabel: UILabel!
    private var shapeView: ShapeView!
    private var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(shape != nil, "shape cannot be nil")
        
        view.backgroundColor = .systemBackground
        
        setupCloseButton()
        setupTitleLabel()
        setupShapeView()
        setupToolbar()
        setupConstraints()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupCloseButton() {
        closeButton = UIButton(frame: .zero)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        let buttonImageConfig = UIImage.SymbolConfiguration(pointSize: 24.0, weight: .regular, scale: .default)
        closeButton.setImage(UIImage(systemName: "chevron.backward", withConfiguration: buttonImageConfig), for: .normal)
        closeButton.setTitle(nil, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        closeButton.tintColor = .systemGray
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 50.0)
        view.addSubview(titleLabel)
    }
    
    private func setupToolbar() {
        toolbar = UIToolbar(frame: .zero)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        let slider = UISlider(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width * 0.8, height: 35.0)))
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 1.0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        let sliderBarButtonItem = UIBarButtonItem(customView: slider)
        toolbar.setItems([sliderBarButtonItem], animated: true)
        toolbar.backgroundColor = .systemBackground
    }
    
    private func setupShapeView() {
        shapeView = ShapeView(frame: .zero)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shapeView)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(shapeViewDoubleTapped(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        shapeView.addGestureRecognizer(doubleTapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            closeButton.widthAnchor.constraint(equalToConstant: 44.0),
            closeButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            shapeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 64.0),
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            shapeView.heightAnchor.constraint(equalTo: shapeView.widthAnchor),
            
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureUI() {
        titleLabel.text = shape.name
        shapeView.configure(withShape: shape)
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        shapeView.alpha = CGFloat(sender.value)
    }
    
    @objc private func shapeViewDoubleTapped(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .recognized else { return }
        performShapeAnimation()
    }
    
    private func performShapeAnimation() {
        shapeView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse]) {
            let transform = CGAffineTransform(rotationAngle: degreesToRadians(180)).scaledBy(x: 2.0, y: 2.0)
            self.shapeView.transform = transform
            self.shapeView.fillColor = .random
        } completion: { _ in
            self.shapeView.transform = .identity
            self.shapeView.isUserInteractionEnabled = true
        }
    }
}
