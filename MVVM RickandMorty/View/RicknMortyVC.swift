//
//  RicknMortyVC.swift
//  MVVM RickandMorty
//
//  Created by Halimcan Dayal on 18.03.2022.
//

import UIKit
import SnapKit

protocol RicknMortyOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RicknMortyVC: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    private lazy var results: [Result] = []

    lazy var viewModel: IRicknMortyViewModel = RicknMortyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }

    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)

        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()

    }

    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RicknMortyTableViewCell.self, forCellReuseIdentifier: RicknMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 150
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Ricky Morty"
            self.indicator.color = .red
        }
        indicator.startAnimating()
    }

}

extension RicknMortyVC: RicknMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }

    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
}

extension RicknMortyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RicknMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RicknMortyTableViewCell.Identifier.custom.rawValue) as? RicknMortyTableViewCell else {
            return UITableViewCell()

        }
        cell.saveModel(model: results[indexPath.row])
        return cell

    }
}
extension RicknMortyVC {

    private func makeTableView() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }

    func makeLabel() {
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }

    func makeIndicator() {
        indicator.snp.makeConstraints { (make) in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
