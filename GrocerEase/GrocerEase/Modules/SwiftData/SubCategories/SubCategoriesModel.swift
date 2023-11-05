//
//  SubCategoriesModel.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftData

@Model
final public class SubCategoriesModel: Codable, Hashable, Identifiable {
    
    @Attribute(.unique) public var id: UUID = UUID()
    var typeId: Int?
    var typeName:String?
    var descripton: String?
    var thumbnailImage: String?
    var sliderImages: [String]?
    var pricePerPiece: Double?
    var weightPerPiece: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case typeId
        case typeName
        case description = "description"
        case thumbnailImage
        case sliderImages
        case pricePerPiece
        case weightPerPiece
    }
    
    required init() {}
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        typeId = try container.decodeIfPresent(Int.self, forKey: .typeId)
        typeName = try container.decodeIfPresent(String.self, forKey: .typeName)
        descripton = try container.decodeIfPresent(String.self, forKey: .description)
        thumbnailImage = try container.decodeIfPresent(String.self, forKey: .thumbnailImage)
        sliderImages = try container.decodeIfPresent([String].self, forKey: .sliderImages)
        pricePerPiece = try container.decodeIfPresent(Double.self, forKey: .pricePerPiece)
        weightPerPiece = try container.decodeIfPresent(Int.self, forKey: .weightPerPiece)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(typeId, forKey: .typeId)
        try container.encode(typeName, forKey: .typeName)
        try container.encode(descripton, forKey: .description)
        try container.encode(thumbnailImage, forKey: .thumbnailImage)
        try container.encode(sliderImages, forKey: .sliderImages)
        try container.encode(pricePerPiece, forKey: .pricePerPiece)
        try container.encode(weightPerPiece, forKey: .weightPerPiece)
    }
}
