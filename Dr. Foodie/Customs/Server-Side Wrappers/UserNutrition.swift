//
//  UserNutrition.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/28/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

// MARK: Properties
class UserNutrition {
    static let categories: [Category] = [
        Category(
            name: "Calories",
            units: "mg",
            suggestedValue: SuggestedValue(male: 2500, female: 2000, notSpecified: 2250),
            suggestedFoods: "red meats, pork, chicken with skin on (roast or broil don't deep fry for your health), salmon or other oily fish, beans, whole milk, eggs, cheese, full-fat yogurt",
            definition: "A calorie is a unit of measurement — but it doesn't measure weight or length. A calorie is a unit of energy. When you hear something contains 100 calories, it's a way of describing how much energy your body could get from eating or drinking it."
        ),
        Category(
            name: "Calcium",
            units: "mg",
            suggestedValue: SuggestedValue(male: 1200, female: 1200, notSpecified: 1000),
            suggestedFoods: "milk, yogurt, cheese, calcium-fortified beverages such as almond soy milk, dark-green leafy vegetables, dried peas and beans, fish with bones, and calcium-fortified juices and cereals",
            definition: "Calcium is a mineral that is necessary for life. In addition to building bones and keeping them healthy, calcium enables our blood to clot, our muscles to contract, and our heart to beat. About 99% of the calcium in our bodies is in our bones and teeth."
        ),
        Category(
            name: "Total Fat",
            units: "g",
            suggestedValue: SuggestedValue(male: 70, female: 45, notSpecified: 56),
            suggestedFoods: "avocados, cheese, dark chocolate, whole eggs, fatty fish, nuts, chia seeds, extra virgin olive oil",
            definition: "This includes the amount in grams (g) per serving of saturated fat and trans fat and the %DV of saturated fat. Food manufacturers may also voluntarily list the amount in grams (g) per serving of monounsaturated fat and polyunsaturated fat."
        ),
        Category(
            name: "Iron",
            units: "mg",
            suggestedValue: SuggestedValue(male: 9, female: 15, notSpecified: 12),
            suggestedFoods: "beans and lentils, tofu, baked potatoes, cashews, dark green leafy vegetables such as spinach, fortified breakfast cereals, whole-grain, and enriched breads",
            definition: "Iron is a mineral that our bodies need for many functions. For example, iron is part of hemoglobin, a protein which carries oxygen from our lungs throughout our bodies. It helps our muscles store and use oxygen. Iron is also part of many other proteins and enzymes. Your body needs the right amount of iron."
        ),
        Category(
            name: "Fiber",
            units: "g",
            suggestedValue: SuggestedValue(male: 30, female: 25, notSpecified: 27),
            suggestedFoods: "beans, lentils, broccoli, berries, avocados, popcorn, whole grains, apples, and dried fruits",
            definition: "Fiber, also known as roughage, is the part of plant-based foods (grains, fruits, vegetables, nuts, and beans) that the body can't break down. It passes through the body undigested, keeping your digestive system clean and healthy, easing bowel movements, and flushing cholesterol and harmful carcinogens out of the body."
        ),
        Category(
            name: "Potassium",
            units: "mg",
            suggestedValue: SuggestedValue(male: 3016, female: 2320, notSpecified: 3510),
            suggestedFoods: "bananas, oranges, cantaloupe, honeydew, apricots, grapefruit (some dried fruits, such as prunes, raisins, and dates, are also high in potassium), cooked spinac, cooked broccoli, potatoes, sweet potatoes, mushrooms, peas, cucumbers",
            definition: "Potassium is a mineral and an electrolyte. It helps your muscles work, including the muscles that control your heartbeat and breathing. Potassium comes from the food you eat. Your body uses the potassium it needs. The extra potassium that your body does not need is removed from your blood by your kidneys."
        ),
        Category(
            name: "Sodium",
            units: "mg",
            suggestedValue: SuggestedValue(male: 1600, female: 1600, notSpecified: 1600),
            suggestedFoods: "any fresh or frozen beef, lamb, pork, poultry and fish, eggs and egg substitutes, low-sodium peanut butter, dry peas and beans (not canned), low-sodium canned fish, drained water or oil packed canned fish or poultry",
            definition: "Sodium is an essential electrolyte that helps maintain the balance of water in and around your cells. It's important for proper muscle and nerve function. It also helps maintain stable blood pressure levels. Insufficient sodium in your blood is also known as hyponatremia."
        ),
        Category(
            name: "Protein",
            units: "g",
            suggestedValue: SuggestedValue(male: 56, female: 46, notSpecified: 50),
            suggestedFoods: "eggs (whole eggs are among the healthiest and most nutritious foods available), almonds, chicken breast. Chicken breast is one of the most popular protein-rich foods, oats, cottage cheese, greek yogurt, milk, broccoli",
            definition: "Proteins are essential nutrients for the human body. They are one of the building blocks of body tissue and can also serve as a fuel source. As a fuel, proteins provide as much energy density as carbohydrates: 4 kcal per gram; in contrast, lipids provide 9 kcal per gram."
        ),
        Category(
            name: "Sugars",
            units: "g",
            suggestedValue: SuggestedValue(male: 30, female: 20, notSpecified: 25),
            suggestedFoods: "green leafy vegetables, whole grains, fatty fish, beans, walnuts, citrus fruits, berries, sweet potatoes",
            definition: "Although the main reason for the use of sugar is its sweet taste, sugar has many other functions in food technology. The most important among these are that added sugar in foods acts as a sweetener, preservative, texture modifier, fermentation substrate, flavouring and colouring agent, bulking agent."
        ),
        Category(
            name: "Vitamin A",
            units: "IU",
            suggestedValue: SuggestedValue(male: 3000, female: 2333, notSpecified: 2750),
            suggestedFoods: "dairy products, liver, fish, fortified cereals, carrots, broccoli, cantaloupe, and squash",
            definition: "Vitamin A is a group of unsaturated nutritional organic compounds that includes retinol, retinal, and several provitamin A carotenoids. Vitamin A has multiple functions: it is important for growth and development, for the maintenance of the immune system, and for good vision."
        ),
        Category(
            name: "Vitamin B",
            units: "Âµg",
            suggestedValue: SuggestedValue(male: 16000, female: 14000, notSpecified: 15000),
            suggestedFoods: "whole grains (brown rice, barley, millet), meat (red meat, poultry, fish), eggs and dairy products (milk, cheese), legumes (beans, lentils), seeds and nuts (sunflower seeds, almonds), dark leafy vegetables (broccoli, spinach, kai lan), fruits (citrus fruits, avocados, bananas)",
            definition: "B vitamins play a vital role in maintaining good health and well-being. As the building blocks of a healthy body, B vitamins have a direct impact on your energy levels, brain function, and cell metabolism. Vitamin B complex helps prevent infections and helps support or promote: cell health."
        ),
        Category(
            name: "Vitamin C",
            units: "Âµg",
            suggestedValue: SuggestedValue(male: 90000, female: 65000, notSpecified: 80000),
            suggestedFoods: "broccoli, brussels sprouts, cauliflower, green and red peppers, spinach, cabbage, turnip greens, and other leafy greens, sweet and white potatoe, tomatoes and tomato juice, winter squash",
            definition: "Vitamin C, also known as ascorbic acid, has several important functions. 1: helping to protect cells and keeping them healthy. 2: maintaining healthy skin, blood vessels, bones and cartilage. 3: helping with wound healing."
        ),
        Category(
            name: "Vitamin D",
            units: "IU",
            suggestedValue: SuggestedValue(male: 1800, female: 1200, notSpecified: 1500),
            suggestedFoods: "fatty fish, like tuna, mackerel, salmon, dairy products, orange juice, soy milk, cereals, beef liver, cheese, egg yolks",
            definition: "Vitamin D helps regulate the amount of calcium and phosphate in the body. These nutrients are needed to keep bones, teeth and muscles healthy. A lack of vitamin D can lead to bone deformities such as rickets in children, and bone pain caused by a condition called osteomalacia in adults."
        ),
        Category(
            name: "Vitamin E",
            units: "Âµg",
            suggestedValue: SuggestedValue(male: 15000, female: 15000, notSpecified: 15000),
            suggestedFoods: "sunflower seeds, almonds, peanuts, some oils, avocados, spinach, swiss chard, butternut squash",
            definition: "Vitamin E: Important for stamina and energy, Vitamin E is also good for good blood circulation. You can get it in oily fish, eggs and dairy products. “It is also called 'sex vitamin' because it increases blood flow and oxygen to your genitalia,” says Dr Sharma."
        ),
        Category(
            name: "Vitamin K",
            units: "Âµg",
            suggestedValue: SuggestedValue(male: User.authorized()!.weight, female: User.authorized()!.weight, notSpecified: User.authorized()!.weight),
            suggestedFoods: "kale, collard greens, broccoli, spinach, cabbage, lettuce, and beef liver or other animal liver products",
            definition: "Vitamin K is a group of vitamins that the body needs for blood clotting, helping wounds to heal. There's also some evidence vitamin K may help keep bones healthy."
        ),
        Category(
            name: "Alcohol",
            units: "g",
            suggestedValue: SuggestedValue(male: 10, female: 10, notSpecified: 10),
            suggestedFoods: "nothing. The less you consume the better",
            definition: "The body treats alcohol as fat, converting alcohol sugars into fatty acids. Alcohol use inhibits absorption of nutrients. Not only is alcohol devoid of proteins, minerals, and vitamins, it actually inhibits the absorption and usage of vital nutrients such as thiamin (vitamin B1), vitamin B12, folic acid, and zinc."
        ),
        Category(
            name: "Caffeine",
            units: "mg",
            suggestedValue: SuggestedValue(male: 400, female: 400, notSpecified: 400),
            suggestedFoods: "organic chocolate, tea, and coffee",
            definition: "Caffeine consumption is generally considered safe, although habit forming. Some side effects linked to excess intake include anxiety, restlessness, tremors, irregular heartbeat, and trouble sleeping ( 53 ). Too much caffeine may also promote headaches, migraine, and high blood pressure in some individuals"
        ),
        Category(
            name: "Copper",
            units: "mg",
            suggestedValue: SuggestedValue(male: 1, female: 2, notSpecified: 1),
            suggestedFoods: "liver, oysters, spirulina, shiitake mushrooms, nuts and seeds, lobster, leafy greens, and dark chocolate",
            definition: "Copper is an essential nutrient for the body. Together with iron, it enables the body to form red blood cells. It helps maintain healthy bones, blood vessels, nerves, and immune function, and it contributes to iron absorption. Sufficient copper in the diet may help prevent cardiovascular disease and osteoporosis, too."
        ),
        Category(
            name: "Cysteine",
            units: "g",
            suggestedValue: SuggestedValue(male: Int((Double(User.authorized()!.weight) * 0.45359237) * 14), female: Int((Double(User.authorized()!.weight) * 0.45359237) * 14), notSpecified: Int((Double(User.authorized()!.weight) * 0.45359237) * 14)),
            suggestedFoods: "poultry, egg, beef, and whole grains",
            definition: "Cysteine may play a role in the normal growth rate of hair. Cysteine may also help reduce the effects of aging on the skin. It may help healing after surgery or burns and protect the skin from radiation injury. Cysteine may help burn fat and increase muscle mass."
        ),
        Category(
            name: "Energy",
            units: "kJ",
            suggestedValue: SuggestedValue(male: 8700, female: 8700, notSpecified: 8700),
            suggestedFoods: "bananas, fatty fish, brown rice, sweet potatoes, coffee, eggs, apples, and water",
            definition: "A kilojoule (like a calorie) is a measure of energy in food. On average, people eat and drink around 8700 kilojoules a day, however we're all different. To maintain your current weight, use your current (actual) body weight in the calculator below."
        ),
        Category(
            name: "Lactose",
            units: "g",
            suggestedValue: SuggestedValue(male: 36, female: 36, notSpecified: 36),
            suggestedFoods: "only milk (preferrably organic and from cow or goat)",
            definition: "Lactose promotes the growth of beneficial intestinal bacteria like Bifidobacterium bifidum and Lactobacilli, while inhibiting some types of pathogenic bacteria and endotoxins. Lactose may also increase resistance to intestinal infections among infants and children, and help maintain healthy intestinal flora. Only around 33% of the human population can successfully digest lactose without problems. This is because their history and culture consumes it regularly so their genetics has adapted to become tolerant."
        ),
        Category(
            name: "Magnesium",
            units: "mg",
            suggestedValue: SuggestedValue(male: 410, female: 340, notSpecified: 370),
            suggestedFoods: "greens, nuts, seeds, dry beans, whole grains, and low-fat dairy products",
            definition: "Magnesium plays many crucial roles in the body, such as supporting muscle and nerve function and energy production. Low magnesium levels don't cause symptoms in the short term. However, chronically low levels can increase the risk of high blood pressure, heart disease, type 2 diabetes and osteoporosis."
        ),
        Category(
            name: "Phosphorus",
            units: "mg",
            suggestedValue: SuggestedValue(male: 1596, female: 1189, notSpecified: 1300),
            suggestedFoods: "meats, poultry, fish, nuts, beans, and dairy products",
            definition: "High phosphorus levels can cause damage to your body. Extra phosphorus causes body changes that pull calcium out of your bones, making them weak. High phosphorus and calcium levels also lead to dangerous calcium deposits in blood vessels, lungs, eyes, and heart."
        ),
        Category(
            name: "Starch",
            units: "g",
            suggestedValue: SuggestedValue(male: 300, female: 275, notSpecified: 287),
            suggestedFoods: "potatoes, bread, cereal products, rice and grains, and pasta",
            definition: "Starchy foods are a good source of energy and the main source of a range of nutrients in our diet. As well as starch, they contain fibre, calcium, iron and B vitamins. Some people think starchy foods are fattening, but gram for gram they contain fewer than half the calories of fat."
        ),
        Category(
            name: "Valine",
            units: "g",
            suggestedValue: SuggestedValue(male: 12, female: 9, notSpecified: 10),
            suggestedFoods: "soy, cheese, peanuts, mushrooms, whole grains, and vegetables",
            definition: "Valine plays a vital role in energy supply of muscle tissue, which is particularly critical during periods of extensive physical stresses. Enhances muscle growth, improve hormone balance for greater power, strength, and endurance by increasing testosterone and decreasing cortisol."
        ),
        Category(
            name: "Zinc",
            units: "mg",
            suggestedValue: SuggestedValue(male: 11, female: 8, notSpecified: 9),
            suggestedFoods: "oysters, red meat and poultry, beans, nuts, certain types of seafood (such as crab and lobster), whole grains, fortified breakfast cereals, and dairy products",
            definition: "Zinc, a nutrient found throughout your body, helps your immune system and metabolism function. Zinc is also important to wound healing and your sense of taste and smell. With a varied diet, your body usually gets enough zinc. Food sources of zinc include chicken, red meat and fortified breakfast cereals."
        ),
    ]
}

