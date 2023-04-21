//
//  ARViewModel.swift
//  Face Reality
//
//  Created by livia on 19/04/23.
//

import Foundation
import RealityKit
import SwiftUI
import ARKit

class ARViewModel: UIViewController, ObservableObject, ARSessionDelegate {
    @Published private var model : ARModel = ARModel()
    
    func startSessionDelegate() {
        model.arView.session.delegate = self
        
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            model.update(faceAnchor: faceAnchor)
        }
    }
    
    var arView : ARView {
        model.arView
    }
    
    var isSmiling: Bool {
        var helper = false
        if model.smileLeft > 0.3 || model.smileRight > 0.3 {
            helper = true
        }
        return helper
        
    }
    
    var genuineSmiling: Bool {
        var funnierHelper = false
        if model.smileLeft > 0.3 && model.smileRight > 0.3 && model.squintLeft > 0.15 && model.squintRight > 0.15 {
            funnierHelper = true
        }
        return funnierHelper
    }
    
    var isScowling: Bool {
        var angryHelper = false
        if model.sneerLeft > 0.17 && model.sneerRight > 0.17 && model.squintLeft > 0.05 && model.squintRight > 0.05 && model.frownRight > 0.2 && model.frownLeft > 0.2 {
            angryHelper = true
        }
        return angryHelper
    }
}
