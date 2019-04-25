//
//  PirateData.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import Foundation

import Foundation

struct PirateData: Decodable {
    let success: Bool
    let ships: [Ship?]
}

struct Ship: Decodable {
    let id: Int
    let title: String?
    let description: String
    let price: Int
    let image: String
    let greeting: Greeting
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case greeting = "greeting_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        price = try container.decode(Int.self, forKey: .price)
        image = try container.decode(String.self, forKey: .image)
        greeting = try container.decodeIfPresent(Greeting.self, forKey: .greeting) ?? .ahoy
    }
}

enum Greeting: String, Decodable {

    case ahoy = "ah"
    case aye = "ay"
    case arr = "ar"
    case yoho = "yo"
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "ah": self = .ahoy
        case "ay": self = .aye
        case "ar": self = .arr
        default: self = .ahoy
        }
    }

    var description: String {
        switch self {
        case .ahoy:
            return "Ahoy!"
        case .aye:
            return "Aye Aye!"
        case .arr:
            return "Arrr!"
        case .yoho:
            return "Yo ho hooo!"
        }
    }
}

extension PirateData {
    
    private static let pathURLString = "pirateships"
    
    static var resource: Resource<PirateData> {
        let components = URLComponents(url: APIConfig.baseURL, resolvingAgainstBaseURL: true)
        
        let url = components?.url?.appendingPathComponent(PirateData.pathURLString) !! "Error appending path"
        
        return Resource(url: url)
    }
}
