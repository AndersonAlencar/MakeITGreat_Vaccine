//
//  MyCardViewController.swift
//  Vaccine
//
//  Created by Anderson Alencar on 23/11/20.
//

import UIKit

class MyCardViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    let person = Person.sharedPerson
    
    var filteredData = Person.sharedPerson.vaccines
    
    lazy var myCardView: MyCardView = {
        let myView = MyCardView()
        myView.vaccinesTable.delegate = self
        myView.vaccinesTable.dataSource = self
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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        //setGradientLayer()
        newGradient()
        
        myCardView.vaccinesTable.reloadData()
    }

    func setUpSearch() {
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = UIColor.black
        // navigationItem.hidesSearchBarWhenScolling = true
        let image  = UIImage()
        searchController.searchBar.backgroundImage = image
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func newGradient() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        //status bar
        let colorView = UIView()
        colorView.isUserInteractionEnabled = false
        navigationController?.navigationBar.addSubview(colorView)
        navigationController?.navigationBar.sendSubviewToBack(colorView)
        colorView.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: (navigationController?.navigationBar.frame.width)!, height: UIApplication.shared.statusBarFrame.height)

        //gradient
        var bounds = navigationController!.navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.10, 1.0]
        gradient.colors = [UIColor.darkBlueGradiente.cgColor, UIColor.purpleGradiente.cgColor]
        
        let gradient2 = CAGradientLayer()
        gradient2.frame = bounds
        gradient2.startPoint = CGPoint(x: 0, y: 1)
        gradient2.endPoint = CGPoint(x: 1, y: 1)
        gradient2.locations = [0.0, 1.0]
        gradient2.colors = [UIColor.lightBlueGradiente.cgColor, UIColor.darkBlueGradiente.cgColor]
        
        if let image = getImageFrom(gradientLayer: gradient) {
            //smalltitle background
            navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            //largetitle background
            navigationController?.navigationBar.backgroundColor = UIColor(patternImage: getImageFrom(gradientLayer: gradient)!)
            //status bar
            colorView.backgroundColor = UIColor(patternImage: getImageFrom(gradientLayer: gradient)!)
            
        }
    }

    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        gradientImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), resizingMode: .stretch)
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension MyCardViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? person.vaccines : person.vaccines.filter({ (vaccine) -> Bool in
                return vaccine.name.contains(searchText)
            })
        }
        myCardView.vaccinesTable.reloadData()
        
    }
}

extension MyCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VaccineCellTableViewCell.identifier, for: indexPath) as! VaccineCellTableViewCell
        
        cell.configure(with: filteredData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVaccine = SelectedVaccineViewController()
        selectedVaccine.vaccineSelected = filteredData[indexPath.row]
        navigationController?.pushViewController(selectedVaccine, animated: true)
    }
}
