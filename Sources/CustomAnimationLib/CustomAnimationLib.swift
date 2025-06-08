import SwiftUI


extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


 extension View {
    
    
    public func AddKeyframeAction(action : [(() -> Void)],delay: TimeInterval = 1
    ,Repeat: Bool = true) ->  some View {
        
        self.modifier(AddCustomKeyframeAnimationModifier(frames:action,delay: delay,Repeat: Repeat))

        
    }
    
     public func AddKeyframeView(frames : [any View],speed: Double = 0.5,delay: TimeInterval = 1
    ,Repeat: Bool = true) ->  some View {
        
        self.modifier(AddCustomKeyframeAnimationViewModifier(frames:frames,speed: speed,delay: delay,Repeat: Repeat))

        
    }
    
    
    @ViewBuilder public func AddCustomAnimation(kind : CustomTypeEffect,properties :  CustomAnimationProperty,backward : Bool = false) ->  some View {
        
        switch(kind) {
            
        case .Default:
            self.modifier(CustomTypeEffect_Default(properties: properties))
        case .AppearFromTop:
            self.modifier(CustomTypeEffect_AppearFromTop(properties: properties))
        case .AppearFromBottom:
            self.modifier(CustomTypeEffect_AppearFromBottom(properties: properties))
        case .AppearFromLeft:
            self.modifier(CustomTypeEffect_AppearFromLeft(properties: properties ))
        case .AppearFromRight:
            self.modifier(CustomTypeEffect_AppearFromRight(properties: properties))
        case .Zoom:
            self.modifier(CustomTypeEffect_Zoom(properties: properties))
        case .Shake:
            self.modifier(CustomTypeEffect_Shake(properties: properties))
        case .HeavyFalling:
            self.modifier(CustomTypeEffect_HeavyFalling(properties: properties))
        case .FallingWithRotate:
            self.modifier(CustomTypeEffect_FallingWithRotate(properties: properties))
        case .Rotate:
            self.modifier(CustomTypeEffect_Rotate(properties: properties))
        case .RotateBackward:
            self.modifier(CustomTypeEffect_RotateBackward(properties: properties))
        case .Rotate3D:
            self.modifier(CustomTypeEffect_Rotate3D(properties: properties))
            
        case .RotateX:
            self.modifier(CustomTypeEffect_RotateInX(properties: properties))
        case .RotateXBackward:
            self.modifier(CustomTypeEffect_Rotate_in_x_backward(properties: properties))
            
        case .RotateY:
            self.modifier(CustomTypeEffect_RotateInY(properties: properties))
            
        case .RotateYBackward:
            self.modifier(CustomTypeEffect_Rotate_in_y_backward(properties: properties))
            
        case .CustomRotate:
            self.modifier(CustomTypeEffect_CustomRotate(properties: properties,backward:backward))
            
        }
    }


}

