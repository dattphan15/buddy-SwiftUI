//
//  TypingIndicatorView.swift
//  buddy-SwiftUI
//
//  Created by phantom on 2023-05-18.
//

import SwiftUI

struct TypingIndicatorView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "ellipsis.bubble")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct TypingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        TypingIndicatorView()
    }
}
