//
//  MyCardViewController.swift
//  Vaccine
//
//  Created by Anderson Alencar on 23/11/20.
//

import UIKit

class MyCardViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)

    lazy var myCardView: MyCardView = {
        let myView = MyCardView()
        return myView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myCardView
        self.navigationItem.title = "Meu Cartão"
        navigationItem.searchController = searchController
        // navigationItem.hidesSearchBarWhenScolling = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
        gradient.locations = [0.0, 1.0]
        gradient.colors = [UIColor.red.withAlphaComponent(0.4).cgColor, UIColor.blue.cgColor]
        self.view.layer.addSublayer(gradient)
    }
}
