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
        setUpSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setGradientLayer()
    }

    func setGradientLayer() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let width = window?.windowScene?.statusBarManager?.statusBarFrame.width ?? 0

        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = CGRect(x: 0, y: 0, width: width, height: height + self.navigationController!.navigationBar.frame.height)
        gradient.locations = [0.0, 0.10, 1.0]
        gradient.colors = [ UIColor.lightBlueGradiente.cgColor, UIColor.darkBlueGradiente.cgColor, UIColor.purpleGradiente.cgColor]
        view.layer.addSublayer(gradient)
    }

    func setUpSearch() {
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = UIColor.black
        // navigationItem.hidesSearchBarWhenScolling = true
        let image  = UIImage()
        searchController.searchBar.backgroundImage = image
        searchController.searchBar.searchTextField.backgroundColor = .white

        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension MyCardViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}
