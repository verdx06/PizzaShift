//
//  BucketRepository.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 30.01.2026.
//

import Foundation

protocol BucketRepositoryProtocol {
    func saveBucket(_ bucket: BucketModel) async
    func loadBucket() async -> BucketModel?
    func removeItems() async 
    func createOrder(bucket: BucketModel, checkoutData: CheckoutData, cardData: DebitCard) async throws
}

final class BucketRepository {
    private let storage: UserDefaults
    private let network: BaseNetworkProtocol
    private let bucketKey = "bucket"
    
    init(network: BaseNetworkProtocol) {
        self.storage = UserDefaults()
        self.network = network
    }
}

extension BucketRepository: BucketRepositoryProtocol {
    func createOrder(bucket: BucketModel, checkoutData: CheckoutData, cardData: DebitCard) async throws {
        let parameters = makeOrderParameters(
            bucket: bucket,
            checkoutData: checkoutData,
            cardData: cardData
        )
        try await network.request(
            path: ApiEndPoint.Pizzas.payment,
            method: .post,
            parameters: parameters
        )
    }
    
    func saveBucket(_ bucket: BucketModel) async {
        let mergedBucket: BucketModel
        if let existing = await loadBucket() {
            mergedBucket = BucketModel(
                buckets: existing.buckets + bucket.buckets
            )
        } else {
            mergedBucket = bucket
        }
        let data = try? JSONEncoder().encode(mergedBucket)
        storage.set(data, forKey: bucketKey)
    }
    
    func loadBucket() async -> BucketModel? {
        guard let data = storage.data(forKey: bucketKey) else {
            return nil
        }
        return try? JSONDecoder().decode(BucketModel.self, from: data)
    }

    func removeItems() async  {
        storage.removeObject(forKey: bucketKey)
    }
}

private extension BucketRepository {
    func makeOrderParameters(bucket: BucketModel, checkoutData: CheckoutData, cardData: DebitCard) -> [String: Any] {
        let normalizedPhone = checkoutData.phoneNumber.digitsOnly
        let normalizedPan = cardData.pan.normalizedCardPan()
        let normalizedExpiryDate = cardData.expireDate.normalizedExpiryDate()
        let normalizedCvv = cardData.cvv.digitsOnly

        let receiverAddress: [String: Any] = [
            "street": checkoutData.city.isEmpty ? "street" : checkoutData.city,
            "house": "house",
            "apartment": "apartment",
            "comment": "comment"
        ]
        let person: [String: Any] = [
            "firstname": checkoutData.firstName,
            "lastname": checkoutData.lastName,
            "middlename": "empty",
            "phone": normalizedPhone.isEmpty ? checkoutData.phoneNumber : normalizedPhone
        ]
        let debitCard: [String: Any] = [
            "pan": normalizedPan.isEmpty ? cardData.pan : normalizedPan,
            "expireDate": normalizedExpiryDate,
            "cvv": normalizedCvv.isEmpty ? cardData.cvv : normalizedCvv
        ]
        let pizzas: [[String: Any]] = bucket.buckets.map { item in
            [
                "id": item.pizza.id,
                "toppings": item.topings.map { $0.type },
                "size": item.selectedSize.type.rawValue,
                "dough": item.pizza.doughs.first?.type ?? "THIN"
            ]
        }
        return [
            "receiverAddress": receiverAddress,
            "person": person,
            "debitCard": debitCard,
            "pizzas": pizzas
        ]
    }
}

private extension String {
    var digitsOnly: String {
        filter { $0.isNumber }
    }

    func normalizedCardPan() -> String {
        let digits = digitsOnly
        guard !digits.isEmpty else { return self }
        var result = ""
        for (index, character) in digits.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(character)
        }
        return result
    }

    func normalizedExpiryDate() -> String {
        let digits = digitsOnly
        guard digits.count >= 4 else { return self }
        let month = digits.prefix(2)
        let year = digits.dropFirst(2).prefix(2)
        return "\(month)/\(year)"
    }
}
