//: [Previous](@previous)

import Foundation

class Car: NSObject {
    var brand: String
    
    init(_ brand: String) {
        self.brand = brand
    }
}

extension Car {
    override var description: String {
        return "Brand is \(self.brand), Price is \(self.price ?? 0), Maker is \(self.maker ?? "unknown")"
    }
    
    private struct AssociatedKeys {
        static var Price = "ak_price"
        static var Maker = "ak_maker"
    }
    
    var price: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Price) as? Int
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Price, newValue as Int?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    var maker: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Maker) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.Maker, newValue as String?, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

let tyt = Car("Camry")
tyt.price = 20000
tyt.maker = "Toyota"
print(tyt)


//: [Next](@next)
