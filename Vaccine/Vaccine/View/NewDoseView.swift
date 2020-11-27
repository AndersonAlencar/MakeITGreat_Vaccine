//
//  NewDose.swift
//  Vaccine
//
//  Created by Felipe Santana on 25/11/20.
//

import UIKit

class NewDoseView: UIView {

    var controller: NewDoseViewController? = NewDoseViewController()
    weak var delegate: DismissModal?
    
    lazy var modalBackground: UIView = {
        let mView = UIView()
        mView.backgroundColor = .white
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.layer.cornerRadius = 16
        mView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mView.clipsToBounds = true
        
        return mView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.redAlert, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.purpleAction, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var doseNumber: UILabel = {
        let dNumber = UILabel()
        dNumber.textColor = .black
        dNumber.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        dNumber.adjustsFontSizeToFitWidth = true
        dNumber.translatesAutoresizingMaskIntoConstraints = false
        
        return dNumber
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = .purpleAction
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .modalBackground
        modalBackgroundContraints()
        cancelButtonConstraint()
        doseNumberConstraint()
        addButtonConstraint()
        datePickerConstraint()
        
        cancelButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addDose), for: .touchUpInside)
    }
    
    @objc func addDose() {
        self.controller?.addDose(date: datePicker.date)
    }
    
    @objc func dismissModal() {
        delegate?.dismissModal()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func modalBackgroundContraints() {
        addSubview(modalBackground)
        
        NSLayoutConstraint.activate([
            modalBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modalBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            modalBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            modalBackground.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6)
        ])
    }
    
    func cancelButtonConstraint() {
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: modalBackground.leadingAnchor, constant: 24),
            cancelButton.topAnchor.constraint(equalTo: modalBackground.topAnchor, constant: 24)
        ])
    }
    
    func doseNumberConstraint() {
        addSubview(doseNumber)
        
        NSLayoutConstraint.activate([
            doseNumber.centerXAnchor.constraint(equalTo: modalBackground.centerXAnchor),
            doseNumber.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor)
        ])
    }
    
    func addButtonConstraint() {
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            addButton.topAnchor.constraint(equalTo: modalBackground.topAnchor, constant: 24)
        ])
        
    }
    
    func datePickerConstraint() {
        addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: doseNumber.bottomAnchor, constant: 24),
            datePicker.leadingAnchor.constraint(equalTo: modalBackground.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: modalBackground.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalTo: modalBackground.heightAnchor, multiplier: 0.9)
        ])
        
    }
    
}
