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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        sceneView.scene.rootNode.addChildNode(loadWelcomeTable())
        
        
//        sceneView.scene.rootNode.addChildNode(loadKartlarımText(position: [0.166, 0.18, -0.5], rotation: [0,0,0,0]))
//        for node in loadCircles(rotation: [0,0,0,0],positionFirst: [0.166, 0.18, -0.5] ) {
//            sceneView.scene.rootNode.addChildNode(node)
//        }
        
//        sceneView.scene.rootNode.addChildNode(loadKartlarımText(position: [0.9,0.18,-0.7], rotation: [-Float.pi/5,0 , 1, 0]))
//
        
        sceneView.scene.rootNode.addChildNode(loadCardsTable())
        
        sceneView.scene.rootNode.addChildNode(loadPastTransactionsTable())
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func loadKartlarımText(position pos:[Float], rotation rot:[Float])->SCNNode{
        let textColor = UIColor(red: 0.40, green: 0.43, blue: 0.47, alpha: 0.75)
        
        let textMaterial = SCNMaterial()
        
        let text = SCNText(string: "Kartlarım", extrusionDepth: 2)
        
        
        textMaterial.diffuse.contents = textColor
        text.materials = [textMaterial]
        
        let textNode = SCNNode()
        
        textNode.geometry = text
        
        textNode.transform = SCNMatrix4MakeRotation(rot[0], rot[1], rot[2], rot[3])
        
        textNode.position = SCNVector3(x: pos[0]-0.016, y: pos[1]+0.025, z: pos[2])
        
        
        textNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
        
        return textNode
    }
    
    func loadCircles(rotation rot:[Float], positionFirst pos:[Float] )-> [SCNNode]{
        
        let textColor = UIColor(red: 0.40, green: 0.43, blue: 0.47, alpha: 0.75)
        
        let textMaterial = SCNMaterial()
        let circleMaterial1 = SCNMaterial()
        let circleMaterial2 = SCNMaterial()
        let circleMaterial3 = SCNMaterial()
        
        let text = SCNText(string: "Kartlarım", extrusionDepth: 2)
        let circle1 = SCNCylinder(radius: 0.02, height: 0)
        let circle2 = SCNCylinder(radius: 0.06, height: 0)
        let circle3 = SCNCylinder(radius: 0.06, height: 0)
        
        textMaterial.diffuse.contents = textColor
        text.materials = [textMaterial]
        
        circle1.materials = [circleMaterial1]
        circle2.materials = [circleMaterial2]
        circle3.materials = [circleMaterial3]
        
        let textNode = SCNNode()
        let circleNode1 = SCNNode()
        let circleNode2 = SCNNode()
        let circleNode3 = SCNNode()
        
        textNode.geometry = text
        circleNode1.geometry = circle1
        circleNode2.geometry = circle2
        circleNode3.geometry = circle3
        
        circleMaterial1.diffuse.contents = UIImage(named: "art.scnassets/cardsButton.png")!
        circleMaterial2.diffuse.contents = UIImage(named: "art.scnassets/giftPackageButton.png")!
        circleMaterial3.diffuse.contents = UIImage(named: "art.scnassets/mobileButton.png")!
        
        
        let mat = SCNMatrix4MakeRotation(Float.pi/2,1,0,0)
        
        //Rotation
        circleNode1.transform = SCNMatrix4Rotate(mat, rot[0], rot[1], rot[2], rot[3])
        circleNode2.transform = SCNMatrix4Rotate(mat, rot[0], rot[1], rot[2], rot[3])
        circleNode3.transform = SCNMatrix4Rotate(mat, rot[0], rot[1], rot[2], rot[3])
        
        //Position
        circleNode1.position = SCNVector3(x: pos[0], y: pos[1], z: pos[2])
        circleNode2.position = SCNVector3(x: pos[0]-0.006, y: pos[1]-0.08, z: pos[2])
        circleNode3.position = SCNVector3(x: pos[0]-0.006, y: pos[1]-0.16, z: pos[2])
        textNode.position = SCNVector3(x: pos[0]-0.016, y: pos[1]+0.025, z: pos[2])
        
//        circleNode1.position = SCNVector3(x: 0.166, y: 0.18, z: -0.5)
//        circleNode2.position = SCNVector3(x: 0.16, y: 0.10, z: -0.5)
//        circleNode3.position = SCNVector3(x: 0.16, y: 0.02, z: -0.5)
//        textNode.position = SCNVector3(x: 0.15, y: 0.205, z: -0.5)
        textNode.scale = SCNVector3(x:0.001, y:0.001, z:0.001)
        //textNode
        return [circleNode1,circleNode2,circleNode3]
    }
    
    //This function probably draws an arrow
    //Haven't checked it yet
    //Will check later
    func drawArrow() -> SCNNode{
        let vertcount = 48;
            let verts: [Float] = [ -1.4923, 1.1824, 2.5000, -6.4923, 0.000, 0.000, -1.4923, -1.1824, 2.5000, 4.6077, -0.5812, 1.6800, 4.6077, -0.5812, -1.6800, 4.6077, 0.5812, -1.6800, 4.6077, 0.5812, 1.6800, -1.4923, -1.1824, -2.5000, -1.4923, 1.1824, -2.5000, -1.4923, 0.4974, -0.9969, -1.4923, 0.4974, 0.9969, -1.4923, -0.4974, 0.9969, -1.4923, -0.4974, -0.9969 ];

            let facecount = 13;
            let faces: [CInt] = [  3, 4, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 0, 1, 2, 3, 4, 5, 6, 7, 1, 8, 8, 1, 0, 2, 1, 7, 9, 8, 0, 10, 10, 0, 2, 11, 11, 2, 7, 12, 12, 7, 8, 9, 9, 5, 4, 12, 10, 6, 5, 9, 11, 3, 6, 10, 12, 4, 3, 11 ];

            let vertsData  = NSData(
                bytes: verts,
                length: MemoryLayout<Float>.size * vertcount
            )

            let vertexSource = SCNGeometrySource(data: vertsData as Data,
                                                 semantic: .vertex,
                                                 vectorCount: vertcount,
                                                 usesFloatComponents: true,
                                                 componentsPerVector: 3,
                                                 bytesPerComponent: MemoryLayout<Float>.size,
                                                 dataOffset: 0,
                                                 dataStride: MemoryLayout<Float>.size * 3)

            let polyIndexCount = 61;
            let indexPolyData  = NSData( bytes: faces, length: MemoryLayout<CInt>.size * polyIndexCount )

            let element1 = SCNGeometryElement(data: indexPolyData as Data,
                                              primitiveType: .polygon,
                                              primitiveCount: facecount,
                                              bytesPerIndex: MemoryLayout<CInt>.size)

            let geometry1 = SCNGeometry(sources: [vertexSource], elements: [element1])

            let material1 = geometry1.firstMaterial!

            material1.diffuse.contents = UIColor(red: 0.14, green: 0.82, blue: 0.95, alpha: 1.0)
            material1.lightingModel = .lambert
            material1.transparency = 1.00
            material1.transparencyMode = .dualLayer
            material1.fresnelExponent = 1.00
            material1.reflective.contents = UIColor(white:0.00, alpha:1.0)
            material1.specular.contents = UIColor(white:0.00, alpha:1.0)
            material1.shininess = 1.00

            //Assign the SCNGeometry to a SCNNode, for example:
            let aNode = SCNNode()
            aNode.geometry = geometry1
            //aNode.scale = SCNVector3(0.1, 0.1, 0.1)
            return aNode
    }
    
    func loadPastTransactionsTable() -> SCNNode{
        let tableMaterial = SCNMaterial()
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 1.00)
        
        let startX:Double = 100
        let startY:Double = 110
        
        let dataSize:CGFloat = 16.0
        let companyNameSize:CGFloat = 18.0
        let dateSize:CGFloat = 16.0
        
        
        let dataColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        
        let img = textToImage(drawText: "Mavi Giyim AŞ", inImage: UIImage(named:"art.scnassets/pastTransactionsTable.png")!, atPoint: CGPoint(x: startX, y: startY),textColor: textColor, textFont: UIFont(name: "Helvetica", size: companyNameSize)!)

        let img2 = textToImage(drawText: "25 Temmuz", inImage: img, atPoint: CGPoint(x: startX, y: startY+20),textColor: textColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
        
        let img3 = textToImage(drawText: "2350,80TL", inImage: img2, atPoint: CGPoint(x: startX+150, y: startY+10),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img4 = textToImage(drawText: "Migros Ticaret AŞ", inImage: img3, atPoint: CGPoint(x: startX, y: startY+50),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: companyNameSize)!)
    
        
        let img5 = textToImage(drawText: "24 Temmuz", inImage: img4, atPoint: CGPoint(x: startX, y: startY+70),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: dateSize)!)
        
        let img6 = textToImage(drawText: "85,70TL", inImage: img5, atPoint: CGPoint(x: startX+150, y: startY+80),textColor: textColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img7 = textToImage(drawText: "Sephora Kozmetik AŞ", inImage: img6, atPoint: CGPoint(x: startX, y: startY+110),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: companyNameSize)!)
        
        let img8 = textToImage(drawText: "16 Temmuz", inImage: img7, atPoint: CGPoint(x: startX, y: startY+130),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: dateSize)!)
        
        let img9 = textToImage(drawText: "-605,13", inImage: img8, atPoint: CGPoint(x: startX+150, y: startY+120),textColor: textColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img10 = textToImage(drawText: "IYZICO*AMZNPRIMETR", inImage: img9, atPoint: CGPoint(x: startX, y: startY+190),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: companyNameSize)!)
        
        let img11 = textToImage(drawText: "13 Temmuz", inImage: img10, atPoint: CGPoint(x: startX, y: startY+220),textColor: textColor,textFont: UIFont(name: "Helvetica", size: dateSize)!)
        
        let img12 = textToImage(drawText: "-7,90", inImage: img11, atPoint: CGPoint(x: startX+150, y: startY+220),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        tableMaterial.diffuse.contents = img12
        let rectangle = SCNBox(width: 0.45, height: 0.45, length: 0, chamferRadius: 0.01)
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        
        tableNode.geometry = rectangle
        
        tableNode.transform = SCNMatrix4MakeRotation(-Float.pi/2,0 , 1, 0)
        tableNode.position = SCNVector3(x: 0.7, y: 0.1, z: 0)
        
        return tableNode
        
        
    }
    
    
    func loadCardsTable() -> SCNNode{
        let tableMaterial = SCNMaterial()
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 1.00)
        
        let startX:Double = 35
        let startY:Double = 120
        
        let dataSize:CGFloat = 16.0
        let headerSize:CGFloat = 18.0
        let subHeaderSize:CGFloat = 16.0
        
        
        let dataColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.00)
        
        let img = textToImage(drawText: "Bakiye", inImage: UIImage(named:"art.scnassets/cardsTable.png")!, atPoint: CGPoint(x: startX, y: startY),textColor: textColor, textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)

        let img2 = textToImage(drawText: "Kullanılabilir Limit", inImage: img, atPoint: CGPoint(x: startX, y: startY+30),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img3 = textToImage(drawText: "2350,80TL", inImage: img2, atPoint: CGPoint(x: startX+150, y: startY),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img4 = textToImage(drawText: "3649,20TL", inImage: img3, atPoint: CGPoint(x: startX+150, y: startY+30),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
    
        
        let img5 = textToImage(drawText: "Ödeme Bilgileri", inImage: img4, atPoint: CGPoint(x: startX-5, y: startY+75),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        let img6 = textToImage(drawText: "Kart Borcu", inImage: img5, atPoint: CGPoint(x: startX, y: startY+110),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img7 = textToImage(drawText: "2350,80TL", inImage: img6, atPoint: CGPoint(x: startX+150, y: startY+110),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img8 = textToImage(drawText: "Tarih Bilgileri", inImage: img7, atPoint: CGPoint(x: startX-5, y: startY+150),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: headerSize)!)
        
        let img9 = textToImage(drawText: "Hesap Kesim Tarihi", inImage: img8, atPoint: CGPoint(x: startX, y: startY+190),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img10 = textToImage(drawText: "05/07/2021", inImage: img9, atPoint: CGPoint(x: startX+180, y: startY+190),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        let img11 = textToImage(drawText: "Son Ödeme Tarihi", inImage: img10, atPoint: CGPoint(x: startX, y: startY+220),textColor: textColor,textFont: UIFont(name: "Helvetica", size: subHeaderSize)!)
        
        let img12 = textToImage(drawText: "16/07/2021", inImage: img11, atPoint: CGPoint(x: startX+180, y: startY+220),textColor: dataColor,textFont: UIFont(name: "Helvetica", size: dataSize)!)
        
        tableMaterial.diffuse.contents = img12
        let rectangle = SCNBox(width: 0.45, height: 0.45, length: 0, chamferRadius: 0.01)
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        
        tableNode.geometry = rectangle
        
        tableNode.transform = SCNMatrix4MakeRotation(-Float.pi/5,0 , 1, 0)
        tableNode.position = SCNVector3(x: 0.55, y: 0.1, z: -0.75)
        
        return tableNode
        
        
    }
    
    func loadWelcomeTable() -> SCNNode{
        
        let tableMaterial = SCNMaterial()
    
        //Set appropriate colors
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 0.75)
        
        let debtTextColorNegative = UIColor(red: 0.67, green: 0.22, blue: 0.29, alpha: 1.00)
        
        let debtTextColorPositive = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.0)
        
        let lastTransactionColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 0.75)
        
        //----------------------
       
        //Add all texts to the table
        let img = textToImage(drawText: "Hoşgeldin", inImage: UIImage(named:"art.scnassets/welcomeTable1.png")!, atPoint: CGPoint(x: 170, y: 75),textColor: textColor, textFont: UIFont(name: "Helvetica-Bold", size: 28)!)

        let img2 = textToImage(drawText: "Mert Gökçen", inImage: img, atPoint: CGPoint(x: 170, y: 110),textColor: textColor,textFont: UIFont(name: "Helvetica", size: 24)!)
        
        let img3 = textToImage(drawText: "Kart Borcu", inImage: img2, atPoint: CGPoint(x: 70, y: 165),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: 16)!)
        
        let img4 = textToImage(drawText: "-160TL", inImage: img3, atPoint: CGPoint(x: 100, y: 200),textColor: debtTextColorNegative,textFont: UIFont(name: "Helvetica", size: 25)!)
        
        let img5 = textToImage(drawText: "Son İşlem", inImage: img4, atPoint: CGPoint(x: 70, y: 250),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: 16)!)
        
        let img6 = textToImage(drawText: "333TL", inImage: img5, atPoint: CGPoint(x: 100, y: 290),textColor: lastTransactionColor,textFont: UIFont(name: "Helvetica-Bold", size: 25)!)
        
        //----------------------
        
        tableMaterial.diffuse.contents = img6
        
        let rectangle = SCNBox(width: 0.3, height: 0.3, length: 0, chamferRadius: 0.01)
        rectangle.materials = [tableMaterial]
        let tableNode = SCNNode()
        tableNode.position = SCNVector3(x: 0, y: 0.1, z: -0.55)
        tableNode.geometry = rectangle
        
        
        return tableNode
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

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
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
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
}
