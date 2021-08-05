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
    
    @IBOutlet weak var errorMessage: UILabel!
    
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
    // Do any additional setup after loading the view, typically from a nib.
    CardIOUtilities.preload()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  
  @IBAction func scanCard(sender: AnyObject) {
    errorMessage.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    let TCEmpty = tcInputField.text == ""
    
    let passwordEmpty = passwordInputField.text == ""
    
    let TCCorrect:Bool =  tcInputField.text == myUser.tckn
    let passwordCorrect:Bool = passwordInputField.text == myUser.password
    
    if TCEmpty{
        errorMessage.text = "TC boş olamaz.Yeniden deneyiniz."
        errorMessage.sizeToFit()
        print("TC boş olamaz.Yeniden deneyiniz.")
    }
    
    else if passwordEmpty {
        errorMessage.text = "Şifre boş olamaz.Yeniden deneyiniz."
        errorMessage.sizeToFit()
        print("Şifre boş olamaz.Yeniden deneyiniz.")
    }
    
    else if !TCCorrect {
        errorMessage.text = "TC'niz yanlış.Yeniden deneyiniz."
        errorMessage.sizeToFit()
        print("TC'niz yanlış.Yeniden deneyiniz.")
    }
    else if !passwordCorrect{
        errorMessage.text = "Şifrenizniz yanlış.Yeniden deneyiniz."
        errorMessage.sizeToFit()
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

