
import SwiftRiemannSphere

let i = Complex(real: 0, imaginary: 1)

let z = 1 + i
let inf = z/0
Complex.infinity == inf

let zero = z/inf
zero == 0

Complex.exp(i * Double.pi)
