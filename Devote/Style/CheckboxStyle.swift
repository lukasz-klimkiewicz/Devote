//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Łukasz Klimkiewicz on 03/10/2021.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Configuration) -> some View {
        
        return HStack {
            
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? Color.pink : Color.primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        
        }
        
    }
    
    
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
