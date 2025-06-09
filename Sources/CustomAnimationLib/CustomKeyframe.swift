import SwiftUI






public struct AddCustomKeyframeAnimationModifier : ViewModifier {
    var frames : [(() -> Void)]
    
    
    var animation   : Animation = .linear
    var duration                = 0.1
    var speed                   = 0.5
    var delay       : TimeInterval = 1
    var Repeat      : Bool       = true

    @State private var ActiveIndex     = 0
    @State private var TimerCount      = 0

    
    @State private var AnimationTimer       : Timer? = nil

    


    nonisolated func NextAction () {
        
        MainActor.assumeIsolated {
                if let active = frames[safe:ActiveIndex] {
                    active()

                }
                ActiveIndex += 1
                if ActiveIndex > frames.count - 1 {
                    ActiveIndex = 0

                }

            

        }


    }
    public func body(content: Content) -> some View {
        
        content
            .onAppear {
                if Repeat {
                    NextAction()
                    AnimationTimer = Timer.scheduledTimer(withTimeInterval: delay , repeats: true){ _ in
                        withAnimation(CustomTypeEffect.getAnimation(a: animation, duration: duration)?.repeatCount(1)) {
                            
                            NextAction()
                        }
                        

                    }
                    AnimationTimer?.fire()

                } else {
                    AnimationTimer = Timer.scheduledTimer(withTimeInterval: delay , repeats: true){ _ in
                        MainActor.assumeIsolated {
                            withAnimation(CustomTypeEffect.getAnimation(a: animation, duration: duration)?.repeatCount(1)) {
                                NextAction()
                            }
                            TimerCount += 1
                            if TimerCount == frames.count {
                                AnimationTimer?.invalidate()
                                
                            }


                        }

                    }
                    AnimationTimer?.fire()

                
                }

            }
            .onDisappear {
                AnimationTimer?.invalidate()
                AnimationTimer = nil
            }
        
        
    }
}


public struct AddCustomKeyframeAnimationViewModifier : ViewModifier {
    var frames : [any View]
    
    var speed       : Double     = 0.5
    var delay       : TimeInterval = 2
    var Repeat      : Bool       = true

    @State private var ActiveIndex     = -1
    @State private var TimerCount      = 0
    @State private var id              = 0

    
    @State private var AnimationTimer : Timer? = nil

    @State private var CurrentView : AnyView? = nil

    


    nonisolated func NextFrame () {
        MainActor.assumeIsolated {
            ActiveIndex += 1
            if ActiveIndex > frames.count - 1 {
                ActiveIndex = 0

            }

            if let active = frames[safe:ActiveIndex] {
                //active.frame()
                id += 1
                CurrentView = AnyView(active)
                if !Repeat {
                    TimerCount += 1
                    if TimerCount == frames.count {
                        AnimationTimer?.invalidate()
                        
                    }

                }

            }

        }
        
        


    }
    public func body(content: Content) -> some View {
        
        VStack {
            if CurrentView != nil {
                CurrentView

            }

        }
        .id(id)
        .onAppear {
            if AnimationTimer != nil {return}
            if Repeat {
                AnimationTimer = Timer.scheduledTimer(withTimeInterval: delay , repeats: true){ _ in
                    NextFrame()
                    

                }
                AnimationTimer?.fire()

            } else {
                AnimationTimer = Timer.scheduledTimer(withTimeInterval: delay  , repeats: true){ _ in
                    NextFrame()

                }
                AnimationTimer?.fire()

            
            }

        }
        .onDisappear {
            AnimationTimer?.invalidate()
            AnimationTimer = nil
            CurrentView = nil
        }
        
        

        
        
    }
}


