//
//  SideMenuControllerViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//
// from : https://roniruny.tistory.com/146

// 공부 필요해서 가져옴! 섹션으로 접고피는것


import UIKit
import SnapKit

class SideMenuControllerViewController: UIViewController{
    
    var tableViewData = [cellData]()
    
    
    // MARK: - Property
    var tableView = UITableView()
    var signInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "power.circle"), for: .normal)
        return button
    }()
    var nicknameInfo: UILabel = {
        let label = UILabel()
        label.text = "로그인 하실?"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    // MARK: - Lifecycle
    var noticeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        return btn
    }()
    
    var settingButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        return btn
    }()
    
    var logo: UILabel = {
        let logo = UILabel()
        logo.text = "DF"
        logo.textAlignment = .center
        return logo
    }()
    
    var LogON = false
    var username: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: "방문한 갤러리", sectionData: ["Cell1", "Cell2", "Cell3", "Cell3", "Cell4", "Cell5"]),
                         cellData(opened: false, title: "갤러리 리스트", sectionData: []),
                         cellData(opened: false, title: "운영 갤러리", sectionData: []),
                         cellData(opened: false, title: "최근 본 글", sectionData: [])]
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        //NotificationCenter.default.addObserver(self, selector: #selector(changableToken(_:)), name: Notification.Name("token"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout(_ :)), name: NSNotification.Name("LogOut"), object: nil)
        tokenCheck()
        configureUI()
    }
    @objc func logout(_ notification: Notification) {
        self.LogON = false
        UserDefaults.standard.removeObject(forKey: "token")
        signInButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        signInButton.setImage(UIImage(systemName: "power.circle"), for: .normal)
        nicknameInfo.text = "로그인 하실?"
    }
    func tokenCheck() {
        guard let token = UserDefaults.standard.object(forKey: "token") else { return }
        guard let log = UserDefaults.standard.object(forKey: "userInfo") as? String else { return }
        self.LogON = true
        self.username = log
    }
    
    @objc func changableToken(_ notification: Notification) {
        print("CHANGE!!")
        guard let tokenInfo = notification.object as? TokenInfo else {
            return }
        self.signInButton.setImage(UIImage(systemName: "power.circle.fill"), for: .normal)
        self.signInButton.addTarget(self, action: #selector(LogOff), for: .touchUpInside)
        print(tokenInfo)
    }
    
    
    // MARK: - UI
    
    func configureUI() {
        lazy var blankLabel = UILabel()
        lazy var blankLabel2 = UILabel()
        lazy var blankLabel3 = UILabel()
        lazy var blankLabel4 = UILabel()
        
        lazy var logStack = UIStackView(arrangedSubviews: [blankLabel4, signInButton])
        lazy var stackView = UIStackView(arrangedSubviews: [nicknameInfo, logStack])
        lazy var btnView = UIStackView(arrangedSubviews: [settingButton, noticeButton])
        lazy var stackTop = UIStackView(arrangedSubviews: [logo, blankLabel, btnView])
        
        lazy var HeaderStack = UIStackView(arrangedSubviews: [stackTop, stackView])
        
        logStack.distribution = .fillEqually
        
        print("LOG ", LogON)
        if !LogON {
            signInButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
            signInButton.setImage(UIImage(systemName: "power.circle"), for: .normal)
            nicknameInfo.text = "로그인 하실?"
        }else {
            nicknameInfo.text = "\(username)"
            signInButton.setImage(UIImage(systemName: "power.circle.fill"), for: .normal)
            signInButton.addTarget(self, action: #selector(LogOff), for: .touchUpInside)
        }
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        
        btnView.spacing = 0.0
        btnView.distribution = .fillEqually
        
        stackTop.spacing = 0.0
        stackTop.distribution = .fillEqually
        
        HeaderStack.axis = .vertical
        
        HeaderStack.spacing = 15.0
        HeaderStack.distribution = .fillEqually
        
        view.addSubview(HeaderStack)
        view.addSubview(tableView)
        
        HeaderStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc func SignIn() {
        guard let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") else { return }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func LogOff() {
        var goOn = false
        let alert = UIAlertController(title: "로그아웃 하시겠어요?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: true, userInfo: nil)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
        
    }
}


// MARK: - UITableViewDelegate

extension SideMenuControllerViewController : UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource

extension SideMenuControllerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return tableViewData[section].sectionData.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section 부분 코드
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        // section 부분 선택하면 열리게 설정
        // Select -> Delegate -> View Transition
        print(indexPath.row, indexPath.section)
        if indexPath.row == 0 {
            // section이 열려있다면 다시 닫힐 수 있게 해주는 코드
            tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
            // 모든 데이터를 새로고침하는 것이 아닌 해당하는 섹션 부분만 새로고침
            tableView.reloadSections([indexPath.section], with: .none)
            // sectionData 부분을 선택하면 아무 작동하지 않게 설정
        } else {
            print("이건 sectionData 선택한 거야")
        }
        
        switch indexPath.section {
        case 0:
            break
        case 1:
            guard let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SubTabBarController") else { return }
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true)
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
        print([indexPath.section], [indexPath.row])
    }
    
}

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}
