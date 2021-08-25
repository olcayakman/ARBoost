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
    
    let userNetworkHandler = UserNetworkHandler()
    let creditCardNetworkHandler = CreditCardNetworkHandler()
    let transactionNetworkHandler = TransactionNetworkHandler()
    let debitCardNetworkHandler = DebitCardNetworkHandler()
    let autoPaymentNetworkHandler = AutoPaymentNetworkHandler()
    let accountNetworkHandler = AccountNetworkHandler()
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        tcInputField.resignFirstResponder()
        passwordInputField.resignFirstResponder()
    }
    
    var myUser:User? = nil
    var userCards:[String] = []
    var userDebitCards:[String] = []
    
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    func openCredit(_ number:String,img:UIImage?) {
        let arViewController = self.storyboard?.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
        
        if let safeImg = img{
            arViewController.cardToTrack = safeImg
        }
        
        arViewController.myUser = myUser
        arViewController.myCard =  creditCardNetworkHandler.getByCardNo(cardNo:number)
        arViewController.transactions = transactionNetworkHandler.getByCardNo(cardNo:number)
        arViewController.closestPaymnet = autoPaymentNetworkHandler.getNearestByCardNo(cardNo:number)
       
        if arViewController.myCard != nil {
            self.present(arViewController, animated: false, completion: nil)
        }
        else{
            alert(text: "Bir hata oluştu, daha sonra yeniden deneyiniz.")
        }
        
        
    }
    
    func openDebit(_ number:String,img:UIImage?) {
        let debitarViewController = self.storyboard?.instantiateViewController(withIdentifier: "DebitARViewController") as! DebitARViewController
        
        debitarViewController.myUser = myUser
        debitarViewController.myCard =  debitCardNetworkHandler.getByCardNo(cardNo:number)
        debitarViewController.transactions = transactionNetworkHandler.getByCardNo(cardNo: number)
        
        if let safeImg = img{
            debitarViewController.cardToTrack = safeImg
        }
        
        let tc = myUser?.tckn ?? "12"
        debitarViewController.account = accountNetworkHandler.getaccountByTC(tc: tc )
        if debitarViewController.myCard != nil {
            self.present(debitarViewController, animated: false, completion: nil)
        }
        else{
            alert(text: "Bir hata oluştu, daha sonra yeniden deneyiniz.")
        }
    }
    
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        print(cardInfo.cardNumber ?? "Couldn't read your card...")
        print("provide")

        self.dismiss(animated: true, completion: nil)

        userCards = creditCardNetworkHandler.getByTc(tc: myUser!.tckn)
        userDebitCards = debitCardNetworkHandler.getByTc(tc: myUser!.tckn)

        if userCards.contains(cardInfo.cardNumber) {
            print("Credit card entered")
            openCredit(cardInfo.cardNumber,img:cardInfo.cardImage)
        }

        else if userDebitCards.contains(cardInfo.cardNumber){
            print("Debit card entered")
            openDebit(cardInfo.cardNumber,img:cardInfo.cardImage)
        }

        else{
            alert(text: "Böyle bir kartınız bulunmamaktadır.")
        }
        userCards = []
        userDebitCards = []
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
        if ARWorldTrackingConfiguration.isSupported {
            print("okay")
            let TCEmpty = tcInputField.text == ""
            
            let passwordEmpty = passwordInputField.text == ""
            
            var text:String
            
            if TCEmpty{
                text = "TC boş olamaz.Yeniden deneyiniz."
                alert(text: text)
                print("TC boş olamaz.Yeniden deneyiniz.")
            }
            
            else if passwordEmpty {
                text = "Şifre boş olamaz.Yeniden deneyiniz."
                alert(text: text)
                print("Şifre boş olamaz.Yeniden deneyiniz.")
            }
            
            else{
                myUser = userNetworkHandler.getByTc(tc: tcInputField.text!)
                print("-------")
                if myUser == nil {
                    text = "TC'niz yanlış.Yeniden deneyiniz."
                    alert(text: text)
                    print("TC'niz yanlış.Yeniden deneyiniz.")
                }
                
                else if myUser!.password != passwordInputField.text{
                    
                    text = "Şifrenizniz yanlış.Yeniden deneyiniz."
                    alert(text: text)
                    print("Şifrenizniz yanlış.Yeniden deneyiniz.")
                }
                
                else{
                    
                    let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
                    cardIOVC!.modalPresentationStyle = .formSheet
                    cardIOVC?.hideCardIOLogo = true
                    cardIOVC?.suppressScanConfirmation = true
                    cardIOVC?.collectExpiry = false
                    cardIOVC?.collectCVV = false
                    present(cardIOVC!, animated: true, completion: nil)
                }
                
            }
            
        }
        else {
            print("not supported")
            alert(text: "Telefonunuz uygulamamızın bu özelliğini karşılamamaktadır.")
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

