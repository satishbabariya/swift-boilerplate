import Foundation
import RxSwift
import StoreKit
import SwiftyStoreKit

class StoreKitService {

    static func prepareToLaunch(with _: [UIApplication.LaunchOptionsKey: Any]?) {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }

        fetchProducts()
    }

    class func localReceipt() -> String? {
        return SwiftyStoreKit.localReceiptData?.base64EncodedString()
    }

    class func products() -> Single<[SKProduct]> {
        return Single.create { (single) -> Disposable in
            SwiftyStoreKit.retrieveProductsInfo(["com.demo.first"...]) { result in
                if let error = result.error {
                    single(SingleEvent.error(error))
                }
                single(SingleEvent.success(Array(result.retrievedProducts)))
            }
            return Disposables.create()
        }
    }

    class func purchase(product: SKProduct) -> Single<PurchaseDetails> {
        return Single.create { (single) -> Disposable in
            SwiftyStoreKit.purchaseProduct(product) { result in
                switch result {
                case let .success(purchase):
                    single(SingleEvent.success(purchase))
                case let .error(error):
                    single(SingleEvent.error(error))
                }
            }
            return Disposables.create()
        }
    }

    class func restore() -> Single<[Purchase]> {
        return Single.create { (single) -> Disposable in
            SwiftyStoreKit.restorePurchases { results in
                if results.restoreFailedPurchases.count > 0 {
                    single(SingleEvent.error(RESTError(message: "Restore Failed", type: .error)))
                } else if results.restoredPurchases.count > 0 {
                    single(SingleEvent.success(results.restoredPurchases))
                } else {
                    single(SingleEvent.error(RESTError(message: "Nothing to Restore", type: .error)))
                }
            }
            return Disposables.create()
        }
    }

    fileprivate static func fetchProducts() {
        SwiftyStoreKit.retrieveProductsInfo([InAppPlans.monthly.rawValue, InAppPlans.yearly.rawValue]) { result in
            StoreProducts = Array(result.retrievedProducts).sorted(by: { (first, second) -> Bool in
                return first.price.intValue < second.price.intValue
            })
        }
    }

    class func save(isPremium: Bool) {
        // Do some stuff
    }

    class func isPremiumUser() -> Bool {
        // do some stuff
    }
}
