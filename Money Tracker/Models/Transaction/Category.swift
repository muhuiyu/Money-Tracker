//
//  Category.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation

typealias CategoryID = String

// MARK: - Category
struct Category: Codable {
    let id: String
    let name: String
    let iconName: String
    var mainCategoryID: String?
    var monthlyBudget: Double = 0
}
// MARK: - Interface
extension Category {
    static func getCategory(of id: CategoryID) -> Category? {
        return all[id]
    }
    static func getCategoryIconName(of id: CategoryID) -> String? {
        return all[id]?.iconName
    }
    static func getCategoryName(of id: CategoryID, isLocalized: Bool = false) -> String? {
        // TODO: - Add localized
        return all[id]?.name
    }
    static func getMainCategoryID(of id: CategoryID) -> String? {
        return all[id]?.mainCategoryID
    }
    static func getMainCategoryName(of id: CategoryID) -> String? {
        if let mainCategoryId = all[id]?.mainCategoryID {
            return MainCategory.getName(of: mainCategoryId)
        }
        return nil
    }
    static func getAllCategoryNames(isLocalized: Bool = false) -> [String] {
        // TODO: - Add localized
        return all.map { $0.value.name }
    }
    static func getAllCategoryIDs() -> [CategoryID] {
        return Array(all.keys)
    }
    static func getAllCategoryIDs(under mainCategoryID: CategoryID) -> [CategoryID] {
        return Array(all.filter { $0.value.mainCategoryID == mainCategoryID }.keys)
    }
}
// MARK: - Coder
extension Category {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconName
        case mainCategoryID
        case monthlyBudget
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(CategoryID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        iconName = try container.decode(String.self, forKey: .iconName)
        mainCategoryID = try container.decode(CategoryID.self, forKey: .mainCategoryID)
        monthlyBudget = try container.decode(Double.self, forKey: .monthlyBudget)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(mainCategoryID, forKey: .mainCategoryID)
        try container.encode(monthlyBudget, forKey: .monthlyBudget)
    }
}
// MARK: - Category Items
extension Category {
    static let salary = Category(id: "0-01", name: "Salary", iconName: Icons.dollarsignCircleFill, mainCategoryID: "0")
    static let reselling = Category(id: "0-02", name: "Reselling", iconName: Icons.dollarsignCircleFill, mainCategoryID: "0")
    static let investment = Category(id: "0-03", name: "Investment", iconName: Icons.dollarsignCircleFill, mainCategoryID: "0")
    static let cashback = Category(id: "0-04", name: "Cashback", iconName: Icons.dollarSignArrowCirclePath, mainCategoryID: "0")
    static let rewards = Category(id: "0-05", name: "Rewards", iconName: Icons.gift, mainCategoryID: "0")
    static let rent = Category(id: "1-01", name: "Rent", iconName: Icons.houseFill, mainCategoryID: "1")
    static let homeRepair = Category(id: "1-02", name: "Home Repair", iconName: Icons.hammerFill, mainCategoryID: "1")
    static let propertyTax = Category(id: "1-03", name: "Property Tax", iconName: Icons.dollarsignCircleFill, mainCategoryID: "1")
    static let groceries = Category(id: "2-01", name: "Groceries", iconName: Icons.cartFill, mainCategoryID: "2")
    static let dining = Category(id: "2-02", name: "Dining", iconName: Icons.forkKnife, mainCategoryID: "2")
    static let drink = Category(id: "2-03", name: "Drink", iconName: Icons.takeoutbagAndCupAndStrawFill, mainCategoryID: "2")
    static let treat = Category(id: "2-04", name: "Treat", iconName: Icons.sparkles, mainCategoryID: "2")
    static let houseUtilities = Category(id: "3-01", name: "House Utilities", iconName: Icons.boltFill, mainCategoryID: "3")
    static let internet = Category(id: "3-02", name: "Internet", iconName: Icons.wifi, mainCategoryID: "3")
    static let water = Category(id: "3-03", name: "Water/Sewage", iconName: Icons.dropFill, mainCategoryID: "3")
    static let phone = Category(id: "3-04", name: "Phone", iconName: Icons.iphoneHomeButton, mainCategoryID: "3")
    static let cable = Category(id: "3-05", name: "Cable", iconName: Icons.tvFill, mainCategoryID: "3")
    static let mrtBus = Category(id: "4-01", name: "MRT & Bus", iconName: Icons.bus, mainCategoryID: "4")
    static let taxi = Category(id: "4-02", name: "Taxi", iconName: Icons.carFill, mainCategoryID: "4")
    static let dailySupply = Category(id: "5-01", name: "Daily Supply", iconName: Icons.eyeglasses, mainCategoryID: "5")
    static let homeSupply = Category(id: "5-02", name: "Home Supply", iconName: Icons.lightbulb, mainCategoryID: "5")
    static let birthdayGift = Category(id: "6-01", name: "Birthday Gift", iconName: Icons.gift, mainCategoryID: "6")
    static let holidayGift = Category(id: "6-02", name: "Holiday Gift", iconName: Icons.gift, mainCategoryID: "6")
    static let productivity = Category(id: "7-01", name: "Productivity", iconName: Icons.cursorarrowRays, mainCategoryID: "7")
    static let studentLoan = Category(id: "8-01", name: "Student Loan", iconName: Icons.graduationCapFill, mainCategoryID: "8")
    static let classes = Category(id: "8-02", name: "Classes", iconName: Icons.characterBubbleFill, mainCategoryID: "8")
    static let textbook = Category(id: "8-03", name: "Textbook", iconName: Icons.textBookClosedFill, mainCategoryID: "8")
    static let examRegistration = Category(id: "8-04", name: "Exam Registration", iconName: Icons.scrollFill, mainCategoryID: "8")
    static let software = Category(id: "8-05", name: "Software", iconName: Icons.characterBubbleFill, mainCategoryID: "8")
    
