import Foundation

class TestSwizzling: NSObject {
    @objc dynamic func methodA() {
        print("AAA")
    }
}

extension TestSwizzling {
    func swizzleMethods() {
        guard let originalMethod = class_getInstanceMethod(TestSwizzling.self, Selector(("methodA"))) else {
            return
        }
        guard let swizzleToMethod = class_getInstanceMethod(TestSwizzling.self, Selector(("methodB"))) else {
            return
        }
        
        method_exchangeImplementations(originalMethod, swizzleToMethod)
    }
    
    @objc dynamic func methodB() {
        print("BBB")
    }
}

let t = TestSwizzling()
t.methodA()
t.swizzleMethods()
t.methodA()


