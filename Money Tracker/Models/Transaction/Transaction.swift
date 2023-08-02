//
//  Transaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit

struct Transaction: TransactionSettings, Identifiable, Codable {
    var id: TransactionID
    var userID: UserID
    var currencyCode: CurrencyCode
    var date: YearMonthDay
    var merchantID: MerchantID
    var amount: Double
    var type: TransactionType
    var note: String
    var categoryID: CategoryID
    var tag: TransactionTag
    
    // Recurring payment
    var recurringID: RecurringTransactionID?
    
    // current account
    var sourceAccountID: AccountID
    // for transfer and saving only
    var targetAccountID: AccountID?
    
    // TODO: - Refactor this part
    enum EditableField: String {
        case userID
        case currencyCode
        case year
        case month
        case day
        case merchantID
        case amount
        case categoryID
        case note
        case tag
        case type
        
        static var stringFields: [EditableField] {
            return [.userID, .currencyCode, .merchantID, .amount, .categoryID, .note, .tag]
        }
    }
}

extension Transaction {
    init() {
        id = UUID()
        // TODO: - Connect to real userID (Firebase), set default merchantID & groceriesID
        userID = CacheManager.shared.userID
        currencyCode = CacheManager.shared.preferredCurrencyCode
        amount = 0
        date = YearMonthDay.today
        merchantID = Merchant.fairPriceID
        type = .expense
        note = ""
        categoryID = Category.groceries.id     // default
        tag = .dailyLiving
        recurringID = UUID()
        sourceAccountID = CacheManager.shared.mainAccountID
        targetAccountID = UUID()
    }
    init(from recurringTransaction: RecurringTransaction) {
        id = UUID()
        userID = recurringTransaction.userID
        currencyCode = recurringTransaction.currencyCode
        amount = recurringTransaction.amount
        date = recurringTransaction.nextTransactionDate
        merchantID = recurringTransaction.merchantID
        type = recurringTransaction.type
        note = recurringTransaction.note
        categoryID = recurringTransaction.categoryID
        tag = recurringTransaction.tag
        recurringID = recurringTransaction.id
        sourceAccountID = CacheManager.shared.mainAccountID
        targetAccountID = UUID()
    }
    static var defaultTransportTransaction: Transaction {
        return Transaction(id: UUID(),
                           userID: CacheManager.shared.userID,
                           currencyCode: CacheManager.shared.preferredCurrencyCode,
                           date: YearMonthDay.today,
                           merchantID: Merchant.smrtID,
                           amount: 0,
                           type: .expense,
                           note: "",
                           categoryID: Category.mrtBus.id,
                           tag: .dailyLiving,
                           recurringID: nil,
                           sourceAccountID: CacheManager.shared.mainAccountID,
                           targetAccountID: nil)
    }
    static var defaultGroceryTransaction: Transaction {
        return Transaction(id: UUID(),
                           userID: CacheManager.shared.userID,
                           currencyCode: CacheManager.shared.preferredCurrencyCode,
                           date: YearMonthDay.today,
                           merchantID: Merchant.fairPriceID,
                           amount: 0,
                           type: .expense,
                           note: "",
                           categoryID: Category.groceries.id,
                           tag: .dailyLiving,
                           recurringID: nil,
                           sourceAccountID: CacheManager.shared.mainAccountID,
                           targetAccountID: nil)
    }
}

// MARK: - Persistable
extension Transaction: Persistable {
    public init(managedObject: TransactionObject) {
        id = managedObject.id
        userID = managedObject.userID
        currencyCode = managedObject.currencyCode
        if let yearMonthDateObject = managedObject.date {
            date = YearMonthDay.init(managedObject: yearMonthDateObject)
        } else {
            date = YearMonthDay.today
        }
        merchantID = managedObject.merchantID
        amount = managedObject.amount
        type = TransactionType(rawValue: managedObject.type) ?? .expense
        note = managedObject.note
        categoryID = managedObject.categoryID
        tag = TransactionTag(rawValue: managedObject.tag) ?? .dailyLiving
        recurringID = managedObject.recurringID
        sourceAccountID = managedObject.sourceAccountID
        targetAccountID = managedObject.targetAccountID
    }
    
    public func managedObject() -> TransactionObject {
        return TransactionObject(id: id,
                                 userID: userID,
                                 currencyCode: currencyCode,
                                 date: date.managedObject(),
                                 merchantID: merchantID,
                                 amount: amount,
                                 type: type.rawValue,
                                 note: note,
                                 categoryID: categoryID,
                                 tag: tag.rawValue,
                                 recurringID: recurringID,
                                 sourceAccountID: sourceAccountID,
                                 targetAccountID: targetAccountID)
    }
}

