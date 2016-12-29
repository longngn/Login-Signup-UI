//
//  ViewController.swift
//  LoginSignupUI
//
//  Created by Nguyen Le Vu Long on 12/26/16.
//  Copyright © 2016 Nguyen Le Vu Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var loginOrSignupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var outsideLoginButton: UIButton!
    @IBOutlet weak var outsideSignupButton: UIButton!
    
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var insideLoginButton: UIButton!
    @IBOutlet weak var loginToSignupPanelButton: UIButton!
    
    @IBOutlet var signupView: UIView!
    @IBOutlet weak var insideSignupButton: UIButton!
    @IBOutlet weak var signupToLoginPanelButton: UIButton!
    
    var screenWidth: CGFloat!
    override var shouldAutorotate: Bool {
        return false
    }
    let selfReference = self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.width
        
        // Rounded buttons
        insideLoginButton.layer.cornerRadius = insideLoginButton.frame.height / 2
        outsideLoginButton.layer.cornerRadius = outsideLoginButton.frame.height / 2
        insideSignupButton.layer.cornerRadius = insideSignupButton.frame.height / 2
        outsideSignupButton.layer.cornerRadius = outsideSignupButton.frame.height / 2
        
        // Setup for initial animation
        titleLabel.transform = CGAffineTransform(translationX: 0, y: -(view.bounds.height / 2) - titleLabel.frame.height)
        loginOrSignupView.transform = CGAffineTransform(translationX: 0, y: loginOrSignupView.frame.height)
        
        // Set signup panel position
        loginView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
        signupView.transform = CGAffineTransform(translationX: screenWidth, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.transform = CGAffineTransform.identity
            self.loginOrSignupView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // MARK: Helper functions
    private func showPanelFromBelow(_ panel: UIView) {
        let titleScaleTransform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let titleMoveTransform = CGAffineTransform(translationX: 0, y: -(titleLabel.center.y - loginView.frame.origin.y/2))
        
        let panelPinAtBottomTransform = CGAffineTransform(translationX: 0, y: loginOrSignupView.frame.origin.y - panel.frame.origin.y)
        panel.transform = CGAffineTransform.identity.concatenating(panelPinAtBottomTransform)
        loginOrSignupView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.transform = titleScaleTransform.concatenating(titleMoveTransform)
            panel.transform = CGAffineTransform.identity
        }, completion: nil)
        //view.layoutIfNeeded()
    }
    private func dismissAnimation(_ panel: UIView) {
        let moveDownTransform = CGAffineTransform(translationX: 0, y: 40)
        let moveUpTransform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            //self.titleLabel.transform = self.titleLabel.transform.concatenating(moveDownTransform)
            self.titleLabel.center.y += 40.0
            panel.transform = panel.transform.concatenating(moveDownTransform)
        }, completion: { success in
            if (success) {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    //self.titleLabel.transform = self.titleLabel.transform.concatenating(moveUpTransform)
                    self.titleLabel.center.y -= self.view.frame.height * 0.5
                    panel.transform = panel.transform.concatenating(moveUpTransform)
                }, completion: nil)
            }
        })
    }
    
    // MARK: Actions
    @IBAction func showLoginPanelFromBelow(_ sender: UIButton) {
        showPanelFromBelow(loginView)
    }
    @IBAction func showSignupPanelFromBelow(_ sender: UIButton) {
        showPanelFromBelow(signupView)
    }
    @IBAction func login(_ sender: UIButton) {
        dismissAnimation(loginView)
    }
    @IBAction func signup(_ sender: UIButton) {
        dismissAnimation(signupView)
    }
    @IBAction func switchToSignupPanel(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.loginView.transform = CGAffineTransform(translationX: -self.screenWidth, y: 0)
            self.signupView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    @IBAction func switchToLoginPanel(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.signupView.transform = CGAffineTransform(translationX: self.screenWidth, y: 0)
            self.loginView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

