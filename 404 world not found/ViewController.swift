//
//  ViewController.swift
//  404 world not found
//
//  Created by Dilraj Devgun on 9/1/17.
//  Copyright © 2017 Dilraj Devgun. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
    
    @IBAction func didTapOnScreen(_ sender: Any) {
        
        let imagePlane = SCNPlane(width: 0.05, height: 0.02)
        
        let errorMaterial = SCNMaterial()
        errorMaterial .diffuse.contents = UIImage(named: "Error")
        errorMaterial.isDoubleSided = true
        
        
        imagePlane.materials = [errorMaterial]
        
        let planenode = SCNNode(geometry: imagePlane)
        self.sceneView.scene.rootNode.addChildNode(planenode)
        
        if let currentFrame = sceneView.session.currentFrame {
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let rotation = GLKMatrix4RotateZ(GLKMatrix4Identity, Float(Double.pi/2))
            let transform = simd_mul(currentFrame.camera.transform, simd_mul(rotation, translation))
            planenode.simdTransform = transform
        }
        //planenode.eulerAngles = SCNVector3(x: 0, y: 0, z: GLKMathDegreesToRadians(-90))
    }
}
