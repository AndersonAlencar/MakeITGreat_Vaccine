//
//  MyCardViewController.swift
//  Vaccine
//
//  Created by Anderson Alencar on 23/11/20.
//

import UIKit
import CoreData

class MyCardViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var filteredData: [Vaccine]?
    var managerCoreData = CoreDataManager()
    var user: User?
    
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
        user = managerCoreData.getUser()
        filteredData = managerCoreData.fetchVaccines()
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
//        if let cancelButton = searchController.searchBar.value(forKey: "cancelButton") as? UIButton {
//            cancelButton.setTitle("Cancelar", for: .normal)
//        }
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = UIColor.black
        let image  = UIImage()
        searchController.searchBar.backgroundImage = image
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Pesquisar"
        navigationItem.searchController = searchController
    }
    
    func newGradient() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        //status bar
        let colorView = UIView()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        colorView.isUserInteractionEnabled = false
        navigationController?.navigationBar.addSubview(colorView)
        navigationController?.navigationBar.sendSubviewToBack(colorView)
        colorView.frame = CGRect(x: 0, y: -(window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0), width: (navigationController?.navigationBar.frame.width)!, height: window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)

        //gradient
        var bounds = navigationController!.navigationBar.bounds
        bounds.size.height += window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
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
            filteredData = searchText.isEmpty ? managerCoreData.fetchVaccines() : managerCoreData.fetchVaccines().filter({ (vaccine) -> Bool in
                if let vaccine = vaccine.name?.contains(searchText) {
                    return vaccine
                }
                return false
            })
        }
        myCardView.vaccinesTable.reloadData()
        
    }
}

extension MyCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VaccineCellTableViewCell.identifier, for: indexPath) as! VaccineCellTableViewCell
        
        if let vaccine = filteredData?[indexPath.row] {
            cell.configure(with: vaccine)
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVaccine = SelectedVaccineViewController()
        if let vaccine = filteredData?[indexPath.row] {
            selectedVaccine.vaccineSelected = vaccine
        }
        navigationController?.pushViewController(selectedVaccine, animated: true)
    }
}
