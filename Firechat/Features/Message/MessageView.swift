//
//  MessageView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 09/06/2023.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Text("Contextual type for closure.")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }.padding(8)
                .background(.orange)
                .roundedCorner(5, corners: [.bottomLeft, .topLeft, .topRight])
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
