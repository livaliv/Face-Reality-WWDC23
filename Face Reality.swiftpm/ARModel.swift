//
//  ARModel.swift
//  Face Reality
//
//  Created by livia on 19/04/23.
//

import Foundation
import RealityKit
import ARKit

struct ARModel {
    private(set) var arView : ARView
    
    init() {
        arView = ARView(frame: .zero)
        arView.session.run(ARFaceTrackingConfiguration())

    }
    
    var smileRight: Float = 0
    var smileLeft: Float = 0
    var squintRight: Float = 0
    var squintLeft: Float = 0
    var sneerRight: Float = 0
    var sneerLeft: Float = 0
    var frownRight: Float = 0
    var frownLeft: Float = 0
    
    mutating func update(faceAnchor: ARFaceAnchor){
        smileRight = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthSmileRight})?.value ?? 0)
        smileLeft = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthSmileLeft})?.value ?? 0)
        squintRight = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .eyeSquintRight})?.value ?? 0)
        squintLeft = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .eyeSquintLeft})?.value ?? 0)
        sneerRight = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .noseSneerRight})?.value ?? 0)
        sneerLeft = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .noseSneerLeft})?.value ?? 0)
        frownRight = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthFrownRight})?.value ?? 0)
        frownLeft = Float(truncating: faceAnchor.blendShapes.first(where: {$0.key == .mouthFrownLeft})?.value ?? 0)


        
    }
    
}
