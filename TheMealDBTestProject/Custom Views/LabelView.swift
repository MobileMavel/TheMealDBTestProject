//
//  LabelView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 19/02/2024.
//

import SwiftUI

struct LabelView: View {
    let text: String
    let font: Font
    @State var isBold: Bool = false
    @State var foregroundColor: Color = .black
    var body: some View {
        Text(text)
            .font(font)
            .bold(isBold)
            .foregroundColor(foregroundColor)
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(text: "", font: .callout)
    }
}
