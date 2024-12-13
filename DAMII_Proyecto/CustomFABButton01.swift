//
//  CustomFABButton01.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct CustomFABButton01: View {
    var action: () -> Void
    var icono: String
    var colorFondo: Color
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: icono)
                .padding()
        }
        .background(colorFondo)
        .foregroundColor(.white)
        .clipShape(Circle())
        
    }
}
