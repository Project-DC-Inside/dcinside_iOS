//
//  MakePostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MakePostSceneViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MakePostScene Error Occured")
    }
    
    private func attribute() {
        title = "글 쓰기"
        view.backgroundColor = .white
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleFieldCell.self, forCellReuseIdentifier: "TitleFieldCell") // 0
        tableView.register(WriteFormCell.self, forCellReuseIdentifier: "WriteFormCell")
        // 0
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(_ viewModel: MakePostSceneViewModel) {
        viewModel.cellData.drive(tableView.rx.items) { tv, row, data in
            switch row {
            case 0:
                let cell = tv.dequeueReusableCell(withIdentifier: "TitleFieldCell", for: IndexPath(row: row, section: 0)) as! TitleFieldCell
                cell.selectionStyle = .none
                cell.titleIputField.placeholder = data
                cell.bind(viewModel.titleFieldCellViewModel)
                return cell
            case 1:
                let cell = tv.dequeueReusableCell(withIdentifier: "WriteFormCell", for: IndexPath(row: row, section: 0)) as! WriteFormCell
                cell.selectionStyle = .none
                cell.contentInputView.text = data
                cell.bind(viewModel.writeFormCellViewModel)
                return cell
            default:
                fatalError("cellData Error")
            }
        }
    }
    
}
