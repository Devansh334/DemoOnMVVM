//
// HomeViewController.swift
// DemoOnMVVM
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    private var viewModel : HomeViewModel!
    private var detailsModel : UserDetailsModel!
    
    init(viewModel: HomeViewModel!) {
        self.viewModel = viewModel
        self.detailsModel = UserDetailsModel()
        self.viewModel.fetchUserData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 32)
        view.text = LocalizedStrings.HomeScreen.headerTitle + (detailsModel?.userName ?? "User") + " !"
        return view
    }()
    
    private lazy var meassageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = LocalizedStrings.HomeScreen.headerMessage
        return view
    }()
    
    private lazy var userDetailsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.text = LocalizedStrings.HomeScreen.detailsTableHeader
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = LocalizedStrings.HomeScreen.User.name + (detailsModel?.userName ?? "User")
        return view
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = LocalizedStrings.HomeScreen.User.email + (detailsModel?.userEmail ?? "N/A")
        return view
    }()
    
    private lazy var userAgeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = LocalizedStrings.HomeScreen.User.age + String(detailsModel?.userAge ?? 0)
        return view
    }()
    
    private lazy var logOutBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemPink
        view.setTitle(LocalizedStrings.HomeScreen.logOutBtn, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self,action: #selector(didTapLogOutButton),for: .touchUpInside)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    private func createSeperatorView()->UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = .gray
        return view
    }
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(userDetailsLabel)
        view.addArrangedSubview(createSeperatorView())
        view.addArrangedSubview(userNameLabel)
        view.addArrangedSubview(createSeperatorView())
        view.addArrangedSubview(userEmailLabel)
        view.addArrangedSubview(createSeperatorView())
        view.addArrangedSubview(userAgeLabel)
        NSLayoutConstraint.activate([
            userDetailsLabel.topAnchor
                .constraint(equalTo: view.topAnchor, constant: 12),
            userDetailsLabel.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 0),
            userNameLabel.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 12),
            userNameLabel.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -12),
            userEmailLabel.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 12),
            userEmailLabel.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -12),
            userAgeLabel.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 12),
            userAgeLabel.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        view.addArrangedSubview(bottomView)
        return view
    }()
    
}

// MARK: - View Life Cycle Methods

extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.configureSubViews()
    }
}

// MARK: - Configure Sub-Views and Update UI

extension HomeViewController {
    
    private func configureSubViews() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(headerLabel)
        self.view.addSubview(meassageLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(logOutBtn)
        NSLayoutConstraint.activate ([
            headerLabel.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            meassageLabel.topAnchor.constraint(equalTo:headerLabel.bottomAnchor, constant: 12),
            meassageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            meassageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo:meassageLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            logOutBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            logOutBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            logOutBtn.topAnchor.constraint(equalTo:stackView.bottomAnchor, constant: 60)
        ])
    }
    
    private func updateUI() {
        headerLabel.text = LocalizedStrings.HomeScreen.headerTitle + (detailsModel.userName ?? "User") + " !"
        userNameLabel.text = LocalizedStrings.HomeScreen.User.name + (detailsModel.userName ?? "User")
        userEmailLabel.text = LocalizedStrings.HomeScreen.User.email + (detailsModel.userEmail ?? "N/A")
        userAgeLabel.text = LocalizedStrings.HomeScreen.User.age + String(detailsModel.userAge ?? 0)
    }
}

// MARK: - Button Tap Handlers

extension HomeViewController {
    
    @objc func didTapLogOutButton() {
        self.logOut()
    }
}

// MARK: - Log Out

extension HomeViewController {
    
    func logOut() {
        UserDefaultHelper.shared.resetKeys()
        guard let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print("Error: No window found")
            return
        }
        let vm = UserLoginViewModel()
        let vc = UserLoginViewController(viewModel: vm)
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { window.rootViewController = vc}, completion: nil)
        window.makeKeyAndVisible()
    }
}

// MARK: - Home Data API Handlers

extension HomeViewController : FetchUserDataHandleProtocol {
    
    func didFetchedUser(_ user: UserDetailsModel) {
        self.detailsModel.userAge = user.userAge
        self.detailsModel.userEmail = user.userEmail
        self.detailsModel.userName = user.userName
        
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func didGetError(_ message: String) {
        Utilites.showAlert(from: self, title: message)
    }
}
    
    
