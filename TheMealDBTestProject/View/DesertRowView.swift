//
//  MealRowView.swift
//  TheMealDBTestProject
//
//  Created by Dev on 19/02/2024.
//

import SwiftUI

struct DesertRowView: View {
    var title: String
    var imageURL: String
    var body: some View {
        HStack {
            AsyncImageView(url: imageURL)
                .frame(width: 100, height: 100)
                .background(Color.backgroundColor)
                .cornerRadius(10)
                .padding(.trailing, 5)
            VStack {
                LabelView(
                    text: title,
                    font: .title3,
                    isBold: true
                )
                .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top)
            Spacer()
        }
        .padding(.vertical, 3)
    }
}

struct DesertRowView_Previews: PreviewProvider {
    static var previews: some View {
        DesertRowView(title: "", imageURL: "")
    }
}
