//
//  Categories.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import Foundation
import SwiftData


@Model
final public class Categories: Codable, Hashable {
    
    @Attribute(.unique) public var id: UUID = UUID()
    var categoryId: Int?
    var categoryName: String?
    var categoryType:String?
    var categoryImage: String?
    var totalItems: Int?
    var subCategory:[SubCategoriesModel]?
    
    enum CodingKeys: String, CodingKey {
        case categoryId
        case categoryType
        case categoryName
        case categoryImage
        case totalItems
    }
    
    required init() {}
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        self.categoryType = try container.decodeIfPresent(String.self, forKey: .categoryType)
        self.categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName)
        self.categoryImage = try container.decodeIfPresent(String.self, forKey: .categoryImage)
        self.totalItems = try container.decodeIfPresent(Int.self, forKey: .totalItems)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(categoryType, forKey: .categoryType)
        try container.encode(categoryName, forKey: .categoryName)
        try container.encode(categoryImage, forKey: .categoryImage)
        try container.encode(totalItems, forKey: .totalItems)
    }
}