// MARK: -
extension Transaction {
    var monthYearString: String {
        return date.toString(in: DateFormat.MMM_yyyy)
    }
    var dateStringInLocalDateFormat: String {
        return date.toString(in: DateFormat.MMM_dd_yyyy)
    }
    var isPending: Bool {
        return date > YearMonthDay.today
    }
    var isRecurring: Bool {
        return recurringID != nil
    }
}

// MARK: - Interface
extension Transaction {
    static func sum(of transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.signedAmount }
    }
}

// MARK: - Enums
enum TransactionAccount {

}

//a78886e3-cd27-41b2-846a-fe4985c5760e
//9691d70a-1ee8-4565-b83e-8d49a1794eec
//f925af4c-bb49-48a3-b8ac-a98c3ec65de2
//c83d1afd-35b8-412b-b7d3-21011d6c600a
//257607de-8058-4f70-b361-0f9ed3a22789
//815a4fd2-d12f-42de-9d18-3cd2eac07bb0
//24f815c7-faf5-411a-b637-d2307558f218
//faed7e91-c62d-402d-9e21-e5b7a9d6f0f5
//26da7bc3-9394-4b2e-81e4-28319d108213
//fddac119-1da5-4554-b7d6-3e36bca44c35
//9163cbd1-d100-48cf-9607-8cea3b81ee4c
//0d44b632-5596-4a80-b00f-00d962da6b27
//8e4facf7-be44-4ef8-b154-53361a2eb51d
//d1ccdb05-168d-4f56-8155-5eb50885b406
//2b9636e6-9b17-463c-be7d-34b33fe6ae51
//69e67a78-68dd-4f95-9b55-82c85e5eb761
//4e324655-5120-4955-aa24-5466dc7cf179
//8348d330-e387-4319-b97f-461e696badae
//5193cff8-2073-4c26-9145-8371ed936f58
//57e0a0dc-4044-41dd-aab4-98970e4ab093
//df38bb08-1013-4e17-8b51-54b953e079f5
//bd52845a-2d7d-4e64-b811-5eee6b906ffe
//c7731912-f8bb-4afd-ad26-768edc9bad76
//00fab145-b84c-4d91-8e8c-76f4b24406b4
//ab94238f-4ea5-4a0f-9391-75c6bff862b4
//7320e4e2-1c74-409f-8940-47e34c9d9f9b
//8aabab94-3626-4394-8148-651bfed52bec
//73e24b14-cc22-4713-bc52-8f2f64db42ef
//afe6013d-da83-4fbe-8b82-f009fe462790
//2be8e096-f17d-41a4-a1b2-45005cd141b5
//08e7f3a7-b7e2-4501-b21e-9e215656eaf9
//83e0718c-f273-490d-9f95-77f1fc7946cb
//9194e56c-d800-4b78-8fc1-b8c3b8f7817b
//6e28b1d8-196a-4ab0-b003-3e961008798f
//b4d0a7cd-c660-4d2d-a60a-b9a45593ccda
//e6d7eb84-8744-42c3-a5f9-8375957459e4
//91b15dff-8942-4923-8cd8-5efe9ee05001
//de80457b-67ca-4837-bea4-38eb1b25a051
//1d74915b-9108-49eb-b915-812bb1631c33
//828878b9-a1ab-41c6-ae4f-46400ef463f3
//91d0ef43-e690-4467-b2fc-94ae0b6e6376
//4a387274-e5b9-4be9-b400-8dc7153b66c1
//f2eda798-d17b-4205-af0a-bba2731a81e8
//0ce9ddf3-a75e-491b-9925-73741036ac23
//d308e9fc-239c-4b39-a38c-b8e862e4b157
//c7003fbb-d11e-4175-8dd5-8d79e360346e
//b4a7f588-2ae2-4ec6-b8ae-0edba51c8f40
//825c8179-2ebb-468c-a1db-28aaa624f191
//4367d759-305e-423e-a1ba-c8e3f7873d9d
//143eaa26-e03b-459c-b8e4-109d3a834579
//2e3996c0-43a5-46b4-b055-f2c73d7db534
//bf64b8f4-26d1-4f7d-9c7d-51a67943cc95
//885e4235-987b-4a3a-8fd2-d6df8ebde08c
//21e28e3a-5f6a-4c1b-ab64-a30743f5395c
//b82cf8af-e780-40e5-a196-ef2981d42526
//70fba048-2dd5-4e5b-945a-8baf4a16bfa7
//6ca54282-0bdd-48d5-b20d-82894a17cb37
//21a45d75-f26f-447a-9e2a-e7b18ec2fd86
//d1d079d8-f4ed-48d2-a972-eb02cddc1195
//b87f5e1a-65fd-48b5-b7f7-154d7564ab76
//9790cc25-c48a-450a-9e76-c6fc6ab8a244
//64c07f42-c40a-49dd-82af-e0c990924e59
//59be72da-10c0-4c60-95fd-2ccf59fbda29
//0abe604a-dd3e-4bfb-ba43-45b6ad234380
//5386fa8e-76bc-4f3d-9940-5c102e1d374f
//c7cbc807-21d4-42b4-ab61-35b51937064f
//dfe13d64-693a-4f70-b2b8-65cf3408b7e7
//fe043d1f-475f-499b-91ac-89e29eb9fc6c
//0f95126c-d562-4567-8cbc-8ca811ff2a74
//4c500e78-8594-4d77-b2e6-f891703641a9
//b7a02de4-39b2-41c8-8cd8-f6419ff0c2bc
//e621dd6a-bbe7-4989-9b1b-addb0d47b120
//ef21db30-592e-4d2b-86c1-29a07585a6dc
//85c8d889-784e-4689-8f11-8c52764a7db8
//5fdbaba1-1af4-4b70-8017-81dcc91cab11
//5299d5fe-b877-46b9-9482-662cc70181c1
//370e0395-229d-420a-a6e7-12eadfe6fc4f
//88c2ec2b-f148-46c2-a33d-924c8ffb2fa7
//35db8bab-9d3c-4073-b6f8-003d591797b6
//b16d9c01-6afe-405b-a0ef-20f16469ded8
//71fb6dc6-8ebc-4db2-b87a-75049fbcfc21
//e7e5cf01-d263-467f-8e64-611d061bb14d
//49eda1a8-a5ed-4df0-b9e6-520afe074c3a
//96cac0e3-59e5-46d0-9a96-ace17a443dbb
//2045014c-3b97-485a-9e94-5e6b946161ce
//8f84f982-386d-42ba-92cd-56d6ccc8c203
//dc0056ea-ea2a-4568-8bc9-eda633d6ce91
//9cde7bcd-3f6c-44a5-9199-d6d1fa632439
//d7f0d3f1-e68b-4e0b-ac51-767f1fdc42c9
//f251c3d0-400d-44da-a735-f87bebe2d1bd
//0035df61-62b5-42a1-9675-762c6ab009e7
//7a69028e-7719-4718-84a6-8a2ded45ca1f
//96b20e09-35ef-41ee-8d4b-f7ed9407ac69
//be110505-7aa8-4ff8-be6f-b2ec236b724d
//70b5f27a-c79f-4ab6-ba72-87a2d275cace
//275328db-b010-44b9-99f3-e976244ecab6
//d8ae7569-60ff-4e43-abaa-55ab82c740f0
//8fc33a3a-d609-4dc4-a701-5b2fca7e8ee4
//30a4764e-459c-435d-b9c2-d1d0cae86783
//7149afff-c23a-4fbd-9c26-bd65ab8c6421
//009e08b9-c342-4953-8060-a13cb62891af
//cdcef6d7-767c-4cab-9eca-2a469d1699ce
//bcce8547-9225-435d-89cb-a9c95c160318
//cd63de12-d307-49b1-9819-8eae021bf3a1
//6d3d12ab-550f-46b1-9e3e-04eef4eadbf4
//6842d312-15e3-43e8-9b5e-b27e6be9faaf
//69555518-f355-4361-9226-a68e74bee0d3
//24c3514a-d64c-4853-9c1d-0b387e4d1b26
//8c91cf0b-8d68-42c9-a358-acdda93b462a
//ecc144b3-66d9-478b-b9db-7dd722123b38
//91f92532-15d7-4f21-abcc-a70dbe47e75e
//d25c5e2e-70d6-44dd-9cc2-479caf97508d
//661ee7ba-32a6-4df5-9ba0-c8195f30d46f
//fa4cc631-6269-448f-a9f0-38f79c9d66e3
//3e7fe4a4-4f8b-4930-b4be-638bd05c99a1
//1abbe868-bdd5-4167-b944-33106219a332
//cef70634-cbe9-4001-9b83-223e6e67d5fb
//431fdbd0-e261-405d-83c9-51be00ef4456
//80f571b9-e8eb-410c-8a02-a046be5475b1
//6118d770-fa4e-45c2-ad9f-ea28e74b40dd
//796bdab3-4776-4ed6-9794-cd52496fe06a
//1fe6abf6-45bd-4910-8f67-36bcfe373ca2
//05b3e95e-56c2-409f-816b-cb989e2ecb45
//c85877b7-5238-445b-8ad0-5bb406ad9208
//fe4aea9a-e883-4ea3-9804-999cf118784d
//9411e317-00a9-409f-ab66-f286f5437258
//346b1169-07f5-4dfd-a95c-3b1d3e64383d
//f63b237d-a971-4917-9504-719671ddc519
//385035c9-4e9d-42fa-8c9e-e002db2536b2
//7c802223-365f-4756-8d84-94de6ed07020
//c01c2ac4-a9be-4ae8-8bec-600dfd290797
//452ab3de-ba15-4ba5-9fd0-eb13e47d7218
//0dc1315d-9049-44ef-8861-ad472d3b1e04
//20fad524-efa5-4342-99f0-4d357d367fba
//97c672a3-82f1-46cf-b217-cf12ead0e732
//9e1b7ce1-0996-41f3-a67e-b2feb907cf94
//b4270988-c051-4f56-9022-5afbdf336a41
//7d56df09-c432-4b9b-8662-0fdac33b2dfd
//5187ccca-b8fb-4121-8828-d7fbc70a71f6
//029a7327-8808-4ca3-b87f-6ed2c3e8943c
//ccf87df5-7f70-4327-a7d4-ac92659b6fc4
//b1dd2a94-1855-4cc9-aaf0-3117f1c614d4
//a12a6c53-a33a-4311-a1c1-596a8f153421
//de644c29-febe-49ce-bc21-ada30f3b7a84
//016c9007-8a74-4d95-8e34-7b7f8c629025
//36485607-03e8-4549-af42-c4ed9e1fd9d1
//19538561-7fe8-4e34-895c-d98f5a942702
//e3ac0fac-ac26-4c1a-9901-83df9b5efec7
//611384b4-5d27-4ef8-b6cd-3095f10832df
//440ff6fc-9741-47fb-8afd-2b71a9453543
//7245d327-bef3-4da7-9aa4-f92e51d69bc9
//a83a4dd4-9bbf-4da5-9f67-462174eab4dc
//81fa6713-ecc3-4aee-9eeb-db156ce6c48e
//de0e7bad-2a10-462b-9111-6ea73ec868cc
//6379c25d-74df-45a1-8e4a-2068331b8bbd
//f036ecf5-2014-445a-a44d-abd219a081ad
//65b71311-eced-4c11-9669-db4476e2e3fe
//24de714e-bd0c-418d-8ebc-c1be8e43a357
//b34d0b42-1d2f-4f91-8980-5421dc42740a
//5fa26165-6925-4676-b206-ec080ead7c84
//b937f4d8-c5ad-48b8-b565-ee54bcbfabf8
//0d957272-1cfc-4658-ada4-7c26bc953f4a
//81b49c80-e498-46d0-af97-332feb3bb824
//001edca6-2445-42da-b95c-8cfe7cd08032
//ca0f354b-6727-4008-9659-ea0d26f05d3b
//023405b3-def9-4c68-814c-75f5eb0e4b1a
//8d75d208-32b6-4e03-a94f-b270848d246f
//fba3f464-4d9c-4cfe-b636-519d0003ac37
//5b17e294-b5ac-4bbc-8fd1-2852aab3a3b5
//eedfccf1-6826-41d8-bec6-4226fc3ff14a
//7bb457ed-7475-4fdc-8bea-740aa85ec3fd
//e13eb7a0-31b0-44c0-a8b7-9a1caa494de1
//3c9eef7c-8ba4-400a-a072-f64c742d5278
//2464ec97-1124-4e55-a138-37e11ca87ba1
//b2c5df6e-3d07-4250-9f61-96e63aab8236
//cc2f11b2-51ba-497d-ba5b-33657207921d
//c601823f-9159-40fc-9f5b-fd1f1875ea9b
//128e8344-9ecd-4bc6-96c5-0c42e48b1f6c
//01a7c722-75c4-47eb-a548-1f7f3bf3fce8
//4c3a674d-0f71-486c-adee-ea54798b4baf
//6a8b6a8d-892e-449a-a06d-ddfd6d9578a3
//0dee2b5e-e6ea-445f-ac35-134229198172
//b3cc3a7c-5c94-437f-98c5-8ed3d57959c6
//355ba6a9-518b-4773-8689-3f2897c07ea9
//f11ae53b-a704-4d15-a7d9-57eb463821c9
//1eabf9a2-3946-4c4d-9c26-5ddd14bd0d65
//f68de274-2ee8-4de2-b919-ed2ffd7721ce
//0c696947-9e19-4570-afea-5e02dcabe7f2
//70dce375-2ae3-491e-91c0-796b0cb5d9e8
//
