//
//  ViewController.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 29.01.2026.
//

import UIKit

final class ViewController: UIViewController {
    private let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textLabel: UILabel = {
        $0.text = "Введите номер телефона для входа в личный кабинет"
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .label
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        return $0
    }(UILabel())
    private lazy var phoneTextField: UITextField = createTextField(title: "Телефон", keyboardType: .phonePad)
    private lazy var otpTextField: UITextField = createTextField(title: "Проверочный код", keyboardType: .numberPad)
    private lazy var btn: UIButton = {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .brand
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton(primaryAction: btnAction))
    private lazy var btnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        let phone = phoneTextField.text ?? ""
        let code = otpTextField.text ?? ""
        viewModel.buttonTapped(phone: phone, code: code)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Авторизация"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]
        view.backgroundColor = .white
        view.addSubview(textLabel)
        view.addSubview(phoneTextField)
        view.addSubview(otpTextField)
        view.addSubview(btn)
        viewModel.onStateChange = { [weak self] state in
            self?.apply(state: state)
        }
        apply(state: viewModel.state)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutContent(for: viewModel.state)
    }
}

private extension ViewController {
    func createTextField(title: String, keyboardType: UIKeyboardType) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = title
        textfield.font = .systemFont(ofSize: 20)
        textfield.textColor = .label
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(white: 0.82, alpha: 1).cgColor
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        textfield.leftViewMode = .always
        textfield.borderStyle = .none
        textfield.keyboardType = keyboardType
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }

    func apply(state: AuthViewModel.State) {
        btn.setTitle(state.buttonTitle, for: .normal)
        otpTextField.isHidden = state != .otp
        layoutContent(for: state)
    }

    func layoutContent(for state: AuthViewModel.State) {
        let horizontalPadding: CGFloat = 16
        let verticalSpacing: CGFloat = 24
        let fieldHeight: CGFloat = 48
        let buttonHeight: CGFloat = 56
        let contentWidth = view.bounds.width - horizontalPadding * 2
        let topY = view.safeAreaInsets.top + verticalSpacing

        let labelSize = textLabel.sizeThatFits(CGSize(width: contentWidth, height: .greatestFiniteMagnitude))
        textLabel.frame = CGRect(x: horizontalPadding, y: topY, width: contentWidth, height: labelSize.height)

        phoneTextField.frame = CGRect(x: horizontalPadding, y: textLabel.frame.maxY + verticalSpacing, width: contentWidth, height: fieldHeight)
        otpTextField.frame = CGRect(x: horizontalPadding, y: phoneTextField.frame.maxY + verticalSpacing, width: contentWidth, height: fieldHeight)

        let anchor = state == .otp ? otpTextField : phoneTextField
        btn.frame = CGRect(x: horizontalPadding, y: anchor.frame.maxY + verticalSpacing, width: contentWidth, height: buttonHeight)
    }

}
