//
//  SignInViewController.swift
//  GoMoney
//
//  Created by Golden Owl on 12/10/2022.
//

import UIKit

class SignInViewController: GMViewController {
    private lazy var img: UIImageView = .build { view in
        view.image = UIImage(named: "onboard_1")
    }
    
    private lazy var mailButton: ButtonAuth = .init(
        icon: "ic_email",
        text: "Sign in with password",
        background: K.Color.actionBackground
    ) {
        $0.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.didTapSignInEmail)
        ))
    }
    
    private lazy var googleButton: ButtonAuth = .init(
        icon: "ic_google",
        text: "Sign in with gmail",
        background: .white,
        textColor: K.Color.actionBackground
    ) {
        $0.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.didTapSignInGoogle)
        ))
    }

    private lazy var signUpText: GMLabelSpan = .init(
        text: "Don't have an account? Signup",
        span: "Signup",
        style: .regular
    ) {
        $0.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.didTapSignUp)
        ))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        img.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        mailButton.transform = CGAffineTransform(translationX: view.frame.origin.x + view.frame.width / 2, y: 0)
        googleButton.transform = CGAffineTransform(translationX: view.frame.origin.x + view.frame.width / 2, y: 0)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.img.transform = .identity
            self.mailButton.transform = .identity
            self.googleButton.transform = .identity
        })
    }
 
    override func setupLayout() {
        title = "Login"
        view.backgroundColor = .white
        view.addSubviews(img, mailButton, googleButton, signUpText)
        
        img.anchor(width: 200, height: 200)
        img.centerXToSuperview()
        img.centerYToSuperview(offset: -(windowSafeAreaInsets?.top ?? 0))
        
        signUpText.centerX(inView: view)
        signUpText.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingBottom: 24
        )
        
        googleButton.anchor(
            left: view.leftAnchor,
            bottom: signUpText.topAnchor,
            right: view.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 24,
            paddingRight: 16,
            height: 40
        )
        
        mailButton.anchor(
            left: view.leftAnchor,
            bottom: googleButton.topAnchor,
            right: view.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16,
            height: 40
        )
    }
        
    @objc private func didTapSignUp() {
        let vc = SignUpPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSignInEmail() {
        let vc = SignInPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSignInGoogle() {
        print("go to google")
    }
}
