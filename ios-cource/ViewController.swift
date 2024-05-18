//
//  ViewController.swift
//  ios-cource
//
//  Created by v.khabarov on 17.05.2024.
//

import UIKit

class ViewController: UIViewController {

    let cardView = CourseCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            cardView.heightAnchor.constraint(equalToConstant: 230.0)
        ])
        
        cardView.configure(from: CourseCardView.ViewModel(
            cover: TestData.CourseCardModel.cover,
            title: TestData.CourseCardModel.title,
            subtitle: TestData.CourseCardModel.subtitle,
            actionButtonTitle: TestData.CourseCardModel.actionButtonTitle,
            actionButtonHandler: { print("actionButtonTapped")},
            favouriteButtonHandler: { print("favouriteButtonTapped")}
        ))
    }
}
