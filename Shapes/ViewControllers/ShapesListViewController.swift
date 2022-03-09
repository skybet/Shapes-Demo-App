//
//  ShapesListViewController.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

enum Section {
    case shapes
}

typealias DiffableDatasource = UITableViewDiffableDataSource<Section, Shape>
typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<Section, Shape>

class ShapesListViewController: UIViewController {

    var shapesService: ShapesService!
    private var _shapes: [Shape] = []
    private var filteredShapes: [Shape] = []
    
    private var tableView: UITableView!
    private var datasource: DiffableDatasource!
    private var toolbar: UIToolbar!
    private var circlesOnlyBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(shapesService != nil, "shapesService cannot be nil")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavigationItems()
        setupTableView()
        setupDatasource()
        setupToolbar()
        setupConstraints()
        
        _shapes = shapesService.allShapes
        filteredShapes = _shapes
        updateShapesList(filteredShapes, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Shapes"
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShapeTableViewCell.self, forCellReuseIdentifier: ShapeTableViewCell.identifier)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        view.addSubview(tableView)
    }
    
    private func setupDatasource() {
        datasource = DiffableDatasource(tableView: tableView, cellProvider: { tableView, indexPath, shape in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShapeTableViewCell.identifier, for: indexPath) as? ShapeTableViewCell else {
                fatalError("Unable to dequeue ShapeTableViewCell")
            }
            
            cell.configure(withShape: shape)
            cell.accessoryType = .disclosureIndicator
            
            return cell
        })
    }
    
    private func setupToolbar() {
        toolbar = UIToolbar(frame: .zero)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        let toolbarSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        circlesOnlyBarButtonItem = UIBarButtonItem(title: "Circles", style: .plain, target: self, action: #selector(filterButtonTapped(_:)))
        toolbar.setItems([toolbarSpacer, circlesOnlyBarButtonItem], animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func updateShapesList(_ shapes: [Shape], animated: Bool = true) {
        var snapshot = DiffableSnapshot()
        snapshot.appendSections([.shapes])
        snapshot.appendItems(filteredShapes, toSection: .shapes)
        
        datasource.apply(snapshot, animatingDifferences: animated)
    }
    
    @objc private func filterButtonTapped(_ sender: UIBarButtonItem) {
        sender.isSelected = !sender.isSelected
        
        filteredShapes = sender.isSelected == false ? _shapes : _shapes.filter({ $0.numberOfEdges == 1 })
        updateShapesList(filteredShapes)
    }
}

extension ShapesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let shapeViewController = ShapeViewController()
        shapeViewController.shape = filteredShapes[indexPath.row]
        navigationController?.pushViewController(shapeViewController, animated: true)
    }
}

