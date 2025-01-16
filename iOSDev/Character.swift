//
//  Character.swift
//  iOSDev
//
//  Created by KAMA . on 16.01.2025.
//

struct APIResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let species: String
    let gender: String
    let location: Location
    let status: String
    let image: String
}

struct Location: Codable {
    let name: String
}
