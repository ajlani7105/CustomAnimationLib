import SwiftUI




public enum CustomTypeEffect : String {
    case Default = "Default"
    case AppearFromTop = "AppearFromTop"
    case AppearFromBottom = "AppearFromBottom"
    case AppearFromLeft = "AppearFromLeft"
    case AppearFromRight = "AppearFromRight"
    case Zoom = "Zoom"
    case Shake = "Shake"
    case HeavyFalling = "HeavyFalling"
    case FallingWithRotate  = "FallingWithRotate"
    case Rotate = "Rotate"
    case RotateBackward = "RotateBackward"
    case Rotate3D = "Rotate3D"
    case RotateX = "RotateX"
    case RotateXBackward  = "RotateXBackward"
    case RotateY = "RotateY"
    case RotateYBackward  = "RotateYBackward"
    case CustomRotate  = "CustomRotate"




}




extension CustomTypeEffect {
    static public func getAnimation (a:Animation?,duration : TimeInterval) -> Animation? {
        if let b = a {
            switch(b){
            case .spring:
                return Animation.spring(duration:duration)
            case .default:
                return Animation.default
            case .bouncy:
                return Animation.bouncy(duration:duration)
            case .easeIn:
                return Animation.easeIn(duration:duration)
            case .easeOut:
                return Animation.easeOut(duration:duration)
            case .easeInOut:
                return Animation.easeInOut(duration:duration)
            case .smooth:
                return Animation.smooth(duration:duration)
            case .snappy:
                return Animation.snappy(duration:duration)
            case .linear:
                return Animation.linear(duration:duration)
            case .interactiveSpring:
                return Animation.interactiveSpring(duration:duration)
            case .interpolatingSpring:
                return Animation.interpolatingSpring(duration:duration)
            default:
                return nil
            }
        }
        
        return nil
    }

}


public protocol CustomEffectProperty {
    var animation    : Animation { get set }
    var dimensions         : Dimensions         { get set }
    var customTimeInterval : CustomTimeInterval { get set }
    var applyCustom        : ApplyCustom        { get set }
    var valuesCustom       : ValuesCustom       { get set }

    //var speed = 0.1


}


public struct Dimensions {
    var x : CGFloat = 3.0
    var y : CGFloat = 3.0
    var z : CGFloat = 0
    public init(x: CGFloat = 3.0, y: CGFloat = 3.0, z: CGFloat = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
}
public struct CustomTimeInterval {
    var duration    : Double  = 1
    var speed       : Double  = 0.5
    var delay       : Double  = 0.0
    var reverseAfter: Double  = 0.0
    var stopAfter   : Double  = 0.0
    public init(duration: Double = 1, speed: Double = 0.5, delay: Double = 0.0, reverseAfter: Double = 0.0, stopAfter: Double = 0.0) {
        self.duration = duration
        self.speed = speed
        self.delay = delay
        self.reverseAfter = reverseAfter
        self.stopAfter = stopAfter
    }
}

public struct ApplyCustom {
    var applyBlur    = true
    var applyOpacity = true
    var applyScale   = true
    public init(applyBlur: Bool = true, applyOpacity: Bool = true, applyScale: Bool = true) {
        self.applyBlur = applyBlur
        self.applyOpacity = applyOpacity
        self.applyScale = applyScale
    }
}

public struct ValuesCustom {
    var ZoomInScale : CGFloat  = 1.9
    var Rotate      : CGFloat  = 3.0
    var RotateDegree: CGFloat  = 0
    public init(ZoomInScale: CGFloat =  1.9 , Rotate: CGFloat = 3.0, RotateDegree: CGFloat = 0) {
        self.ZoomInScale = ZoomInScale
        self.Rotate = Rotate
        self.RotateDegree = RotateDegree
    }
}


public struct CustomAnimationProperty : CustomEffectProperty  {
    public var animation: Animation = .linear
    
    public var dimensions         : Dimensions         = Dimensions()
    public var customTimeInterval : CustomTimeInterval = CustomTimeInterval()
    public var applyCustom        : ApplyCustom        = ApplyCustom()
    public var valuesCustom       : ValuesCustom       = ValuesCustom()
    public init(animation: Animation = .linear, dimensions: Dimensions = Dimensions(), customTimeInterval: CustomTimeInterval = CustomTimeInterval(), applyCustom: ApplyCustom = ApplyCustom(), valuesCustom: ValuesCustom = ValuesCustom()) {
        self.animation = animation
        self.dimensions = dimensions
        self.customTimeInterval = customTimeInterval
        self.applyCustom = applyCustom
        self.valuesCustom = valuesCustom
    }
    
}

public struct CustomTypeEffect_Rotate3D : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    
    public func body(content: Content) -> some View {
        content
            .offset(y: FirstAppear ? -properties.dimensions.y : 0)
            .rotation3DEffect(.degrees(FirstAppear ? 0 : properties.valuesCustom.RotateDegree), axis: (x: properties.dimensions.x, y: properties.dimensions.y, z: properties.dimensions.z))
            .animation(CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration )?.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed) ?? .spring(duration :0.1), value: FirstAppear)
             .onAppear {
                 
                 FirstAppear = false
                     

             }
             .onDisappear{
                 FirstAppear = true

             }


    }
}

