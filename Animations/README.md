# Day 32

## Animations

Два типа анимаций существует в SwiftUI:
- implicit - неявные анимации
- explict -  явные

Пока разберем неявные анимации, потому что они проще

Неявная анимация это модификатор, который прикрепляется к объекту

Например: 

```swift

Button("Title") { 
	// do action
}
.animation(.default)

```

Теперь эта кнопка, будет менять свой вид с анимацией, по мере изменений переменных - состояний, которые связаны с нашей кнопкой

Например:

```swift

@State private var amountOfTap = 0

Button("Title") { 
	amountOfTap += 1
}
.scaleAffect(amountOfTap)
.animation(.default)

```

## Custom animations

В примере выше мы использовали классическую анимацию ***.default***, что означает: плавное начало анимации -> небольшое ускорение -> плавное окончание анимации. Мы можем изменять ход выполнения анимаций, если передадим в инициализатор другой параметр выполнения анимаций.  (Например: ***.easeOut*** ) . 

Мы можем устанавливать для анимации такие параметры как задержка и протяженность 

```swift

.animation(easeIn(duration: 2))

```

Можно то же самое написать в более привычном для нас виде и при этом устанавливать разные модификаторы для анимации 

```swift

.animation(
	Animation
		.easyInOut(duration: 2)
		.delay(2)
		.repeatCount(2, autoreverses: true)
)

```

## Animating bindings

Любую связку можно анимировать, т.е анимировать процесс изменения между двумя состояниями. 

Например:

```swift

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

```swift

Stepper("Tap", value: amountOfAnimation.animation(Animation.easyInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10)

```

## Explicit animations

Давайте разберем пример явной анимации: 

```swift

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
	.degrees(thirdAnimationAmount), axis: (x: 0, y: 1, z: 0)
)

```

Мы указали явно, какое состояние мы хотим анимировать с помощь ***withAnimation***.
(В предыдущем примере у нас была ситуация, когда анимировались все изменяемые состояния, которые были прикреплены к view)

Так же как в случае с неявными анимациями, мы можем передавать разные параметры

Например:

```swift

withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
	self.animationAmount += 360
}

```

## Animation order

Уже несколько раз упоминалось, что анимация - модификатор. А как известно порядок установки модификаторов важен. 

Например 

```swift

@State private var isOn = false

var body: some View { 
	Button("Tap me") { 
		isOn.toggle()
	}
	.animate(.default)
	.backgroundColor(isOn ? Color.red : Color.blue)
}


```
В примере выше все, что связано с состоянием ***isOn*** анимироваzться не будет, поскольку модификатор анимации установлен раньше, модификатор фона

Чтобы изменения происходили с анимацией достаточно поменять порядок модификаторов

Например: 

```swift

}
.backgroundColor(isOn ? Color.red : Color.blue)
.animate(.default)

```

Анимации могут быть применены к определенным модификаторам

Например: 

```swift

Button("Tap me") { 
	isOn.toggle()
}
.backgroundColor(isOn ? Color.red : Color.blue)
.frame(width: 100, height: 100)
.animate(nil)
.clipShape(RoundedRectangle(cornerRadius: isOn ? 50 : 0))
.animate(.default)

```

***animation(nil)*** отменяет анимацию для модификаторов, которые установлены выше ***animation(nil)*** 
В приведенном выше примере анимирование произойдет только для изменения формы кнопки 

Вместо отмены анимации можно запускать другую

Например: 

```swift

Button("Tap me") { 
	isOn.toggle()
}
.frame(width: 100, height: 100)
.backgroundColor(isOn ? Color.red : Color.blue)
.animation(.easeIn)
.clipShape(RoundedRectangle(cornerRadius: isOn ? 50 : 0))
.animate(.default)

```

(Анимация изменения формы будет отличаться от анимации изменения фона)

 ## Animation Gestures
 
Чтобы добавить жест на view, можно использовать модификатор ***.gesture***, в котором указать тип жеста

Например: 

```swift

@State private var dragAmount = CGSize.zero

LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
	.frame(width: 100, height: 100, alignment: .center)
	.clipShape(RoundedRectangle(cornerRadius: 10))
	.offset(dragAmount)
	.gesture(DragGesture())

```

В примере выше мы указали жест перемещения для градиента (типы жестов Вам должно быть знакомо из UIKit) 
(по мере изменения ***dragAmount*** будет меняться ***.offset()*** градиента т.е отступ от начальной точки)

У ***DragGesture()*** есть два метода, где у первого есть входной параметр, с помощью которого можно узнать текущее положение пальца на экране (второй метод срабатывает после того, как палец был поднят с экрана)

```swift

DragGesture()
	.onChanged { currentPoint in currentPoint.translation}
	.onEnded { _ in self.dragAmount = .zero  }

```

Теперь можно анимировать возврат карточки в начальную точку с помощью явной анимации ***withAnimation***

```swift

.onEnded { _ in
	withAnimation(.spring()){
		self.dragAmount = .zero
	}
}

```

## Transitions

***Transitions*** это встроенный способ, который поможет легко анимировать переход вашего вью (переход - процесс показа/скрытия вью)

Создать переход можно с помощью ***if***

Пример: 

```swift

@State private var isShown = true

var body: Some View { 
	VStack { 
		Button("Tap me") {
			isShown.toggle()
		}

		if (isShown) {
			Rectangle()
				.fill(Color.red)
				.frame(width: 200, height: 200)
		}
	}
}

```

По нажатию кнопки, красный квадрат резко исчезает/появляется. Чтобы процесс перехода сопровождался с анимацией, можно использовать явную анимацию ***withAnimation***

Пример:

```swift

withAnimation { 
	isShown.toggle()
}

```

Давайте, теперь воспользуемся модификатором ***transition***, чтобы переход происходил с встроенной анимацией 
(типы анимаций, которые могут вступать, как параметры для ***transition*** вы можете найти в документации)

Пример: 

```swift

Rectangle()
	.fill(Color.red)
	.frame(width: 200, height: 200)
	.transition(.scale)

```

## Создание пользовательских переходов с помощью ***ViewModifier***

В файле ***CornerRotateModifier.swift*** представлен процесс создания кастомного модификатора перехода: 

***UnitPoint*** - это фиксированная точка, относительно которой происходит анимация
***clipped()*** - это аналог ***clipToBounds*** в UIKit (не отрисовать вью и его сабвью за рамки супервью)

C помощью расширения для ***AnyTransition*** мы создали свой модификатор для ***transition***. Указали мы в модификаторе ***modifier(active: ViewModifier, identity: ViewModifier)***  active, identity - положения вью, между которыми происходит анимация
