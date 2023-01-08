//
//  Rain.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import Foundation
import SpriteKit

final class Rain: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = .init(x: 0.5, y: 1)

        let node = SKEmitterNode(fileNamed: "Rain")!
        addChild(node)

        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}
