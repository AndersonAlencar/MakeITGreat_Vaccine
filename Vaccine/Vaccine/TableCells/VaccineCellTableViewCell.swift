//
//  VaccineCellTableViewCell.swift
//  Vaccine
//
//  Created by David Augusto on 24/11/20.
//

import UIKit

class VaccineCellTableViewCell: UITableViewCell {

    static let identifier = "VaccineCellTableViewCell"
    
    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .cardGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "-"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "-"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var progressView: CircularProgressView = {
        let view = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 46, height: 46))
        view.trackColor = UIColor.white
        view.progressColor = UIColor.purpleAction
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "3/3"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var doneView: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleAction
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconAlert: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.tintColor = .redAlert
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressView.setProgress(value: 0)
    }
    
    func configure(with vaccine: Vaccine, animated: Bool) {
        nameLabel.text = vaccine.name
        statusLabel.text = StatusVaccine(rawValue: vaccine.vaccineStatus)?.description
        progressLabel.text = "\(vaccine.dose!.count)/\(vaccine.nDoses)"
        if animated {
            progressView.setProgressWithAnimation(duration: 2.0, value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))
        } else {
            progressView.setProgress(value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))
        }
        
//        progressView.setProgressWithAnimation(duration: 1.0, value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))

        switch vaccine.vaccineStatus {
            case 2:
                doneView.backgroundColor = .purpleAction
                progressLabel.textColor = .white
//                setValueProgress(value: 1)

            case 1:
                doneView.backgroundColor = .clear
                progressLabel.textColor = .clear
                progressView.progressColor = .redAlert
                let configuration = UIImage.SymbolConfiguration(pointSize: 35)
                iconAlert.image = UIImage(systemName: "exclamationmark.circle.fill", withConfiguration: configuration)
                setValueProgress(value: 1)

            case 0: //Pendente
                doneView.backgroundColor = .clear
                progressLabel.textColor = .darkText
                //animaCell(with: vaccine)
                //setValueProgress(value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))

            default:
                doneView.backgroundColor = .clear
                progressLabel.textColor = .darkText
        }
        
    }
    
    func animaCell(with vaccine: Vaccine) {
        progressView.setProgressWithAnimation(duration: 1.0, value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))
        setValueProgress(value: Float(vaccine.dose!.count)/Float(vaccine.nDoses))
    }
    
    func setValueProgress(value: Float) {
        progressView.setProgress(value: value)
    }
}

extension VaccineCellTableViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(viewCard)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(progressView)
        addSubview(doneView)
        addSubview(progressLabel)
        addSubview(iconAlert)
    }
    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewCard.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            viewCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            progressView.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -16),
            progressView.centerYAnchor.constraint(equalTo: viewCard.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 46),
            progressView.widthAnchor.constraint(equalToConstant: 46)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: 13),
            nameLabel.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            progressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            doneView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            doneView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            doneView.heightAnchor.constraint(equalToConstant: 30),
            doneView.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            iconAlert.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            iconAlert.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            iconAlert.heightAnchor.constraint(equalToConstant: 35),
            iconAlert.widthAnchor.constraint(equalToConstant: 35)
        ])

    }
    func aditionalConfigurations() {
        backgroundColor = .white
    }
}
