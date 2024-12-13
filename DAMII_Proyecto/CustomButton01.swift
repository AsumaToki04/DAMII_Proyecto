//
//  CustomButton01.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct CustomButton01: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(text, action: {
            action()
        })
        .buttonStyle(BorderedButtonStyle())
        .foregroundColor(.white)
        .background(.blue)
        .cornerRadius(8)
    }
}
