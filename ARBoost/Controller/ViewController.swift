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
    
    func displayTcError(tcEmpty:Bool,tcNotExisting:Bool){
        if tcEmpty {
            print("TC boş olamaz.Yeniden deneyiniz.")
        }
        else if tcNotExisting{
            print("Yanlış bir TC girdiniz. Yeniden deneyiniz.")
        }
    }
  
  @IBAction func scanCard(sender: AnyObject) {
    
    let TCEmpty = tcInputField.text == ""
    
    let passEmpty = passwordInputField.text == ""
    
    if TCEmpty{
        print("TC boş olamaz.Yeniden deneyiniz.")
    }
    
    if passEmpty {
        print("Şifre boş olamaz.Yeniden deneyiniz.")
    }
    
    
    if tcInputField.text == ""{
        print("default empty")
    }
    
    print(tcInputField.text ?? "Empty TC")
    print(passwordInputField.text ?? "Empty password")
    
    if !TCEmpty && !passEmpty{
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

