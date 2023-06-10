//
//  JokeTableViewCell.swift
//  JokeMania
//
//  Created by Abdul Rahman Khan on 10/06/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    static let reuseIdentifier = "JokeTableViewCell"
    
    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 205/255, alpha: 1.0) // Light and warm color
        
        // Add a rounded background view to the cell's content view
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundView)
        
        // Configure auto layout constraints for the background view
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Add the joke label to the background view
        backgroundView.addSubview(jokeLabel)
        
        // Configure auto layout constraints for the joke label
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 12),
            jokeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            jokeLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            jokeLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -12)
        ])
    }
    
    private func randomColor() -> UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func configure(with joke: String) {
        jokeLabel.text = joke
    }
}

class Header: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "😄 JokeMania 😄"
        return label
    }()
    
    private let bellButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var bellButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 234/255, green: 87/255, blue: 101/255, alpha: 1.0)
        addSubview(titleLabel)
        addSubview(bellButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            bellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bellButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            bellButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        bellButton.addTarget(self, action: #selector(bellButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBellIcon(_ color: UIColor,_ animate: Bool) {
        bellButton.tintColor = color
        // Add animation to the bell icon
        if animate {
            UIView.animate(withDuration: 0.2, animations: {
                self.bellButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.bellButton.transform = .identity
                }
            }
        }
    }
    
    @objc private func bellButtonTapped(_ sender: UIButton) {
        bellButtonTapped?()
    }
}

