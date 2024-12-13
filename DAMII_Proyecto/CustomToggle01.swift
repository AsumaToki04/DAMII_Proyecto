//
//  CustomToggle01.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct CustomToggle01: View {
    var text: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
        }
        .toggleStyle(ButtonToggleStyle())
        .buttonStyle(BorderedButtonStyle())
        .foregroundColor(isOn ? .blue : .gray)
    }
}
