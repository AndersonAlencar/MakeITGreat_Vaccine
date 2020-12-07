//
//  EditDoseView.swift
//  Vaccine
//
//  Created by Felipe Santana on 01/12/20.
//

import UIKit

class EditDoseView: UIView {

    var controller: EditViewController? = EditViewController()
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
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
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
        picker.maximumDate = Date()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = .purpleAction
        picker.translatesAutoresizingMaskIntoConstraints = false
        let loc = Locale(identifier: "pt-br")
        picker.locale = loc
        picker.calendar.locale = loc
        return picker
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        modalBackgroundContraints()
        cancelButtonConstraint()
        doseNumberConstraint()
        addButtonConstraint()
        datePickerConstraint()
        
        cancelButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(editDose), for: .touchUpInside)
    }
    
    @objc func editDose() {
        self.controller?.editDose(date: datePicker.date)
    }
    
    @objc func dismissModal() {
        delegate?.dismissModal()
        self.controller?.delegateViewHidden?.viewHidden()
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
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            saveButton.topAnchor.constraint(equalTo: modalBackground.topAnchor, constant: 24)
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