// MARK: Methods
extension UserNutrition {
    static func information(for section: Section) -> [Suggestion] {
        var suggestions: [Suggestion] = []
        
        for category in categories {
            var value = 0
            for meal in JournalManager.meals {
                meal.nutritionInformation.dictionary.forEach { (item) in
                    if (item["name"] as! String) == category.name {
                        value += item["value"] as! Int
                    }
                }
            }
            switch section {
            case .today:
                suggestions.append(Suggestion(suggestedValue: category.suggestedValue.value, suggestedFoods: category.suggestedFoods, fact: Item(name: category.name, value: value, units: category.units, definition: category.definition)))
            case .total:
                suggestions.append(Suggestion(suggestedValue: nil, suggestedFoods: nil, fact: Item(name: category.name, value: value, units: category.units, definition: category.definition)))
            }
        }
        
        return suggestions
    }
}

// MARK: Organizers
extension UserNutrition {
    struct Category {
        var name: String
        var units: String
        var suggestedValue: SuggestedValue
        var suggestedFoods: String
        var definition: String
    }
    
    struct Item {
        var name: String
        var value: Int
        var units: String
        var definition: String
        
        var description: String {
            get {
                return "\(name): \(value) \(units)"
            }
        }
    }
    
    struct Suggestion {
        var suggestedValue: Int?
        var suggestedFoods: String?
        var fact: Item
        
        var description: String {
            get {
                if let _suggestedValue = suggestedValue {
                    if fact.value > _suggestedValue {
                        return "Doctors suggest that your daily intake be \(String(describing: suggestedValue)) \(fact.units). So... you might want to cut back on the \(fact.name.lowercased()) for today. And maybe be more mindful tomorrow. Maybe don't choose these foods for example: \(suggestedFoods ?? "(sorry, I don't have a list for you right now)")."
                    }
                    return "Looks like you haven't had much \(fact.name) so far. Be more mindful later today on what you're choosing to eat. I'd suggest having \(suggestedFoods ?? "(sorry, I don't have a list for you right now)")."
                } else {
                    return "Honestly, there really isn't that much help in looking at this information. But hey, why not? It's something."
                }
            }
        }
    }
    
    struct SuggestedValue {
        var male: Int
        var female: Int
        var notSpecified: Int
        
        var value: Int {
            get {
                return [
                    "Male": male,
                    "Female": female,
                    "Not Specified": notSpecified
                ][User.authorized()!.sex]!
            }
        }
    }
    
    enum Section {
        case today, total
    }
}
