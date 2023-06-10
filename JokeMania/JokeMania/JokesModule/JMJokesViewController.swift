//
//  JMJokesViewController.swift
//  JokeMania
//
//  Created by Abdul Rahman Khan on 10/06/23.
//

import UIKit

class JMJokesViewController: UIViewController {
    private let headerView = Header()
    private let tableView = UITableView()
    private let viewModel = JMJokesViewModel()
    private var shouldScrollToNewJoke = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        fetchJokes()
    }

    private func setupUI() {
        
        headerView.bellButtonTapped = { [weak self] in
            self?.handleBellButtonTapped()
        }
        view.addSubview(headerView)
        
        // Add the table view
        setupTableView()
        
        // Configure auto layout constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: JokeTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func handleBellButtonTapped() {
        headerView.updateBellIcon(.white, false)
        if shouldScrollToNewJoke, !viewModel.jokes.isEmpty {
            let indexPath = IndexPath(row: viewModel.jokes.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    private func setupViewModel() {
        viewModel.updateUI = { [weak self] in
            self?.updateUI()
        }
    }

    private func fetchJokes() {
        viewModel.fetchJokes()
    }

    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            if !self.viewModel.jokes.isEmpty {
                self.shouldScrollToNewJoke = true
                self.headerView.updateBellIcon(.blue, true)
            }
        }
    }
}

extension JMJokesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeTableViewCell.reuseIdentifier, for: indexPath) as! JokeTableViewCell
        let joke = viewModel.jokes[indexPath.row]
        cell.configure(with: joke)
        
        //
        // Add animation to the new joke cell
        if shouldScrollToNewJoke && indexPath.row == viewModel.jokes.count - 1 {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5) {
                cell.transform = .identity
            }
            
            shouldScrollToNewJoke = false
        }
        return cell
    }
}

extension JMJokesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
