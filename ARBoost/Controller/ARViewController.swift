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
        
        sceneView.scene.rootNode.addChildNode(loadFirstTable())
        
        let nodes = loadCircles()
        for node in nodes {
            sceneView.scene.rootNode.addChildNode(node)
        }
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func loadCircles()-> [SCNNode]{
        let textColor = UIColor(red: 0.40, green: 0.43, blue: 0.47, alpha: 0.75)
        
        let circleMaterial1 = SCNMaterial()
        let circleMaterial2 = SCNMaterial()
        let circleMaterial3 = SCNMaterial()
        
        let circle1 = SCNCylinder(radius: 0.02, height: 0)
        let circle2 = SCNCylinder(radius: 0.05, height: 0)
        let circle3 = SCNCylinder(radius: 0.05, height: 0)
        
        circle1.materials = [circleMaterial1]
        circle2.materials = [circleMaterial2]
        circle3.materials = [circleMaterial3]
        
        
        let circleNode1 = SCNNode()
        let circleNode2 = SCNNode()
        let circleNode3 = SCNNode()
        
        circleNode1.geometry = circle1
        circleNode2.geometry = circle2
        circleNode3.geometry = circle3
        
        circleMaterial1.diffuse.contents = UIImage(named: "art.scnassets/basılıkartlarımbutonu.png")!
            //textToImage(drawText: "Kartlarım", inImage: UIImage(named: "art.scnassets/basılıkartlarımbutonu.png")!, atPoint: CGPoint(x: 0, y: 0),textColor: textColor,textFont: UIFont(name: "Helvetica-Bold", size: 20)!)
        circleMaterial2.diffuse.contents = UIImage(named: "art.scnassets/kampanyalarbutonu.png")!
        circleMaterial3.diffuse.contents = UIImage(named: "art.scnassets/mobiledönüşbutonu.png")!
        
        
//        let translation = SCNMatrix4MakeTranslation(0, -1, 0)
//        let rotation = SCNMatrix4MakeRotation(Float.pi / 2, 0, 0, 1)
//        let transform = SCNMatrix4Mult(translation, rotation)
//
//        circleMaterial1.diffuse.contentsTransform = transform
//        circleMaterial2.diffuse.contentsTransform = transform
//        circleMaterial3.diffuse.contentsTransform = transform
        
        circleNode1.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
        circleNode2.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
        circleNode3.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
        
        
        
        circleNode1.position = SCNVector3(x: 0.16, y: 0.2, z: -0.5)
        circleNode2.position = SCNVector3(x: 0.16, y: 0.12, z: -0.5)
        circleNode3.position = SCNVector3(x: 0.16, y: 0.04, z: -0.5)
        
        //return [circleNode1]
        return [circleNode1,circleNode2,circleNode3]
    }
    
    func loadFirstTable() -> SCNNode{
        
        let tableMaterial = SCNMaterial()
    
        //Set appropriate colors
        let textColor = UIColor(red: 0.13, green: 0.34, blue: 0.51, alpha: 0.75)
        
        let debtTextColorNegative = UIColor(red: 0.67, green: 0.22, blue: 0.29, alpha: 1.00)
        
        let debtTextColorPositive = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 1.0)
        
        let lastTransactionColor = UIColor(red: 0.33, green: 0.49, blue: 0.62, alpha: 0.75)
        
        //----------------------
       
        //Add all texts to the table
        let img = textToImage(drawText: "Hoşgeldin", inImage: UIImage(named:"art.scnassets/temel.png")!, atPoint: CGPoint(x: 170, y: 75),textColor: textColor, textFont: UIFont(name: "Helvetica-Bold", size: 28)!)

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
        tableNode.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
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
