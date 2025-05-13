//
// CreateAccountViewController.swift
// DemoOnMVVM
//

import UIKit
import Foundation

class CreateAccountViewController: UIViewController {
    
    private var viewModel : CreateAccountViewModel!
    
    init(viewModel: CreateAccountViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        view.text = LocalizedStrings.SignUpScreen.headerTitle
        return view
    }()
    
    private lazy var meassageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = LocalizedStrings.SignUpScreen.headerMessage
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
    
    private lazy var nameTextField: UITextField = {
        return createFormField(with:LocalizedStrings.SignUpScreen.userNameField.placeholder)
    }()
    
    private lazy var ageTextField: UITextField = {
        return createFormField(with: LocalizedStrings.SignUpScreen.userAgeField.placeholder)
    }()
    
    private lazy var emailTextField: UITextField = {
        return createFormField(with: LocalizedStrings.SignUpScreen.userEmailField.placeholder)
    }()
    
    private lazy var passwordTextField: UITextField = {
        return createFormField(with:LocalizedStrings.SignUpScreen.userPassword.placeholder, isSecured: true)
    }()
    
    private lazy var ConfirmPasswordTextField: UITextField = {
        return createFormField (with:LocalizedStrings.SignUpScreen.userConfirmPassword.placeholder , isSecured: true)
    }()
    
    
    private lazy var createAccountBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemTeal
        view.setTitle(LocalizedStrings.SignUpScreen.createAccBtn, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self,action: #selector(didTapSignUpButton),for: .touchUpInside)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var goBackBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .systemPink
        view.setTitle(LocalizedStrings.SignUpScreen.goBackBtn, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self,action: #selector(didTapBackBtn),for: .touchUpInside)
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
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.SignUpScreen.userNameField.title))
        view.addArrangedSubview(nameTextField)
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.SignUpScreen.userAgeField.title))
        view.addArrangedSubview(ageTextField)
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.SignUpScreen.userEmailField.title))
        view.addArrangedSubview(emailTextField)
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.SignUpScreen.userPassword.title))
        view.addArrangedSubview(passwordTextField)
        view.addArrangedSubview(createFormLabel(with:LocalizedStrings.SignUpScreen.userConfirmPassword.title))
        view.addArrangedSubview(ConfirmPasswordTextField)
        view.addArrangedSubview(createAccountBtn)
        view.addArrangedSubview(goBackBtn)
        return view
    }()
}

// MARK: - View Life Cycle Methods

extension CreateAccountViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
    }
}

// MARK: - Configure Sub-Views and Clear Field Methods

extension CreateAccountViewController {
    
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
        nameTextField.text = ""
        ageTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        ConfirmPasswordTextField.text = ""
    }
}

// MARK: - Button Tap Handlers

extension CreateAccountViewController {
    
    @objc func didTapSignUpButton() {
        var model = UserModel()
        model.name = nameTextField.text
        model.age = Int(ageTextField.text ?? "0")
        model.email = emailTextField.text
        model.password = passwordTextField.text
        model.confirmPassword = ConfirmPasswordTextField.text
        
        viewModel.createUser(for: model) { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.clearTextFields()
                    self.dismiss(animated: true)
                }
            } else {
                print("User creation failed")
            }
        }
    }
    
    @objc func didTapBackBtn() {
        self.clearTextFields()
        self.dismiss(animated: true)
    }
    
}

// MARK: - Error Handler Delegate Methods

extension CreateAccountViewController : formValidationHandelProtolcol {
    
    func didContailEmptyField() {
        Utilites.showAlert(from: self,title:LocalizedStrings.Alerts.requiredFieldAlert)
    }
    
    func didEnterInvalidEmail() {
        Utilites.showAlert(from: self,title: LocalizedStrings.Alerts.invalidEmailAlert)
    }
    
    func didEnterInvalidAge() {
        Utilites.showAlert(from: self,title: LocalizedStrings.Alerts.invalidAgeAlert)
    }
    
    func didNotMatchPasswords() {
        Utilites.showAlert(from: self,title: LocalizedStrings.Alerts.passwordAlert)
    }
    
    func didNotAuthError(error: String) {
        Utilites.showAlert(from: self,title: error)
    }
}


