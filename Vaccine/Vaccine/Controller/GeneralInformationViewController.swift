//
//  GeneralInformationViewController.swift
//  Vaccine
//
//  Created by David Augusto on 27/11/20.
//

import UIKit

class GeneralInformationViewController: UIViewController {

    var vaccineSelected: Vaccine?
    
    lazy var generalInformationView: GeneralInformationView = {
        let myView = GeneralInformationView()
        myView.informationTableView.delegate = self
        myView.informationTableView.dataSource = self
        return myView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = vaccineSelected?.name
        self.navigationController?.navigationBar.tintColor = .purpleAction
        let closeButton = UIBarButtonItem(title: "Fechar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeButtonAction))
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.view = generalInformationView
    }
    
    @objc func closeButtonAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

extension GeneralInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let BCGVaccine = GeneralDataMode(idVaccine: 3, nameVaccine: "BCG", prevention: "Tuberculose – principalmente as formas graves, como meningite tuberculosa e tuberculose miliar (espalhada pelo corpo).", nDoses: 3, indication: "A vacina é indicada de rotina a partir do nascimento até antes de a criança completar 5 anos de idade. Pessoas de qualquer idade que convivem com portadores de hanseníase (lepra).", adverseEffects: """
            A BCG quase sempre deixa uma cicatriz característica, com até 1 cm de diâmetro, no local em que foi aplicada – como rotina, no braço direito. Essa reação é esperada! A resposta à vacina demora cerca de três meses (12 semanas), podendo se prolongar por até seis meses (24 semanas), e começa com uma mancha vermelha elevada no local da aplicação, evolui para pequena úlcera, que produz secreção até que vai cicatrizando.
            Eventos adversos possíveis: úlceras com mais de 1 cm ou que demoram muito a cicatrizar; gânglios ou abscessos na pele e nas axilas; disseminação do bacilo da vacina pelo corpo, causando lesões em diferentes órgãos. Segundo o Ministério da Saúde (MS), os gânglios surgem em cerca de 10% dos vacinados. Qualquer que seja o evento, o serviço de vacinação deve notificá-lo ao órgão de vigilância em Saúde e encaminhar o paciente ao posto de saúde para acompanhamento e tratamento adequados.
            """, againstIndication: "Pessoas imunodeprimidas e recém-nascidos de mães que usaram medicamentos que possam causar imunodepressão do feto durante a gestação. Prematuros, até que atinjam 2 kg de peso.")
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralDataTableViewCell.identifier, for: indexPath) as! GeneralDataTableViewCell
            cell.configure(with: BCGVaccine)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutVaccineTableViewCell.identifier, for: indexPath) as! AboutVaccineTableViewCell
            cell.configure(with: BCGVaccine)
            cell.selectionStyle = .none
            return cell
        }
    }

}
