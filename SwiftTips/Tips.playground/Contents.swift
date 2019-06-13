import UIKit

public class ThermometerClass {
    private(set) var temperature: Double = 0.0
    public func registerTemperature(_ temperature: Double) {
        self.temperature = temperature
    }
}

let thermometerClass = ThermometerClass()
thermometerClass.registerTemperature(56.0)

public struct ThermometerStruct {
    private(set) var temperature: Double = 0.0
    public mutating func registerTemperature(_ temperature: Double) {
        self.temperature = temperature
    }
}

let thermometerStruct = ThermometerStruct()
thermometerStruct.registerTemperature(56.0)
