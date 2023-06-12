//
//  Extensions.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import Foundation
import SwiftUI

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
