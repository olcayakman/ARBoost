//
//  ViewController.swift
//  ARBoost
//
//  Created by Mert Gökçen on 3.08.2021.
//

import UIKit;import SceneKit;import ARKit

class ViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    
    
    @IBOutlet weak var tcInputField: UITextField!
    
    
    @IBOutlet weak var passwordInputField: UITextField!
    
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        tcInputField.resignFirstResponder()
        passwordInputField.resignFirstResponder()
    }
    
    var myUser:User = User(
        tckn: "123",
        name: "Mert",
        surname: "Gökçen",
        password: "mert")
    
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        print(cardInfo.cardNumber ?? "Couldn't read your card...")
        print("provide")
        self.dismiss(animated: true, completion: nil)
        let arViewController = self.storyboard?.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
        
        self.present(arViewController, animated: false, completion: nil)
    }
    

  @IBOutlet weak var resultLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    buttonOutlet.layer.cornerRadius = 20
    buttonOutlet.clipsToBounds = true
   
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
    self.view.addGestureRecognizer(tapGesture)
    
    // Do any additional setup after loading the view, typically from a nib.
    CardIOUtilities.preload()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated..
  }
    
    func alert(text:String) {
        let alert = UIAlertController(title: "Hata", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                fatalError()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
  
  @IBAction func scanCard(sender: AnyObject) {
    let arViewController = self.storyboard?.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
    
    self.present(arViewController, animated: false, completion: nil)
   
//    if ARWorldTrackingConfiguration.isSupported {
//        print("okay")
//        let TCEmpty = tcInputField.text == ""
//
//        let passwordEmpty = passwordInputField.text == ""
//
//        let TCCorrect:Bool =  tcInputField.text == myUser.tckn
//        let passwordCorrect:Bool = passwordInputField.text == myUser.password
//        var text:String
//        if TCEmpty{
//            text = "TC boş olamaz.Yeniden deneyiniz."
//            alert(text: text)
//            print("TC boş olamaz.Yeniden deneyiniz.")
//        }
//
//        else if passwordEmpty {
//            text = "Şifre boş olamaz.Yeniden deneyiniz."
//            alert(text: text)
//            print("Şifre boş olamaz.Yeniden deneyiniz.")
//        }
//
//        else if !TCCorrect {
//            text = "TC'niz yanlış.Yeniden deneyiniz."
//            alert(text: text)
//            print("TC'niz yanlış.Yeniden deneyiniz.")
//        }
//        else if !passwordCorrect{
//            text = "Şifrenizniz yanlış.Yeniden deneyiniz."
//            alert(text: text)
//            print("Şifrenizniz yanlış.Yeniden deneyiniz.")
//        }
//
//        else{
//
//            let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
//           cardIOVC!.modalPresentationStyle = .formSheet
//            cardIOVC?.hideCardIOLogo = true
//            cardIOVC?.suppressScanConfirmation = true
//            cardIOVC?.collectExpiry = false
//            cardIOVC?.collectCVV = false
//            present(cardIOVC!, animated: true, completion: nil)
//        }
//    }
//    else {
//        print("not supported")
//        alert(text: "Telefonunuz uygulamamızın bu özelliğini karşılamamaktadır.")
//    }

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

