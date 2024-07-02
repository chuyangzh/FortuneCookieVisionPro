//
//  ImmersiveView.swift
//  FortuneCookie
//
//  Created by Chuyang Zhang on 6/30/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct ImmersiveView: View {
    
    
    
    @EnvironmentObject var quoteModel: QuoteModel  // Observe the shared model

    

    
    var body: some View {
        RealityView { content in
            
            let floor = ModelEntity(mesh: .generatePlane(width: 50, depth: 50), materials: [OcclusionMaterial()])
            floor.generateCollisionShapes(recursive: false)
            floor.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            
            content.add(floor)
            
            if let cookieModel = try? await Entity(named: "Fortune_Cookie copy"),
               let scene = cookieModel.children.first,
               let meshes = scene.children.first,
               let sketchfabModel = meshes.children.first,
               let usdRoot = sketchfabModel.children.first,
               let fortuneCookieAltered = usdRoot.children.first,
               let geom = fortuneCookieAltered.children.first,
               let fortuneCooke = geom.children.first,
               let geom2 = fortuneCooke.children.first,
               let g01 = geom2.children.first,
               let g02 = g01.children.first,
               let cookie = g02.children.first,
    
               let enivronment = try? await EnvironmentResource(named: "studio") {
                cookie.scale = [2, 2, 2]
                cookie.position.y = 0.5
                cookie.position.z = -1
                
                cookie.generateCollisionShapes(recursive: false)
                cookie.components.set(InputTargetComponent())
                
                cookie.components.set(ImageBasedLightComponent(source: .single(enivronment)))
                cookie.components.set(ImageBasedLightReceiverComponent(imageBasedLight: cookie))
                cookie.components.set(GroundingShadowComponent(castsShadow: true))
                
                cookie.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .generate(staticFriction: 0.8, dynamicFriction: 0.5, restitution: 0.7),
                    mode: .dynamic
                ))
                
                cookie.components[PhysicsMotionComponent.self] = .init()
                
                
                content.add(cookie)
                

            }
            
            
        }
        .gesture(dragGesture)
        Text(quoteModel.quoteText)
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    
    
    func fetchRandomQuote() {
        guard let url = URL(string: "https://www.affirmations.dev") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Affirmation.self, from: data) {
                    DispatchQueue.main.async {
                        self.quoteModel.quoteText = decodedResponse.affirmation  // Update the shared model
                    }
                } else {
                    print("Failed to decode response")
                }
            }
            if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
    }
    
    
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
            }
            .onEnded { value in
                value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                fetchRandomQuote()
                

            }
    }
}

struct Affirmation: Codable {
    let affirmation: String
}


#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
