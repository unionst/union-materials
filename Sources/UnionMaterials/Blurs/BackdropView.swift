//
//  BackdropView.swift
//  union-blurs
//
//  Created by Ben Sage on 3/8/25.
//

import SwiftUI

struct BackdropView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect()

        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)

        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}
