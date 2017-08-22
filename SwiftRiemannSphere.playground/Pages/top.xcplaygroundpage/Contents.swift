
import SwiftRiemannSphere

let i = Complex.i

let z = 1 + i
let inf = z/0
Complex.infinity == inf

let zero = z/inf
zero == 0

Complex.exp(i * Double.pi)


let f = {(x:Complex) -> (Complex) in
return x * x + x + 2
}

f(z)

var a = z

let v = (f(z) - f(a))/z-a
z * z
i * i



