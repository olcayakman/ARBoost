//
//  ViewController.swift
//  ARBoost
//
//  Created by Mert Gökçen on 9.08.2021.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var myUser:User? = nil
    var myCard: CreditCard? = nil
    var transactions:[Transaction] = []
    var closestPaymnet:AutoPayment? = nil
    var tables:[UIImage] = []
    var toDestroy:SCNNode? = nil
    var cardToTrack:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        tables = [loadWelcomeTable(),loadCardsTable(),loadPastTransactionsTable()
        ,loadWorldPointsTable(),loadSettingsTable()]
        
        let tableMaterial = SCNMaterial()
        
        let rectangle = SCNBox(width: 0.35, height: 0.35, length: 0, chamferRadius: 0.01)
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        let tablePosition:[Float] = [0.05,0,-0.6]
        tableNode.position = SCNVector3(x: tablePosition[0],
                                        y: tablePosition[1], z: tablePosition[2])
        tableMaterial.diffuse.contents = tables[0]
        tableNode.geometry = rectangle
        tableNode.name = "tableNode"
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        
        sceneView.scene.rootNode.addChildNode(tableNode)
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint,textColor:UIColor,textFont: UIFont) -> UIImage {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            
        ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func blendImages(bottomImage img: UIImage, topImage imgTwo: UIImage?,
        locX:CGFloat,locY:CGFloat,width:CGFloat,height:CGFloat) -> UIImage {
        let bottomImage = img
        if let topImage = imgTwo{
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height))
            
            let imgView2 = UIImageView(frame: CGRect(x: locX, y: locY, width: topImage.size.width + width, height: topImage.size.height + height))
         
            // - Set Content mode to what you desire
            imgView.contentMode = .scaleAspectFit
            imgView2.contentMode = .scaleAspectFit

            // - Set Images
            imgView.image = bottomImage
          
            imgView2.image = topImage
            // - Create UIView
            let contentView = UIView(frame: CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height))
            contentView.addSubview(imgView)
            contentView.addSubview(imgView2)
            // - Set Size
            let size = CGSize(width: bottomImage.size.width, height: bottomImage.size.height)

            // - Where the magic happens
            UIGraphicsBeginImageContextWithOptions(size, false, 0)

            contentView.drawHierarchy(in: contentView.bounds, afterScreenUpdates: true)
            
            guard let i = UIGraphicsGetImageFromCurrentImageContext(),
                  let data = i.jpegData(compressionQuality: 1.0)
                else {return img}

            UIGraphicsEndImageContext()
            return i
        }

        return img
    }
    
    
    func addTwoImages(bottomImage:UIImage,topImage:UIImage?,
                      locX:CGFloat,locY:CGFloat,width:CGFloat,height:CGFloat) -> UIImage {
        if let safeTopImage = topImage {
            let size = CGSize(width: bottomImage.size.width, height: bottomImage.size.height)
            
            //UIGraphicsBeginImageContext(size)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            
            let areaSize = CGRect(origin: CGPoint.zero, size: size)
            bottomImage.draw(in: areaSize)
            
            let areaSizeTop = CGRect(x: locX, y: locY, width: safeTopImage.size.width+width,
                                     height: safeTopImage.size.height+height)
            
            bottomImage.draw(in: areaSize,blendMode: CGBlendMode.normal,alpha: 1)
            
            safeTopImage.draw(in: areaSizeTop, blendMode: .normal, alpha: 1)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    
            UIGraphicsEndImageContext()
            return newImage
        }
        return bottomImage
       
    }
    
    
    
    func loadWelcomeTable() -> UIImage{
        
        let tableMaterial = SCNMaterial()
        
        //Set appropriate colors
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 0.75)
        
        let debtTextColorNegative = UIColor(red: 0.67, green: 0.22, blue: 0.29, alpha: 1.00)
        
        let debtTextColorPositive = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.0)
        
        let lastTransactionColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 0.75)
        
        //----------------------
        
        //Add all texts to the table
        let img = textToImage(drawText: "Hoşgeldin", inImage: UIImage(named:"art.scnassets/welcomeTable.png")!, atPoint: CGPoint(x: 170, y: 75),textColor: textColor, textFont: UIFont(name: "Helvetica-Bold", size: 28)!)
        
        let img2 = textToImage(drawText: myUser!.name+" "+myUser!.surname, inImage: img, atPoint: CGPoint(x: 170, y: 110),textColor: textColor,textFont: UIFont(name: "Helvetica", size: 24)!)
        
        let img3 = textToImage(drawText: "Kart Borcu", inImage: img2, atPoint: CGPoint(x: 70, y: 165),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: 16)!)
        var colorToUse = (myCard!.debt == 0) ? debtTextColorPositive : debtTextColorNegative;
        let img4 = textToImage(drawText: String(myCard!.debt), inImage: img3, atPoint: CGPoint(x: 100, y: 200),textColor: colorToUse,textFont: UIFont(name: "Helvetica", size: 25)!)
        
        let img5 = textToImage(drawText: "Son İşlem", inImage: img4, atPoint: CGPoint(x: 70, y: 250),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: 16)!)
        //TODO: Son islem tutarini cek
        let price = (transactions.count>=1) ? transactions[0].amount : 0 ;
        colorToUse = (price == 0) ? lastTransactionColor : debtTextColorNegative;
        let img6 = textToImage(drawText: String(price)+" TL", inImage: img5, atPoint: CGPoint(x: 100, y: 290),textColor: colorToUse,textFont: UIFont(name: "Helvetica", size: 25)!)
        
        //----------------------
        tableMaterial.diffuse.contents = img6
        
        let rectangle = SCNBox(width: 0.3, height: 0.3, length: 0, chamferRadius: 0.01)
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        let tablePosition:[Float] = [0,0.1,-0.55]
        tableNode.position = SCNVector3(x: tablePosition[0],
                                        y: tablePosition[1], z: tablePosition[2])
        tableNode.geometry = rectangle
        
        return img6
        
    }
    
    func loadSettingsTable()->UIImage{
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 1.00)
        
        let startX:Double = 60
        let startY:Double = 110
        
        let headerSize:CGFloat = 18.0
        let subHeaderSize:CGFloat = 16.0
        
        
        let dataColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        
        let contactlessButton = (myCard!.contactless) ? "on.png" : "off.png";
        let ecomButton = (myCard!.ecom) ? "on.png" : "off.png";
        let mailOrderButton = (myCard!.mailOrder) ? "on.png" : "off.png";
        
        
        let imgSet = blendImages(
            bottomImage: UIImage(named: "art.scnassets/settingsTable.png")!,
            topImage: UIImage(named: "art.scnassets/"+contactlessButton),
            locX: CGFloat(startX)+230, locY: CGFloat(startY)+40,
            width:CGFloat(0) , height: CGFloat(0))
        
        let imgSet2 = blendImages(
            bottomImage: imgSet,
            topImage: UIImage(named: "art.scnassets/"+ecomButton),
            locX: CGFloat(startX)+230, locY: CGFloat(startY)+65,
            width:CGFloat(0) , height: CGFloat(0))
        
        let imgSet3 = blendImages(
            bottomImage: imgSet2,
            topImage: UIImage(named: "art.scnassets/"+mailOrderButton),
            locX: CGFloat(startX)+230, locY: CGFloat(startY)+90,
            width:CGFloat(0) , height: CGFloat(0))
        
        let img = textToImage(drawText: "Kullanım Tercihleri", inImage:
                                imgSet3, atPoint: CGPoint(x: startX, y: startY),textColor: textColor, textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        let img2 = textToImage(drawText: "Temassız Özellik", inImage: img, atPoint: CGPoint(x: startX+5, y: startY+40),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img2_1 = textToImage(drawText: "İnternetten Alışveriş Yetkisi", inImage: img2, atPoint: CGPoint(x: startX+5, y: startY+65),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img3 = textToImage(drawText: "E-Hesap Özeti Talimatı", inImage: img2_1, atPoint: CGPoint(x: startX+5, y: startY+90),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img4 = textToImage(drawText: "Otomatik Ödeme Talimatı", inImage: img3, atPoint: CGPoint(x: startX, y: startY+140),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        var lastImg = textToImage(drawText: "Otomatik ödeme talimatınız bulunmamaktadır.", inImage: img4, atPoint: CGPoint(x: startX, y: startY+190),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize-2)!)
        
        if let safeclosestPaymnet = closestPaymnet {
    
            let img5 = textToImage(drawText: safeclosestPaymnet.receiver, inImage: img4, atPoint: CGPoint(x: startX+5, y: startY+180),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)

            let img5_1 = textToImage(drawText:String(safeclosestPaymnet.amount)+" TL", inImage: img5, atPoint: CGPoint(x: startX+200, y: startY+190),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)

            let img6 = textToImage(drawText: String(safeclosestPaymnet.paymentDay)+" "+safeclosestPaymnet.paymentMonth, inImage: img5_1, atPoint: CGPoint(x: startX+5, y: startY+200),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
            lastImg = img6
            
        }
       
        let img7 = textToImage(drawText: "Kart Son Kullanma Tarihi", inImage: lastImg, atPoint: CGPoint(x: startX+5, y: startY+230),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: subHeaderSize)!)

        let img8 = textToImage(drawText: myCard!.expMonth+"/"+myCard!.expYear, inImage: img7, atPoint: CGPoint(x: startX+200, y: startY+230),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)

       return img8
        
    }
    
    func loadWorldPointsTable() -> UIImage{
        let tableMaterial = SCNMaterial()
        let textColor = UIColor(red: 0.48, green: 0.17, blue: 0.51, alpha: 1.00)
        
        let img = textToImage(drawText: "Toplam World Puan", inImage: UIImage(named:"art.scnassets/worldPointsTable.png")!, atPoint: CGPoint(x: 70, y: 140),textColor: textColor, textFont: UIFont(name: "Helvetica-Bold", size: 20)!)
        
        let img2 = textToImage(drawText: String(myCard!.wordPoint)+" TL", inImage: img, atPoint: CGPoint(x: 120, y: 190),textColor: textColor,textFont: UIFont(name: "Helvetica", size: 20)!)
        
        return img2
        
    }
    
    func loadCardsTable() -> UIImage{
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 1.00)
        
        let startX:Double = 35
        let startY:Double = 120
        
        let dataSize:CGFloat = 16.0
        let headerSize:CGFloat = 18.0
        let subHeaderSize:CGFloat = 16.0
        
        
        let dataColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        
        let img = textToImage(drawText: "Toplam Limit", inImage: UIImage(named:"art.scnassets/cardsTable.png")!, atPoint: CGPoint(x: startX, y: startY),textColor: textColor, textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img2 = textToImage(drawText: "Kullanılabilir Limit", inImage: img, atPoint: CGPoint(x: startX, y: startY+30),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        
        let img3 = textToImage(drawText: String(myCard!.cardLimit) + " TL", inImage: img2, atPoint: CGPoint(x: startX+150, y: startY),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img4 = textToImage(drawText: String(myCard!.usableLimit)+" TL", inImage: img3, atPoint: CGPoint(x: startX+150, y: startY+30),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img5 = textToImage(drawText: "Ödeme Bilgileri", inImage: img4, atPoint: CGPoint(x: startX-5, y: startY+75),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        let img6 = textToImage(drawText: "Kart Borcu", inImage: img5, atPoint: CGPoint(x: startX, y: startY+110),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img7 = textToImage(drawText: String(myCard!.debt)+" TL", inImage: img6, atPoint: CGPoint(x: startX+150, y: startY+110),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img8 = textToImage(drawText: "Tarih Bilgileri", inImage: img7, atPoint: CGPoint(x: startX-5, y: startY+150),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        let img9 = textToImage(drawText: "Hesap Kesim Tarihi", inImage: img8, atPoint: CGPoint(x: startX, y: startY+190),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        
        
        let img10 = textToImage(drawText: dateFormatter.string(from: myCard!.cutOffDate), inImage: img9, atPoint: CGPoint(x: startX+180, y: startY+190),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img11 = textToImage(drawText: "Son Ödeme Tarihi", inImage: img10, atPoint: CGPoint(x: startX, y: startY+220),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img12 = textToImage(drawText: dateFormatter.string(from: myCard!.paymentDueDate), inImage: img11, atPoint: CGPoint(x: startX+180, y: startY+220),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        return img12
    }
    
    func loadPastTransactionsTable() -> UIImage{
        
        let startX:Double = 120
        let startY:Double = 110
        
        let dataSize:CGFloat = 13.0
        let companyNameSize:CGFloat = 13.0
        let dateSize:CGFloat = 11.0
        
        let dataColor = UIColor(red: 0.67, green: 0.22, blue: 0.29, alpha: 1.00)
        let companyNameColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        let dataColorPos = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        var toUseColor = dataColor
        
        let noTransactionText = "Yakın zamanda başka bir işleminiz bulunmamaktadır."
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        var lastImage:UIImage = UIImage(named:"art.scnassets/pastTransactionsTable.png")!
        
        if transactions.count>=1 {
            
            let tryImg = blendImages(bottomImage: UIImage(named:"art.scnassets/pastTransactionsTable.png")!, topImage: UIImage(named:"art.scnassets/"+transactions[0].type+".png"), locX: CGFloat(startX-50), locY: CGFloat(startY),width: CGFloat(-10),height:CGFloat(-10))
            
            let img = textToImage(drawText: transactions[0].reciever, inImage: tryImg, atPoint: CGPoint(x: startX, y: startY),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize)!)
            
            let img2 = textToImage(drawText:dateFormatter.string(from:transactions[0].date!), inImage: img, atPoint: CGPoint(x: startX, y: startY+20),textColor: companyNameColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
            
            toUseColor = (transactions[0].amount>=0) ? dataColorPos : dataColor;
            let img3 = textToImage(drawText: String(transactions[0].amount)+" TL", inImage: img2, atPoint: CGPoint(x: startX+150, y: startY+10),textColor: toUseColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
            lastImage = img3
            
            if transactions.count>=2 {
                
                let tryImg2 = blendImages(bottomImage: img3, topImage: UIImage(named:"art.scnassets/"+transactions[1].type+".png"), locX: CGFloat(startX-50), locY: CGFloat(startY+50),width: CGFloat(-10),height:CGFloat(-10))
                
                let img4 = textToImage(drawText: transactions[1].reciever, inImage: tryImg2, atPoint: CGPoint(x: startX, y: startY+50),textColor: companyNameColor,textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize)!)
                
                let img5 = textToImage(drawText: dateFormatter.string(from:transactions[1].date!), inImage: img4, atPoint: CGPoint(x: startX, y: startY+70),textColor: companyNameColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
                toUseColor = (transactions[1].amount>=0) ? dataColorPos : dataColor;
                let img6 = textToImage(drawText: String(transactions[1].amount)+" TL", inImage: img5, atPoint: CGPoint(x: startX+150, y: startY+60),textColor: toUseColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
                lastImage = img6
                if transactions.count>=3 {
                    
                    let tryImg3 = blendImages(bottomImage: img6, topImage: UIImage(named:"art.scnassets/"+transactions[2].type+".png"), locX: CGFloat(startX-50), locY: CGFloat(startY+100),width: CGFloat(-10),height:CGFloat(-10))
                    
                    let img7 = textToImage(drawText:transactions[2].reciever, inImage: tryImg3, atPoint: CGPoint(x: startX, y: startY+100),textColor: companyNameColor,textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize)!)
                    
                    let img8 = textToImage(drawText: dateFormatter.string(from:transactions[2].date!), inImage: img7, atPoint: CGPoint(x: startX, y: startY+120),textColor: companyNameColor,textFont: UIFont(name: "Helvetica-Bold", size: dateSize)!)
                    toUseColor = (transactions[2].amount>=0) ? dataColorPos : dataColor;
                    let img9 = textToImage(drawText: String(transactions[2].amount)+" TL", inImage: img8, atPoint: CGPoint(x: startX+150, y: startY+110),textColor: toUseColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
                    lastImage = img9
                    if transactions.count>=4 {
                        let tryImg4 = blendImages(bottomImage: img9, topImage: UIImage(named:"art.scnassets/"+transactions[3].type+".png"), locX: CGFloat(startX-50), locY: CGFloat(startY+150),width: CGFloat(-10),height:CGFloat(-10))
                        let img10 = textToImage(drawText: transactions[3].reciever, inImage: tryImg4, atPoint: CGPoint(x: startX, y: startY+150),textColor: companyNameColor,textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize)!)
                        
                        let img11 = textToImage(drawText: dateFormatter.string(from:transactions[3].date!), inImage: img10, atPoint: CGPoint(x: startX, y: startY+170),textColor: companyNameColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
                        toUseColor = (transactions[3].amount>=0) ? dataColorPos : dataColor;
                        let img12 = textToImage(drawText:  String(transactions[3].amount)+" TL", inImage: img11, atPoint: CGPoint(x: startX+150, y: startY+160),textColor: toUseColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
                        lastImage = img12
                        if transactions.count>=5 {
                            let tryImg5 = blendImages(bottomImage: img12, topImage: UIImage(named:"art.scnassets/"+transactions[4].type+".png"), locX: CGFloat(startX-50), locY: CGFloat(startY+200),width: CGFloat(-10),height:CGFloat(-10))
                            let img13 = textToImage(drawText: transactions[4].reciever, inImage: tryImg5, atPoint: CGPoint(x: startX, y: startY+200),textColor: companyNameColor,textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize)!)
                            
                            let img14 = textToImage(drawText: dateFormatter.string(from:transactions[4].date!), inImage: img13, atPoint: CGPoint(x: startX, y: startY+220),textColor: companyNameColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
                            toUseColor = (transactions[4].amount>=0) ? dataColorPos : dataColor;
                            let img15 = textToImage(drawText: String(transactions[4].amount)+" TL", inImage: img14, atPoint: CGPoint(x: startX+150, y: startY+210),textColor: toUseColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
                            lastImage = img15
                        }
                        
                        else {
                            lastImage = textToImage(drawText: noTransactionText, inImage:img12, atPoint: CGPoint(x: startX-50, y: startY+210),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-1)!)
                        }
                    }
                    
                    else {
                        let imgNo4 = textToImage(drawText: noTransactionText, inImage:img9, atPoint: CGPoint(x: startX-50, y: startY+160),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                        lastImage = textToImage(drawText: noTransactionText, inImage:imgNo4, atPoint: CGPoint(x: startX-50, y: startY+210),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                    }
                    
                }
                
                else {
                    let imgNo3 = textToImage(drawText: noTransactionText, inImage:img6, atPoint: CGPoint(x: startX-50, y: startY+110),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                    let imgNo4 = textToImage(drawText: noTransactionText, inImage:imgNo3, atPoint: CGPoint(x: startX-50, y: startY+160),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                    lastImage = textToImage(drawText: noTransactionText, inImage:imgNo4, atPoint: CGPoint(x: startX-50, y: startY+210),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                }
                
                
            }
            
            else{
                let imgNo2 = textToImage(drawText: noTransactionText, inImage: img3, atPoint: CGPoint(x: startX-50, y: startY+60),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                let imgNo3 = textToImage(drawText: noTransactionText, inImage:imgNo2, atPoint: CGPoint(x: startX-50, y: startY+110),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                let imgNo4 = textToImage(drawText: noTransactionText, inImage:imgNo3, atPoint: CGPoint(x: startX-50, y: startY+160),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
                lastImage = textToImage(drawText: noTransactionText, inImage:imgNo4, atPoint: CGPoint(x: startX-50, y: startY+210),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            }
        }
        
        else {
            //TODO:
            let imgNo = textToImage(drawText: noTransactionText, inImage: UIImage(named:"art.scnassets/pastTransactionsTable.png")!, atPoint: CGPoint(x: startX-50, y: startY+10),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            let imgNo2 = textToImage(drawText: noTransactionText, inImage: imgNo, atPoint: CGPoint(x: startX-50, y: startY+60),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            let imgNo3 = textToImage(drawText: noTransactionText, inImage:imgNo2, atPoint: CGPoint(x: startX-50, y: startY+110),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            let imgNo4 = textToImage(drawText: noTransactionText, inImage:imgNo3, atPoint: CGPoint(x: startX-50, y: startY+160),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            lastImage = textToImage(drawText: noTransactionText, inImage:imgNo4, atPoint: CGPoint(x: startX-50, y: startY+210),textColor: companyNameColor, textFont: UIFont(name: "Helvetica-Bold", size: companyNameSize-2)!)
            
        }
        
        
        return lastImage
    }
    
    
    
    func loadArrows(name:String, position pos:[Float],
                    rotation rot:[Float],size:[CGFloat],action:[CGFloat]) -> SCNNode{
        
        
        let pointAction = SCNAction.rotateBy(x: action[0], y: action[1], z: action[2], duration: 1)
        let pointAction2 = SCNAction.rotateBy(x: -action[0], y: -action[1], z: -action[2], duration: 1)
        let moveSequence = SCNAction.sequence([pointAction,pointAction2])
        
        let moveLoop = SCNAction.repeatForever(moveSequence)
        
        let tableMaterial = SCNMaterial()
        
        
        let img = UIImage(named: "art.scnassets/"+name)!
        
        tableMaterial.diffuse.contents = img
        let rectangle = SCNBox(width: size[0], height: size[1], length: size[2], chamferRadius: size[3])
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        
        tableNode.transform = SCNMatrix4MakeRotation(rot[0],rot[1],rot[2],rot[3])
        tableNode.position = SCNVector3(x: pos[0], y: pos[1], z: pos[2])
        tableNode.geometry = rectangle
        tableNode.runAction(moveLoop)
        return tableNode
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
        let configuration = ARImageTrackingConfiguration()
        
        if let card = cardToTrack {
            
            if let img = card.cgImage{
                let imageToTrack =   ARReferenceImage.init(img,
                orientation: CGImagePropertyOrientation.up, physicalWidth: CGFloat(0.08))
                //ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main)
                var mySet:Set<ARReferenceImage> = []
                mySet.insert(imageToTrack)
                configuration.trackingImages = mySet
                configuration.maximumNumberOfTrackedImages = 1
                print("Images successfully added.")
            }
            
            else{
                print("Images couldn't added.")
            }
            
        }
        
        else{
            print("Images couldn't added.")
        }

        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */

    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if let tableNode = sceneView.scene.rootNode.childNode(withName: "tableNode", recursively: true) {
            
            if let imageAnchor = anchor as? ARImageAnchor {
                let pos = imageAnchor.transform
                //print(pos.columns.3.y)
                let y = pos.columns.3.y
                let limit:Float = 0.05
                //print(y)
                if y >= limit {
                    tableNode.geometry?.firstMaterial?.diffuse.contents = tables[0]

                }
                else if y >= limit-0.06 {
                    tableNode.geometry?.firstMaterial?.diffuse.contents = tables[1]
                }
                else if y >= limit-0.12{
                    tableNode.geometry?.firstMaterial?.diffuse.contents = tables[2]
                }
                else if y >= limit-0.18 {
                    tableNode.geometry?.firstMaterial?.diffuse.contents = tables[3]
                }
                else{
                    tableNode.geometry?.firstMaterial?.diffuse.contents = tables[4]
                }

            }
            else{
                print("Error mert")
            }
        }
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: 0.05, height: 0.05)
            
            plane.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/directions.png")
            
       
            let textNode = SCNNode(geometry: plane)
            textNode.position = SCNVector3(x: 0.015,
                                            y: 0, z: 0)
            textNode.eulerAngles.x = -.pi/2
            //node.addChildNode(planeNode)
            node.addChildNode(textNode)
            //backNode.addChildNode(planeNode)
            
            toDestroy = textNode
            Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(destroyWriting), userInfo: nil, repeats: false)
            
        }
        
        return node
    }
    
    @objc func destroyWriting(){
        if let destroy = toDestroy {
            destroy.removeFromParentNode()
        }
    }
    
}
