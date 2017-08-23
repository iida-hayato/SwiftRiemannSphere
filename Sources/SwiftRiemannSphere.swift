import Foundation

public protocol Number: FloatingPoint {
  static func +(r: Self, l: Self) -> Self
  static func -(r: Self, l: Self) -> Self
  static func *(r: Self, l: Self) -> Self
  static func /(r: Self, l: Self) -> Self
  static func exp(_ value: Self) -> Self
}

extension Double: Number {
  public static func exp(_ value: Double) -> Double {
    return Darwin.exp(value)
  }
}


public protocol ComplexType {
  associatedtype RealNumber: Number
  var real:      Double { get }
  var imaginary: Double { get }
  var angle:     RealNumber { get }
  var radius:    RealNumber { get }

  init(_ value: Int)
  init(_ value: Float)
  init(_ value: Double)
  init(real: RealNumber, imaginary: RealNumber)
  init(angle: RealNumber, radius: RealNumber)
}


extension Int: Complexable {
  public func asComplex() -> Complex {
    return Complex(self)
  }

}

extension Float: Complexable {
  public func asComplex() -> Complex {
    return Complex(self)
  }

}

extension Double: Complexable {
  public func asComplex() -> Complex {
    return Complex(self)
  }

}

public protocol Complexable {
  func asComplex() -> Complex
}

public struct Complex: ComplexType, Complexable {
  public static let i = Complex(angle: Double.pi / 2, radius: 1)
  public typealias RealNumber = Double
  public let angle:  RealNumber
  public let radius: RealNumber

  public var isInfinite = false
  public var isNan      = false

  public init(real: RealNumber, imaginary: RealNumber) {
    let radius = sqrt(real * real + imaginary * imaginary)
    let angle  = atan2(imaginary, real)
    self.init(angle: angle, radius: radius)
  }

  public init(angle: RealNumber, radius: RealNumber) {
    guard !(radius.isInfinite) else {
      self.angle = RealNumber.nan
      self.radius = Double.infinity
      self.isInfinite = true
      return
    }
    guard !(radius.isNaN) else {
      self.angle = RealNumber.nan
      self.radius = Double.nan
      self.isNan = true
      return
    }
    self.radius = radius
    self.angle = angle
  }


  public func asComplex() -> Complex {
    return self
  }

  public var real: Double {
    get {
      return radius * cos(angle)
    }
  }

  public var imaginary: Double {
    get {
      return radius * sin(angle)
    }
  }

  public init(_ value: Int) {
    let real = RealNumber(value)
    radius = abs(real)
    angle = atan2(0, real)
  }

  public init(_ value: Float) {
    let real = RealNumber(value)
    radius = abs(real)
    angle = atan2(0, real)
  }

  public init(_ value: Double) {
    let real = RealNumber(value)
    radius = abs(real)
    angle = atan2(0, real)
  }


}

extension Complex:CustomStringConvertible {
  public var description: String {
    let digit = pow(10.0, 10.0)
    return "\(round(self.real * digit)/digit) + \(round(self.imaginary * digit)/digit) i"
  }
}

// Opelator
extension Complex {
  static public func ==(a: Complex, b: Complex) -> Bool {
    if a.isInfinite && b.isInfinite {
      return true
    } else if a.isInfinite || b.isInfinite {
      return false
    } else if a.isNan || b.isNan {
      return false
    }
    return a.asComplex().real == b.asComplex().real && a.asComplex().imaginary == b.asComplex().imaginary
  }

  static public func ==<T:Complexable>(a: Complex, b: T) -> Bool {
    return a.asComplex() == b.asComplex()
  }

  static public func ==<T:Complexable>(a: T, b: Complex) -> Bool {
    return a.asComplex() == b.asComplex()
  }

  static public func !=(a: Complex, b: Complex) -> Bool {
    return !(a == b)
  }

  static public func !=<T:Complexable>(a: Complex, b: T) -> Bool {
    return a.asComplex() != b.asComplex()
  }

  static public func !=<T:Complexable>(a: T, b: Complex) -> Bool {
    return a.asComplex() != b.asComplex()
  }

  static public func +(a: Complex, b: Complex) -> Complex {
    if a.isInfinite && b.isInfinite {
      return Complex.nan
    } else if a.isInfinite || b.isInfinite {
      return Complex.infinity
    } else if a.isNan || b.isNan {
      return Complex.nan
    }
    return Complex(real: a.asComplex().real + b.asComplex().real, imaginary: a.asComplex().imaginary + b.asComplex().imaginary)
  }

  static public func +<T:Complexable>(a: Complex, b: T) -> Complex {
    return a.asComplex() + b.asComplex()
  }

  static public func +<T:Complexable>(a: T, b: Complex) -> Complex {
    return a.asComplex() + b.asComplex()
  }

  static public func -(a: Complex, b: Complex) -> Complex {
    return a + (-1) * b
  }

  static public func -<T:Complexable>(a: Complex, b: T) -> Complex {
    return a.asComplex() - b.asComplex()
  }

  static public func -<T:Complexable>(a: T, b: Complex) -> Complex {
    return a.asComplex() - b.asComplex()
  }

  static public func *(a: Complex, b: Complex) -> Complex {
    return Complex(angle: a.asComplex().angle + b.asComplex().angle, radius: a.asComplex().radius * b.asComplex().radius)
  }

  static public func *<T:Complexable>(a: Complex, b: T) -> Complex {
    return a.asComplex() * b.asComplex()
  }

  static public func *<T:Complexable>(a: T, b: Complex) -> Complex {
    return a.asComplex() * b.asComplex()
  }

  static public func /(a: Complex, b: Complex) -> Complex {
    if a.isInfinite && b.isInfinite {
      return Complex.nan
    } else if a.isInfinite {
      return Complex.infinity
    } else if b.isInfinite {
      return 0.asComplex()
    } else if a.isNan || b.isNan {
      return Complex.nan
    }
    return Complex(angle: a.asComplex().angle - b.asComplex().angle, radius: a.asComplex().radius / b.asComplex().radius)
  }

  static public func /<T:Complexable>(a: Complex, b: T) -> Complex {
    return a.asComplex() / b.asComplex()
  }

  static public func /<T:Complexable>(a: T, b: Complex) -> Complex {
    return a.asComplex() / b.asComplex()
  }

  static public func exp<T:Complexable>(_ a: T) -> Complex {
    return (Complex(angle: a.asComplex().imaginary, radius: 1)) * Darwin.exp(a.asComplex().real)
  }
}

// infinity
extension Complex {
  static public let infinity = Complex(angle: Double.nan, radius: Double.infinity)
  static public let nan      = Complex(angle: Double.nan, radius: Double.nan)

}