public struct CustomTypeEffect_CustomRotate : ViewModifier {
    var properties : CustomAnimationProperty
    var backward    : Bool = false

    @State private var RotateDegree = 0.0

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(RotateDegree), axis: (x: properties.dimensions.x, y: properties.dimensions.y, z: properties.dimensions.z))
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay).repeatForever(autoreverses: false)) {
                         if backward {
                             RotateDegree -= 360

                         } else {
                             RotateDegree += 360

                         }
                     }

                 }


             }


    }
}

public struct CustomTypeEffect_RotateInX : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var RotateDegree = 0.0

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(RotateDegree), axis: (x: 0, y: 1, z: 0))
             .onAppear {
                 
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay).repeatForever(autoreverses: false)) {
                         RotateDegree += 360
                     }

                 }
             }


    }
}
public struct CustomTypeEffect_RotateInY : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var RotateDegree = 0.0

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(RotateDegree), axis: (x: 1, y: 0, z: 0))
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay).repeatForever(autoreverses: false)) {
                         RotateDegree += 360
                     }

                 }


             }


    }
}

public struct CustomTypeEffect_Rotate_in_y_backward : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var RotateDegree = 0.0

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(RotateDegree), axis: (x: 1, y: 0, z: 0))
             .onAppear {
                 
                 
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay).repeatForever(autoreverses: false)) {
                         RotateDegree -= 360
                     }

                 }


             }


    }
}

public struct CustomTypeEffect_Rotate_in_x_backward : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var RotateDegree = 0.0

    public func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(RotateDegree), axis: (x: 0, y: 1, z: 0))
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay).repeatForever(autoreverses: false)) {
                         RotateDegree -= 360
                     }

                 }
             }


    }
}



public struct CustomTypeEffect_AppearFromTop : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .offset(y: FirstAppear ? -properties.dimensions.y : 0
             )
            .scaleEffect(FirstAppear && properties.applyCustom.applyScale ? 0.5 : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
            .onAppear {
                if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                    withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                         FirstAppear = false
                     }
                    if properties.customTimeInterval.reverseAfter > 0.0 {
                        withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                             FirstAppear = true
                         }

                         
                     }

                 }
                
                
             }
             .onDisappear{
                 FirstAppear = true

             }


    }
}

public struct CustomTypeEffect_AppearFromBottom : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .offset(y: FirstAppear ? properties.dimensions.y : 0)
            .scaleEffect(FirstAppear && properties.applyCustom.applyScale ? 0.5 : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
            //.animation(.spring(duration:properties.duration), value: FirstAppear)
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                         FirstAppear = false
                     }
                     if properties.customTimeInterval.reverseAfter > 0.0 {
                         withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                             FirstAppear = true
                         }

                         
                     }


                 }


             }
             .onDisappear{
                 FirstAppear = true

             }


    }
}

public struct CustomTypeEffect_AppearFromLeft : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .offset(x: FirstAppear ? -properties.dimensions.x : 0)
            .scaleEffect(FirstAppear && properties.applyCustom.applyScale ? 0.5 : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
            //.animation(.spring(duration:properties.duration), value: FirstAppear)
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                         FirstAppear = false
                     }
                     if properties.customTimeInterval.reverseAfter > 0.0 {
                         withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                             FirstAppear = true
                         }

                         
                     }


                 }

             }
             .onDisappear{
                 FirstAppear = true

             }


    }
}

public struct CustomTypeEffect_AppearFromRight : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .offset(x: FirstAppear ? properties.dimensions.x : 0
             )
            .scaleEffect(FirstAppear && properties.applyCustom.applyScale ? 0.5 : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
             .onAppear {
                 if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                     withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                         FirstAppear = false
                     }
                     if properties.customTimeInterval.reverseAfter > 0.0 {
                         withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                             FirstAppear = true
                         }

                         
                     }


                 }
                 
             }
             .onDisappear{
                 FirstAppear = true

             }


    }
}



public struct CustomTypeEffect_FallingWithRotate : ViewModifier,Sendable {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true
    @State private var timer :Timer? = nil
    @State private var FallValue    = 0.0
    @State private var RotateValue  = 0.0

    public func body(content: Content) -> some View {
        content
            .offset(y: FirstAppear ? -FallValue : 0
             )
            .rotationEffect(.degrees(FirstAppear ? RotateValue : 0))
            .animation(CustomTypeEffect.getAnimation(a: properties.animation, duration: 0.1 )?.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed) ??
                       properties.animation.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed), value: FirstAppear)
            .onAppear {
               FirstAppear = false
                FallValue = properties.dimensions.y
                RotateValue = properties.valuesCustom.Rotate
               //print(FallValue)
                timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {_ in
                    MainActor.assumeIsolated {
                            FallValue = FallValue / 2
                            //print(FallValue)
                             RotateValue = FirstAppear ? 0 : properties.valuesCustom.Rotate

                            FirstAppear.toggle()
                            if FallValue < 1.0 {
                                RotateValue = 0.0
                                timer?.invalidate()
                            }

                        

                    }
                   //print(FallValue)
               }
               timer?.fire()

           }
           .onDisappear {
               FirstAppear = true
               timer?.invalidate()
               timer = nil

           }


    }
}

