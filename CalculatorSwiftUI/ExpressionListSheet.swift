//
//  ExpressionListSheet.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 18.11.2020.
//

import SwiftUI

struct ExpressionListSheet: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = ExpressionViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.expressions) { item in
                    Text("\(item.expression!) = \(item.answer!)")
                        .font(.system(size: 30))
                }
            }
            .toolbar(content: {
                Button(action: {
                    viewModel.deleteAll()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete All")
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            })
            
            .onAppear(perform: {
                self.viewModel.loadExpressions()
            })
            
        }
    }
}

struct ExpressionListSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExpressionListSheet()
    }
}
