# Day 32

## Animations

Два типа анимаций существует в SwiftUI:
- implicit - неявные анимации
- explict -  явные

Пока разберем неявные анимации, потому что они проще

Неявная анимация это тоже модификатор, который прикрепляется к объекту

Например: 

```
Button("Title") { 
    // do action
}
.animation(.default)

```

Теперь эта кнопка, будет менять свой вид с анимацией, по мере изменений переменных - состояний, которые связаны с нашей кнопкой

Например:

```

@State private var amountOfTap = 0

Button("Title") { 
    amountOfTap += 1
}
.scaleAffect(amountOfTap)
.animation(.default)

```

## Custom animations

В примере выше мы использовали классическую анимацию ***.default***, что означает: плавное начало анимации -> небольшое ускорение -> плавное окончание анимации. Мы можем изменять ход выполнения анимаций, если передадим в инициализатор другой параметр выполнения анимаций.  (Например: ***.easeOut*** ) . 

Мы можем устанавливать для анимации такие параметры как задержка и протяженность анимации 

```
.animation(easeIn(duration: 2))

```

Можно то же самое написать в более привычном для нас виде и при этом устанавливать разные модификаторы для анимации 

```
.animation(
    Animation
    .easyInOut(duration: 2)
    .delay(2)
    .repeatCount(2, autoreverses: true)
)

```

## Animating bindings

Любую связку можно анимировать, т.е анимировать процесс изменения между двумя состояниями. (Вьюшки, к которым привязаны анимированное значение будут изменять свои свойства с анимацией)

Например:

```
@State private var amountOfAnimation = 0

var body: some View {

    VStack { 
        Stepper("Tap", value: $amountOfAnimation.animation(), in 0...10) { 
            Button("Tap me") {
                secondAnimationAmount += 1
            }
            .padding(50)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(secondAnimationAmount)
        }
    }
}

```

Есть второй способ, как можно написать анимацию для перехода из одного состояния в другое

```
...

Stepper("Tap", value: amountOfAnimation.animation(Animation.easyInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10)

...
```

## Explicit animations

Давайте разберем пример явной анимации: 

```

Button("Tap me") {
    withAnimation {
        thirdAnimationAmount += 360
    }
}
.padding(50)
.background(Color.purple)
.foregroundColor(.white)
.clipShape(Circle())
.rotation3DEffect(
    .degrees(thirdAnimationAmount),
    axis: (x: 0, y: 1, z: 0)
)

```

Мы указали явно, какое состояние мы хотим анимировать с помощь ***withAnimation***.
(В предыдущем примере у нас была ситуация, когда анимировались все изменяемые состояния, которые были прикреплены к view)

Так же как в случае с неявными анимациями, мы можем передавать разные параметры

Например:

```

withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
    self.animationAmount += 360
}

```
