//
//  SliderUIKit.swift
//  SliderGame
//
//  Created by Никита Гвоздиков on 21.12.2020.
//

import SwiftUI

//подписываем под протокол и выполняем обязательные методы
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
        //вызываем метод для использования функции передачи значения
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.valueChanged),
                         for: .valueChanged)
        
        return slider
    }
    
    //что происходит при изменении значений slidera
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.alpha = alpha
    }
    
    //вызываем обязательный метод, созданный ниже
    func makeCoordinator() -> SliderUIKit.Coordinator {
        Coordinator(value: $value, action: action)
    }
    
}

//отдельный класс чтобы рабоатало передача значений из слайдера во вне
//класс должен брать значения из слайдера и передавать в переменную
extension SliderUIKit {
    
    class Coordinator: NSObject {
        @Binding var value: Double
        
        var action: () -> Void
        //создаем инициализатор потому что это класс
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
