import XCTest
@testable import SwiftRiemannSphere

class swift_riemann_sphereTests: XCTestCase {
  let i = Complex.i
  func testInit(){
    assert(Complex(real: 0, imaginary: 1) == i)
  }


  func testEquality() {
    let a = Complex(angle: 0, radius: 0)
    let b = Complex(angle: 2 * Double.pi, radius: 0)
    assert(a == b)
  }

  func testSum() {
    let a      = Complex(angle: 0, radius: 1)
    let b      = Complex(angle: Double.pi / 2, radius: 1)
    let c      = a + b

    // assert
    let expect = Complex(angle: Double.pi / 4, radius: sqrt(2))

    assert(c == expect)
  }

  func testTimes() {
    let a      = Complex(angle: 0, radius: 1)
    let b      = Complex(angle: Double.pi / 4, radius: 1)
    let c      = a * b

    // assert
    let expect = Complex(angle: Double.pi / 4, radius: 1)

    assert(c == expect)
  }

  func testDevide() {
    let a      = Complex(angle: Double.pi / 4, radius: 1)
    let b      = Complex(angle: 0, radius: 1)
    let c      = a / b

    // assert
    let expect = Complex(angle: Double.pi / 4, radius: 1)

    assert(c == expect)
  }

  func testInf() {
    let z = Complex(angle: Double.pi / 3, radius: 3)

    let inf = Complex.infinity
    let nan = Complex.nan

    assert(inf != nan)
    assert(inf == inf)
    assert(inf != z)
    assert(inf + z == inf)
    assert(z + inf == inf)
    assert(0 + inf == inf + 0)
    assert(0 + inf == inf)
    assert((inf + inf).isNan)
    assert(inf - z == inf)
    assert(z - inf == inf)
    assert(0 - inf == inf - 0)
    assert(0 - inf == inf)
    assert((inf - inf).isNan)
    assert(z * inf == inf * z)
    assert(z * inf == inf)
    assert((0 * inf).isNan)
    assert((inf * 0).isNan)
    assert(inf * inf == inf)
    assert(i / 0 == inf)
    assert(z / 0 == inf)
    assert(inf / 0 == inf)
    assert(1 / inf == 0)
    assert(0 / z == 0)
    assert(0 / inf == 0)
    assert((inf / inf).isNan)
  }

  func testZeroDevide() {
    let a      = Complex(angle: 0, radius: 1)
    let c      = a / 0.0

    // assert
    let expect = Complex.infinity

    assert(c == expect)
  }


  func testEuler() {
    // 精度不足
    // assert(Complex.exp(i * Double.pi) == Complex(real: -1, imaginary: 0))
  }
}


