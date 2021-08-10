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
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func loadFirstTable() -> SCNNode{
        let tableMaterial = SCNMaterial()
        
        let img = textToImage(drawText: "Hoşgeldin", inImage: UIImage(named:"art.scnassets/temel.png")!, atPoint: CGPoint(x: 200, y: 80))
        
        let img2 = textToImage(drawText: "Mert Gökçen", inImage: img, atPoint: CGPoint(x: 200, y: 110))
        
        let img3 = textToImage(drawText: "Kart Borcu", inImage: img2, atPoint: CGPoint(x: 150, y: 150))
        
        let img4 = textToImage(drawText: "160TL", inImage: img3, atPoint: CGPoint(x: 160, y: 200))
        
        let img5 = textToImage(drawText: "Son İşlem", inImage: img4, atPoint: CGPoint(x: 150, y: 250))
        
        let img6 = textToImage(drawText: "333TL", inImage: img5, atPoint: CGPoint(x: 180, y: 350))
        
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
    
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.systemRed
            //UIColor(red: CGFloat(21), green: CGFloat(57), blue: CGFloat(18), alpha: CGFloat(0))
        let textFont = UIFont(name: "Helvetica Bold", size: 16)!

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
