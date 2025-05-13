//
// UserLoginViewController.swift
// DemoOnMVVM
//

import UIKit
import Foundation

class UserLoginViewController: UIViewController {
    
    private var viewModel : UserLoginViewModel!
    
    init(viewModel: UserLoginViewModel!) {
        self.viewModel = viewModel
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
        view.text = LocalizedStrings.LoginScreen.headerTitle
        return view
    }()
    
    private lazy var meassageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = LocalizedStrings.LoginScreen.headerMessage
        return view
    }()
        
    private func createFormLabel(with string : String)->UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.text = string
        return view
    }
    
    private func createFormField(with placeHolder : String , isSecured : Bool = false)->UITextField {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.placeholder = placeHolder
        view.borderStyle = .roundedRect
        if isSecured {
            view.isSecureTextEntry = true
        }
        return view
    }
    
    private lazy var emailTextField: UITextField = {
        return createFormField(with: LocalizedStrings.LoginScreen.userEmailField.placeholder)
    }()

    private lazy var passwordTextField: UITextField = {
        return createFormField(with: LocalizedStrings.LoginScreen.userPassword.placeholder, isSecured: true)
    }()
    
    private lazy var signInBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemTeal
        view.setTitle(LocalizedStrings.LoginScreen.loginBtn, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self,action: #selector(didTapSignInButton),for: .touchUpInside)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var createAccountBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemPink
        view.setTitle(LocalizedStrings.LoginScreen.signUpBtn, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self,action: #selector(didTapSignUpButton),for: .touchUpInside)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.LoginScreen.userEmailField.title))
        view.addArrangedSubview(emailTextField)
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.LoginScreen.userPassword.title))
        view.addArrangedSubview(passwordTextField)
        view.addArrangedSubview(signInBtn)
        view.addArrangedSubview(createAccountBtn)
        return view
    }()
  
}

// MARK: - View Life Cycle Methods

extension UserLoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        viewModel.delegate = self
    }
}

// MARK: - Configure Sub-Views and Clear Field Methods

extension UserLoginViewController {
    
    private func configureSubViews() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(headerLabel)
        self.view.addSubview(meassageLabel)
        self.view.addSubview(stackView)
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
            ])
    }
    
    private func clearTextFields() {
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
}

// MARK: - Button Tap Handlers

extension UserLoginViewController {
    
    @objc func didTapSignInButton() {
        
        viewModel.emailFieldText = self.emailTextField.text
        viewModel.passwordFieldText = self.passwordTextField.text
        viewModel.authenticateUser()
    }
    
    @objc func didTapSignUpButton() {
        self.clearTextFields()
        self.presentSignUpScreen()
    }
}

// MARK: - Navigation Functions

extension UserLoginViewController {
    
    func navigateToHome() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print("Error: No window found")
            return
        }
        let vm = HomeViewModel()
        let vc = HomeViewController(viewModel: vm)
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: { window.rootViewController = vc}, completion: nil)
        window.makeKeyAndVisible()
    }
    
    func presentSignUpScreen() {
        let vm = CreateAccountViewModel()
        let vc = CreateAccountViewController(viewModel: vm)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - Login Controller Protocol Delegate Methods

extension UserLoginViewController : UserLoginHandleProtocol {
   
    func didSuccessLogin() {
        self.clearTextFields()
        self.navigateToHome()
    }

    func didFailedLogin(_ message: String) {
        self.clearTextFields()
        Utilites.showAlert(from: self,title: message)
    }

    func didNotEnterDetails() {
        self.clearTextFields()
        Utilites.showAlert(from: self,title:LocalizedStrings.Alerts.authFailedAlert)
    }
}
