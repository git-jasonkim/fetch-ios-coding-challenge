//
//  GetMealDetailsByIdResponse.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import Foundation

struct MealResponse: Codable {
    
    let meals: [MealData]?
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
    
    struct MealData: Codable {
        let id: String
        let name: String
        let thumbnail: String
        let drinkAlternate: String?
        let category: String?
        let area: String?
        let instructions: String?
        let tags: String?
        let youtube: String?
        let source: String?
        let imageSource: String?
        let creativeCommonsConfirmed: String?
        let dateModified: Double?
        var ingredients: [String]
        var measurements: [String]

        struct GenericCodingKeys: CodingKey {
            var stringValue: String
            var intValue: Int?

            init?(stringValue: String) { self.stringValue = stringValue }
            init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        }
        
        enum CodingKeys: String, CodingKey {
            case id = "idMeal"
            case name = "strMeal"
            case drinkAlternate = "strDrinkAlternate"
            case category = "strCategory"
            case area = "strArea"
            case instructions = "strInstructions"
            case thumbnail = "strMealThumb"
            case tags = "strTags"
            case youtube = "strYoutube"
            case source = "strSource"
            case imageSource = "strImageSource"
            case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
            case dateModified
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
            category = try container.decodeIfPresent(String.self, forKey: .category)
            area = try container.decodeIfPresent(String.self, forKey: .area)
            instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
            thumbnail = try container.decode(String.self, forKey: .thumbnail)
            tags = try container.decodeIfPresent(String.self, forKey: .tags)
            youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
            source = try container.decodeIfPresent(String.self, forKey: .source)
            imageSource = try container.decodeIfPresent(String.self, forKey: .imageSource)
            creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .creativeCommonsConfirmed)
            dateModified = try container.decodeIfPresent(Double.self, forKey: .dateModified)

            // Use dynamic GenericCodingKeys to extract each ingredient and measurement
            let genericContainer = try decoder.container(keyedBy: GenericCodingKeys.self)
            let ingredientsContainer = genericContainer.allKeys.filter { $0.stringValue.starts(with: "strIngredient") }.sorted { $0.stringValue.localizedStandardCompare($1.stringValue) == .orderedAscending }
            let measurementsContainer = genericContainer.allKeys.filter { $0.stringValue.starts(with: "strMeasure") }.sorted { $0.stringValue.localizedStandardCompare($1.stringValue) == .orderedAscending }
            
            self.ingredients = [String]()
            for key in ingredientsContainer {
                if let ingredient = try genericContainer.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
            }
            
            self.measurements = [String]()
            for key in measurementsContainer {
                if let measurement = try genericContainer.decodeIfPresent(String.self, forKey: key) {
                    measurements.append(measurement)
                }
            }
        }
    }
    
    
    public func toMeals() -> [Meal] {
        guard let meals = meals else { return [] }
        return meals.map {

            let instructions: [String] = { meal in
                if let instructions = meal.instructions {
                    return instructions.components(separatedBy: "\r\n").filter { !$0.isEmpty }
                }
                return []
            }($0)
            
            let ingredients: [Int: String] = { meal in
                var dict = [Int: String]()
                for (index, key) in meal.ingredients.enumerated() {
                    dict[index] = key
                }
                return dict
            }($0)
            
            let measurements: [Int: String] = { meal in
                var dict = [Int: String]()
                for (index, key) in meal.measurements.enumerated() {
                    dict[index] = key
                }
                return dict
            }($0)

            
            return Meal(id: $0.id, name: $0.name, thumbnail: $0.thumbnail, drinkAlternate: $0.drinkAlternate, category: $0.category, area: $0.area, instructions: instructions, tags: $0.tags, youtube: $0.youtube, ingredients: ingredients, measurements: measurements, source: $0.source, imageSource: $0.imageSource, creativeCommonsConfirmed: $0.creativeCommonsConfirmed, dateModified: $0.dateModified)
            
        }.sorted { $0.name < $1.name }
    }
}
