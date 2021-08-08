//
//  ViewController.swift
//  ARBoost
//
//  Created by Mert Gökçen on 3.08.2021.
//

import UIKit

class ViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    
    @IBOutlet weak var tcInputField: UITextField!
    
    
    @IBOutlet weak var passwordInputField: UITextField!
    
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        tcInputField.resignFirstResponder()
        passwordInputField.resignFirstResponder()
    }
    
    var myUser:User = User(
        tckn: "12341234123",
        name: "Mert",
        surname: "Gökçen",
        password: "mert")
    
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("cancel")
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        print("provide")
    }
    

  @IBOutlet weak var resultLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
    self.view.addGestureRecognizer(tapGesture)
    
    // Do any additional setup after loading the view, typically from a nib.
    CardIOUtilities.preload()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated..
  }
    
  
  @IBAction func scanCard(sender: AnyObject) {
    
    let TCEmpty = tcInputField.text == ""
    
    let passwordEmpty = passwordInputField.text == ""
    
    let TCCorrect:Bool =  tcInputField.text == myUser.tckn
    let passwordCorrect:Bool = passwordInputField.text == myUser.password
    var text:String
    if TCEmpty{
        text = "TC boş olamaz.Yeniden deneyiniz."
        print("TC boş olamaz.Yeniden deneyiniz.")
    }
    
    else if passwordEmpty {
        text = "Şifre boş olamaz.Yeniden deneyiniz."
        print("Şifre boş olamaz.Yeniden deneyiniz.")
    }
    
    else if !TCCorrect {
        text = "TC'niz yanlış.Yeniden deneyiniz."
        print("TC'niz yanlış.Yeniden deneyiniz.")
    }
    else if !passwordCorrect{
        text = "Şifrenizniz yanlış.Yeniden deneyiniz."
        print("Şifrenizniz yanlış.Yeniden deneyiniz.")
    }
    
    else{
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC!.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
    }
    
 
  }
  
  func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
    resultLabel.text = "user canceled"
    paymentViewController?.dismiss(animated: true, completion: nil)
  }
  
  func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
    if let info = cardInfo {
      let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
      resultLabel.text = str as String
    }
    paymentViewController?.dismiss(animated: true, completion: nil)
  }
}

