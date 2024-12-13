//
//  CustomTextField01.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct CustomTextField01: View {
    var placeholder: String
    @Binding var texto: String
    
    var body: some View {
        TextField(placeholder, text: $texto)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
