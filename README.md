<p align="center">
<img src="Animation1.gif" width="30%" height="30%">
    <img src="Animation4.gif" width="30%" height="30%">
<img src="Animation3.gif" width="30%" height="30%">
</p>


<div dir="rtl">

# 📚 مكتبة  CustomAnimationLib 
مكتبة Swift بسيطة تحوي انيميشن جاهزة وتحكم وانشاء انيمشن مخصص 😃

</div>


<div dir="rtl">

# 👨🏽‍💻 الكود :-
</div>


<div dir="ltr">

```swift
// الهيكل الاساسي لتعديل الانيميشن
public struct CustomAnimationProperty : CustomEffectProperty  {
    // نوع الانيميشن
    public var animation: Animation = .linear
    
    // x,y,z ابعاد
    public var dimensions         : Dimensions         = Dimensions()

    // قيم الوقت
    public var customTimeInterval : CustomTimeInterval = CustomTimeInterval()

    //  التحكم في اضافات الشفافية والضبابية
    public var applyCustom        : ApplyCustom        = ApplyCustom()

    //  قيم اضافية لتعديل قيم الدوران والزوم ايفكت
    public var valuesCustom       : ValuesCustom       = ValuesCustom()
}
```

</div>


<div dir="rtl">

# 📝 امثله سريعة للاستخدام :-  

</div>


<div dir="ltr">

```swift
// دوران مخصص
Text("مثال")
      .AddCustomAnimation(kind: .CustomRotate,
          properties: CustomAnimationProperty(dimensions: .init(x:4,y:1,z:1)
          )
      )

// دوران جاهز
Text("مثال")
      .AddCustomAnimation(kind: .Rotate, // ٍRotateX,RotateY,RotateXBackward,RotateYBackward
          properties: CustomAnimationProperty()
      )


// الظهور من الاعلى
Text("مثال")
      AddCustomAnimation(kind: .AppearFromRight,
          properties: CustomAnimationProperty(
                    dimensions: .init(x:1000),
                    customTimeInterval: .init(duration: 1)
          )
      )

// تأثير افتراضي 
Text("مثال")
     .AddCustomAnimation(kind: .Default,
            properties: CustomAnimationProperty(
                customTimeInterval: .init(duration:3.5)
            )
     )

// تأثير الزوم 
Text("مثال")
     .AddCustomAnimation(kind: .Zoom,
            properties: CustomAnimationProperty(
                customTimeInterval: .init(duration: 0.4,reverseAfter: 6),
                valuesCustom: .init(ZoomInScale: 3)
            )
     )

// تأثير السقوط 
Text("مثال")
    .AddCustomAnimation(kind: .HeavyFalling,
       properties: CustomAnimationProperty(
           dimensions: .init(y:2000),
           customTimeInterval: .init(duration: 0.1,speed: 1)
       )
    )


```
</div>

<div dir="rtl">

# 📀 انشاء عرض keyframe مخصص :-

</div>

<div dir="ltr">

```swift
// delay وقت الانتقال بين العناصر
//  لعكس التأثير قبل نهاية الديلاي الحالي reverseAfter نستخدم

let delay = 7.0 
let reverseAfter = delay - 1

VStack{}
      .AddKeyframeView(frames: [
        
                        HStack {
                            Spacer()
                            Text("😎")
                                .font(.system(size: 40))
                            Text("السلام عليكم")
                                .font(.custom("DGForshaScribble", size: 40))
                                .foregroundStyle(.black.gradient.shadow(.drop(color: .yellow, radius: 0, x:3,y:3)))
                            Spacer()

                        }
                        .AddCustomAnimation(kind: .AppearFromTop,
                              properties: CustomAnimationProperty(
                                dimensions: .init(y:1000),
                                customTimeInterval: .init(duration: 1.5,reverseAfter: reverseAfter)
                               )
                        ),

                        HStack {
                            Spacer()
                            Text("💎")
                                .font(.system(size: 40))
                            Text("عرض بسيط ")
                                .font(.custom("DGBebo-Bold", size: 50))
                                .foregroundStyle(.blue.gradient.shadow(.inner(color: .yellow, radius: 0, y: 1)))
                            Spacer()

                        }
                        .AddCustomAnimation(kind: .Zoom,
                            properties: CustomAnimationProperty(
                                customTimeInterval: .init(duration: 0.4,reverseAfter: reverseAfter),
                                valuesCustom: .init(ZoomInScale: 3)
                            )
                        ),
                        
                        ZStack {
                            Text("🖤")
                                .font(.system(size: 40))
                                .AddCustomAnimation(kind: .Default,
                                      properties: CustomAnimationProperty(
                                          customTimeInterval: .init(duration: 0.2,reverseAfter:reverseAfter)
                                      )
                                )
                                .zIndex(1)
                            Circle()
                                .fill(.pink.gradient)
                                .padding()
                                .frame(width: 100,height: 100)
                                .AddCustomAnimation(kind: .AppearFromRight,
                                    properties: CustomAnimationProperty(
                                        dimensions: .init(x:1000),
                                        customTimeInterval: .init(duration: 1,reverseAfter: reverseAfter)
                                    )
                                 )
                                .zIndex(0)


                        },
                        ZStack {
                            Text("👀")
                                .font(.system(size: 40))
                                .AddCustomAnimation(kind: .HeavyFalling,
                                    properties: CustomAnimationProperty(
                                        dimensions: .init(y:2000),
                                        customTimeInterval: .init(duration: 0.1,speed: 1)
                                    )
                                )
                                .AddCustomAnimation(kind: .Default,
                                      properties: CustomAnimationPropert(
                                         customTimeInterval: .init(duration: 0.2,reverseAfter: reverseAfter + 0.5)
                                      )
                                )
                                .zIndex(1)

                            Circle()
                                .fill(.yellow.gradient)
                                .padding()
                                .frame(width: 100,height: 100)
                                .zIndex(0)
                                .AddCustomAnimation(kind: .Default, properties: CustomAnimationProperty(customTimeInterval: .init(duration: 0.2,reverseAfter: reverseAfter)))



                        }

],delay: delay) 
```
</div>


<img src="Animation2.gif" width="30%" height="30%">

