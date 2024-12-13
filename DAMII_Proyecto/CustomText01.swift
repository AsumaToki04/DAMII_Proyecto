//
//  CustomText01.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct CustomText01: View {
    var texto: String
    var comprado: Bool
    var esHeadline: Bool = false
    
    var body: some View {
        Text(texto)
            .font(comprado || !esHeadline ? .subheadline : .headline)
            .foregroundColor(comprado ? .gray : .black)
    }
}
