//
//  QuoteModel.swift
//  FortuneCookie
//
//  Created by Chuyang Zhang on 7/2/24.
//

import Foundation
import Combine

class QuoteModel: ObservableObject {
    @Published var quoteText: String = "Toss the cookie to reveal your fortune!"
}
