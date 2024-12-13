//
//  ExpandableFAB.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct ExpandableFAB: View {
    @Binding var mostrandoBotones: Bool
    @Binding var mostrarFormRegistro: Bool
    @Binding var marcandoArticulos: Bool
    @Binding var eliminandoArticulos: Bool
    @Binding var listaVacia: Bool
    
    var body: some View {
        VStack {
            if mostrandoBotones {
                CustomFABButton01(
                    action: {
                        eliminandoArticulos = true
                        mostrandoBotones = false
                    },
                    icono: "trash",
                    colorFondo: listaVacia ? .gray : .blue
                )
                .disabled(listaVacia)
                
                CustomFABButton01(
                    action: {
                        marcandoArticulos = true
                        mostrandoBotones = false
                    },
                    icono: "checkmark",
                    colorFondo: listaVacia ? .gray : .blue
                )
                .disabled(listaVacia)
                
                CustomFABButton01(
                    action: {
                        mostrarFormRegistro = true
                        mostrandoBotones = false
                    },
                    icono: "plus",
                    colorFondo: .blue
                )
            }
            
            CustomFABButton01(
                action: {
                    self.mostrandoBotones.toggle()
                },
                icono: mostrandoBotones ? "chevron.down" : "chevron.up",
                colorFondo: mostrandoBotones ? .red : .green
            )
        }
        .padding(30)
        .animation(Animation.linear(duration: 0.5), value: mostrandoBotones)
    }
}
