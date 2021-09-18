//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Łukasz Klimkiewicz on 18/09/2021.
//

import SwiftUI


#if canImport(UIKit)

extension View {
    
    func hideKeyboard() {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
}

#endif


