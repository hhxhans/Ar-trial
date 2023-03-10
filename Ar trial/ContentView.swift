//
//  ContentView.swift
//  Ar trial
//
//  Created by niudan on 2023/3/8.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
       
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        let mesh:MeshResource = .generatePlane(width: 0.5, depth: 0.5)
        
        var material=SimpleMaterial()
        material.metallic = .float(1)
        material.roughness = .float(1)
        material.color = .init(tint: .white.withAlphaComponent(0.99), texture: .init(try! .load(named:"biplane_2x")))
        let model=ModelEntity(mesh: mesh, materials: [material])
        boxAnchor.addChild(model)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