public struct CustomTypeEffect_HeavyFalling : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true
    @State private var timer :Timer? = nil
    @State private var FallValue  = 0.0

    public func body(content: Content) -> some View {
        content
            .offset(y: FirstAppear ? -FallValue : 0
             )
            .animation(CustomTypeEffect.getAnimation(a: properties.animation, duration: 0.1 )?.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed) ??  properties.animation.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed), value: FirstAppear)
           .onAppear {
               
               FirstAppear = false
               FallValue = properties.dimensions.y
               //print(FallValue)
               
               timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {_ in
                   MainActor.assumeIsolated {
                       
                       FallValue = FallValue / 2
                       FirstAppear.toggle()
                       if FallValue < 0.1 {
                           timer?.invalidate()
                       }
                   }
                   //print(FallValue)
               }
               timer?.fire()

           }
           .onDisappear {
               FirstAppear = true
               timer?.invalidate()
               timer = nil

           }

    }
}


public struct CustomTypeEffect_Default : ViewModifier  {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .scaleEffect(FirstAppear && properties.applyCustom.applyScale ? 0.5 : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
            .onAppear {
            
                
                if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                    withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                        FirstAppear = false
                    }
                    if properties.customTimeInterval.reverseAfter > 0.0 {
                        withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                            FirstAppear = true
                        }

                        
                    }


                }

                
            }
            .onDisappear {
                FirstAppear = true
            }
    }
}


public struct CustomTypeEffect_Zoom : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true

    public func body(content: Content) -> some View {
        content
            .scaleEffect(FirstAppear  ? properties.valuesCustom.ZoomInScale : 1)
            .opacity(FirstAppear && properties.applyCustom.applyOpacity ? 0.1 : 1)
            .blur(radius:FirstAppear && properties.applyCustom.applyBlur ? 50 : 0)
            .onAppear {
                
                if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                    withAnimation(customAnimation.speed(properties.customTimeInterval.speed).delay(properties.customTimeInterval.delay)) {
                        FirstAppear = false
                    }

                    if properties.customTimeInterval.reverseAfter > 0.0 {
                        
                        withAnimation(customAnimation.speed(1.5).delay(properties.customTimeInterval.reverseAfter + properties.customTimeInterval.delay )) {
                            FirstAppear = true
                        }
                    }



                }


                

            }
            .onDisappear {
                FirstAppear = true
            }
    }
}






public struct CustomTypeEffect_Rotate : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true
    @State private var timer :Timer? = nil
    @State private var RotateValue  = 0.0
    
    
    


    public func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(RotateValue))
            .onAppear {
                if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                    withAnimation(customAnimation.delay(properties.customTimeInterval.delay)
                        .speed(properties.customTimeInterval.speed).repeatForever(autoreverses: false)) {
                            RotateValue += 360.0
                        }

                }

            }
            .onDisappear {
                timer = nil
                FirstAppear = true
            }
    }
}

public struct CustomTypeEffect_RotateBackward : ViewModifier {
    var properties : CustomAnimationProperty
    
    @State private var FirstAppear  = true
    @State private var timer :Timer? = nil
    @State private var RotateValue  = 0.0

    public func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(RotateValue))
            .onAppear {
                if let customAnimation = CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration) {
                    withAnimation(customAnimation.delay(properties.customTimeInterval.delay)
                        .speed(properties.customTimeInterval.speed).repeatForever(autoreverses: false)) {
                            RotateValue -= 360.0
                        }
                }

            }
            .onDisappear {
                timer = nil
                FirstAppear = true
            }
    }
}


public struct CustomTypeEffect_Shake : ViewModifier {
    var properties : CustomAnimationProperty
    
    
    
    @State private var FirstAppear  = true
    @State private var timer :Timer? = nil
    @State private var ShakeTimeInterval = 0.0

    public func body(content: Content) -> some View {
        content
            .offset(x: FirstAppear ? -properties.dimensions.x : properties.dimensions.x, y: FirstAppear ? -properties.dimensions.y : properties.dimensions.y)
            .animation( CustomTypeEffect.getAnimation(a: properties.animation, duration: properties.customTimeInterval.duration )?.delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed) ??
                .spring(duration: properties.customTimeInterval.duration).delay(properties.customTimeInterval.delay).speed(properties.customTimeInterval.speed), value: FirstAppear)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: properties.customTimeInterval.duration, repeats: true) {_ in
                    
                    MainActor.assumeIsolated {
                            
                            if ShakeTimeInterval > properties.customTimeInterval.stopAfter && properties.customTimeInterval.stopAfter > 0.0 {
                                timer?.invalidate()
                                return
                            }
                            FirstAppear.toggle()
                            ShakeTimeInterval += properties.customTimeInterval.duration
                        
                    }
                }
                timer?.fire()

            }
            .onDisappear {
                timer = nil
                FirstAppear = true
            }

    }
}







