//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Adam Sayer on 8/8/2024.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
