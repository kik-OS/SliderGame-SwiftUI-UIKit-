//
//  SliderUIKit.swift
//  SliderGame
//
//  Created by Никита Гвоздиков on 21.12.2020.
//

import SwiftUI

struct SliderUIKit: UIViewRepresentable {
   
    
    @Binding var value: Double
    @Binding var alpha: CGFloat
    var action: () -> Void
    

    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.alpha = alpha
        slider.thumbTintColor = .red
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.valueChanged),
                         for: .valueChanged)
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.alpha = alpha
    }
    
    func makeCoordinator() -> SliderUIKit.Coordinator {
        Coordinator(value: $value, action: action)
    }
}

extension SliderUIKit {
    
    class Coordinator: NSObject {
        
        @Binding var value: Double
        var action: () -> Void
        
        init(value: Binding<Double>, action: @escaping () -> Void) {
            self._value = value
            self.action = action
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
            action()
        }
    }
}


struct ColorUiSlider_Previews: PreviewProvider {
    static var previews: some View {
        SliderUIKit(value: .constant(50), alpha: .constant(1)) {
        }
    }
}
