//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Łukasz Klimkiewicz on 19/09/2021.
//

import SwiftUI



struct BackgroundImageView : View {
    
    var body: some View {
        
//        Image("rocket")
//            .antialiased(true)
//            .resizable()
//            .scaledToFill()
//            .ignoresSafeArea(.all)
        
        LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0), Color.blue.opacity(0)]), startPoint: .leading, endPoint: .trailing)
            .scaledToFill()
            .ignoresSafeArea()
           
    }
    
}


struct BackgroundImageView_Previews: PreviewProvider {
    
    static var previews : some View {
        
        BackgroundImageView()
        
    }
    
}