    static let travelTransportation = Category(id: "9-01", name: "Travel Transportation", iconName: Icons.tramFill, mainCategoryID: "9")
    static let hotelLodging = Category(id: "9-02", name: "Hotel & Lodging", iconName: Icons.bedDoubleFill, mainCategoryID: "9")
    static let otherTravelExpense = Category(id: "9-03", name: "Other Travel Expense", iconName: Icons.mapFill, mainCategoryID: "9")
    static let healthInsurance = Category(id: "10-01", name: "Health Insurance", iconName: Icons.dollarsignCircleFill, mainCategoryID: "10")
    static let medicine = Category(id: "11-01", name: "Medicine", iconName: Icons.pillsFill, mainCategoryID: "11")
    static let supplements = Category(id: "11-02", name: "Supplements", iconName: Icons.pillsFill, mainCategoryID: "11")
    static let medicalPractice = Category(id: "11-03", name: "Medical Practice", iconName: Icons.crossCaseFill, mainCategoryID: "11")
    static let eyeCare = Category(id: "11-05", name: "Eye Care", iconName: Icons.eyeFill, mainCategoryID: "11")
    static let dentalCare = Category(id: "11-06", name: "Dental Care", iconName: Icons.mouthFill, mainCategoryID: "11")
    static let movie = Category(id: "12-01", name: "Movie", iconName: Icons.filmFill, mainCategoryID: "12")
    static let videoStreaming = Category(id: "12-02", name: "Video Streaming", iconName: Icons.playTvFill, mainCategoryID: "12")
    static let game = Category(id: "12-03", name: "Game", iconName: Icons.gamecontrollerFill, mainCategoryID: "12")
    static let attractions = Category(id: "12-04", name: "Attractions", iconName: Icons.ticketFill, mainCategoryID: "12")
    static let healthWellness = Category(id: "13-01", name: "Health & Wellness", iconName: Icons.figureWalk, mainCategoryID: "13")
    static let clothing = Category(id: "13-02", name: "Clothing", iconName: Icons.tshirtFill, mainCategoryID: "13")
    static let cosmetics = Category(id: "13-03", name: "Cosmetics", iconName: Icons.eyebrow, mainCategoryID: "13")
    static let randomStuff = Category(id: "13-04", name: "Random Stuff", iconName: Icons.shippingBoxFill, mainCategoryID: "13")
    static let church = Category(id: "14-01", name: "Church", iconName: Icons.crossFill, mainCategoryID: "14")
    static let donation = Category(id: "14-02", name: "Donation", iconName: Icons.heartFill, mainCategoryID: "14")
    static let fund = Category(id: "15-01", name: "Fund", iconName: Icons.dollarsignCircleFill, mainCategoryID: "15")
    static let saving = Category(id: "15-02", name: "Saving", iconName: Icons.dollarsignCircleFill, mainCategoryID: "15")
    
    private static let all: [CategoryID: Category] = [
        Category.salary.id: Category.salary,
        Category.reselling.id: Category.reselling,
        Category.investment.id: Category.investment,
        Category.cashback.id: Category.cashback,
        Category.rewards.id: Category.rewards,
        Category.rent.id: Category.rent,
        Category.homeRepair.id: Category.homeRepair,
        Category.propertyTax.id: Category.propertyTax,
        Category.groceries.id: Category.groceries,
        Category.dining.id: Category.dining,
        Category.drink.id: Category.drink,
        Category.treat.id: Category.treat,
        Category.houseUtilities.id: Category.houseUtilities,
        Category.internet.id: Category.internet,
        Category.water.id: Category.water,
        Category.phone.id: Category.phone,
        Category.cable.id: Category.cable,
        Category.mrtBus.id: Category.mrtBus,
        Category.taxi.id: Category.taxi,
        Category.dailySupply.id: Category.dailySupply,
        Category.homeSupply.id: Category.homeSupply,
        Category.birthdayGift.id: Category.birthdayGift,
        Category.holidayGift.id: Category.holidayGift,
        Category.productivity.id: Category.productivity,
        Category.studentLoan.id: Category.studentLoan,
        Category.classes.id: Category.classes,
        Category.textbook.id: Category.textbook,
        Category.examRegistration.id: Category.examRegistration,
        Category.software.id: Category.software,
        Category.travelTransportation.id: Category.travelTransportation,
        Category.hotelLodging.id: Category.hotelLodging,
        Category.otherTravelExpense.id: Category.otherTravelExpense,
        Category.healthInsurance.id: Category.healthInsurance,
        Category.medicine.id: Category.medicine,
        Category.supplements.id: Category.supplements,
        Category.medicalPractice.id: Category.medicalPractice,
        Category.eyeCare.id: Category.eyeCare,
        Category.dentalCare.id: Category.dentalCare,
        Category.movie.id: Category.movie,
        Category.videoStreaming.id: Category.videoStreaming,
        Category.game.id: Category.game,
        Category.attractions.id: Category.attractions,
        Category.healthWellness.id: Category.healthWellness,
        Category.clothing.id: Category.clothing,
        Category.cosmetics.id: Category.cosmetics,
        Category.randomStuff.id: Category.randomStuff,
        Category.church.id: Category.church,
        Category.donation.id: Category.donation,
        Category.fund.id: Category.fund,
        Category.saving.id: Category.saving,
    ]
}
