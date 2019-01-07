//
//  EmailViewController.swift
//  EmailSupportDemo
//
//  Created by George Garcia on 1/7/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonUI()
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        showEmailComposer()
    }
    
    private func setupButtonUI() {
        sendButton.backgroundColor = UIColor(red: 255/255, green: 5/255, blue: 41/255, alpha: 1.0)
        sendButton.layer.cornerRadius = 10
    }
    
    private func showEmailComposer() {
        //checking if this device can send mail
        guard MFMailComposeViewController.canSendMail() else {
            // show alert informing the user
            return
        }
        // setup a composer where you are pretty much using Apple's Mail App
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["garcia.george.b@gmail.com"])
        composer.setSubject("Support Please!")
        composer.setMessageBody("Hey George! I actually need some help. Please respond when you can! \n\nSent from iPhone", isHTML: false)
        present(composer, animated: true)
    }
}

extension EmailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            // show an alert of the error
            controller.dismiss(animated: true, completion: nil)
            return 
        }
        
        switch result {
        case .cancelled:
            print("Email Cancelled")
        case .failed:
            print("Failed to send!")
        case .saved:
            print("Saved")
        case .sent:
            print("Email has sent!")
        default:
            print("Nothing...")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
