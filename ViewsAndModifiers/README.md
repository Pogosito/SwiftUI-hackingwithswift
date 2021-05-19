#  Day 23

## Почему же SwiftUI использует структуры для своих вью ? 

Это удобно и проверено на практике структуры легкие более производительные и более независимые.
Пример. Когда мы работаем в UIKit то любой UI - элемент наследуется от UIView, при этом все содержимое класса UIView дублируются в классах-наследниках (ведь так работает наследование), даже если эти поля не используются или даже вовсе эти поля никак не влияют на работу класса. (пример UIStackView, попробуйте поменять фон для этого элемента)

Что насчет независимости, когда вы создаете структуры вы даже не задумываетесь, что существует помимо этой структуры, просто пишете код, который содержит исключительно то, что есть в скоупе структуры.

Структуры неизменяемы, как следствие, мы получаем легко контролируемый код, который делает то, что мы ожидаем.

## Что находится позади главного вью ?

Если смотреть в корень, то за начальным вью (код который генерируется при создании проекта) находится объект класса ***UIHostingController***, который является мостом между UIKit и SwiftUI (все таки пока SwiftUI не может существовать без  UIWindow, на котором размещаются виды написанные на SwiftUI).

Вы должны попытаться проникнуться убеждением, что за нашим вью ничего нет то, что вы видите, – это все, что у нас есть.

Как только вы это осознаете, вы  поймете, что чтобы поменять весь фон нужно растянуть элемент на весь экран
(это можно сделать с помощью ***frame(maxWidth:, maxHeight: )*** ,  ***frame(width:, height: )*** , отличие лишь в том, что при использовании первого способа, при наличии других вью, SwiftUI позаботиться, чтобы другие вью не были перекрыты

##  Почему порядок модификаторов важен ? 

Важно понимать, что каждый модификатор применяется поочереди и каждый модификатор фактически создает новое представление

Поэтому следующие два элемента будут выглядеть по - разному

```swift

// Элемент 1

Button { 
	// someAction
}
.backgroundColor(Color.red)
.frame(width: 200, height: 200)

// Элемент 2

Button { 
	// someAction
}
.frame(width: 200, height: 200)
.backgroundColor(Color.red)

```

Элемент 1 - кнопка размера 200 x 200, но окрашен только маленький кусочек в центре
Элемент 2 - кнопка размера 200 х 200 при этом окрашено все пространство кнопки

Даже типы эти двух элементов разные

Тип Элемента 1 - ***ModifiedContent<ModifiedContent<Button<Text>, _BackgroundModifier<Color>>, _FrameLayout>***

Тип Элемента 2 - ***ModifiedContent<ModifiedContent<Button<Text>, _FrameLayout>, _BackgroundModifier<Color>>***

## Почему SwiftUI использует "some View" для возврата

Возврат ***someView*** имеет два важных отличия по сравнению с возвратом ***view*** 

- Мы должны всегда возвращать один и тот же тип 
- Даже если мы не знаем, какой тип возвращается, то компилятор знает 

Если мы не имеет представления, какой тип возвращается, SwiftUI не сможет быстро обновить пользовательский интерфейс (В такой ситуации SwiftUI занимался бы перебором и медленно бы выяснял, что именно изменилось, после каждого обновления UI)

Поскольку ***view*** дженерик протокол, то просто его вернуть не получиться, нужно точно знать тип, который возвращается точно. За нас это сделает компилятор. 

## Как работают контейнеры VStack/ZStack/HStack под капотом в SwiftUI

При создании VStack, ZStack, HStack под капотом происходит создание ***TupleView***, который может содержать не более 10 сабвью.  

## Условия для модификаторов

Можно использовать тернарный оператор для использования вариации аргументов в модификаторах
Например: 

```swift

@State private var bool = false

Button("Some Text") { 
	bool.toggle()
}
.foregroundColor(bool ? .red : .blue)

```

Но при этом надо помнить, что следующий код не допустим 

```swift

if (someBool) { 
	Text("Some Text") 
		.foregroundColor(.blue)
} else { 
	Text("Some Text 2 ") 
		.foregroundColor(.red)
		.backgroundColor(.blue)
}

```

Эти два элемента в теле if {} else {} имеют разные модификаторы, как следствие, разные типы, а как говорилось выше мы должны всегда возвращать один и тот же тип в теле body. 

## Environment модификаторы

Если у Вас есть контейнер с элементами, где повторяется один и тот же модификатор, то можно внести его

Например:

```swift

VStack { 
	Text("SomeText")
		.font(.caption2)
	Text("SomeText") 
		.font(.caption2)
	Text("SomeText")
		.font(.caption2)
}

VStack { 
	Text("SomeText")
	Text("SomeText")
	Text("SomeText")
}
.font(.caption2)

```

Но нужно тут быть аккуратным, поскольку не каждый модификатор является Environment модификатором.

Например: 

```swift

VStack { 
	Text("")
	Text("")
	Text("")
}
.blur(10)

```

Блюр применяется не к каждому ***Text***, а ко всему стеку 

Единственный способ, как проверить является ли модификатор Environment модификатором - просто экспериментировать.

## View, как свойство

Чтобы держать тело структуры чистым, можно хранить используемые вьюшки, как свойство нашего Content View

Например:

```swift

struct ContentView: View {

	var someView = Text("SomeView")
	var someView2 = Text("SomeView2")

	var body: some View { 
		someView
		someView2
	}
}

```
## Кастомные view

Можно создавать кастомыне view 

Например, у Вас в теле вашего ContentView имеется: 

```swift

struct ContentView: View {

	var body: some View { 
		HStack {
			Text("Some Text")
				.font(.largeTitle)
				.padding()
				.foregroundColor(.white)
				.background(Color.blue)
				.clipShape(Capsule())
			Text("Some Text2")
				.font(.largeTitle)
				.padding()
				.foregroundColor(.white)
				.background(Color.blue)
				.clipShape(Capsule())
		}
	}
}

```

Имеем два одинаковых саб вью, но с разными текстами, можем организовать отдельную структуру

```swift

struct CapsuleText: View { 
	let text: String

	var body: some View { 
		Text(text)
			.font(.largeTitle)
			.padding()
			.foregroundColor(.white)
			.background(Color.blue)
			.clipShape(Capsule())
			} 
}

```

И далее использовать 

Пример: 
 
```swift

var body: someView {
	VStack { 
		CapsuleText(text: "")
		CapsuleText(text: "Bla")
	}
}

```

## Кастомные модификаторы

Если в приложении есть определенный стиль чего - то, и при этом очень часто повторяется, то можно создать кастомный модификатор. 

Например: 

```swift

struct CustomModifier: ViewModifier {

	func body(content: Content) -> some View { 
		content
			.modifier1()
			.modifier2()
			// Another modifiers...
	}
}

```

И чтобы теперь использовать созданный модификатор нужно использовать  ***modifier(your custom modifier)*** 

Но можно сделать ***extension*** для протокола ***view*** 

```swift

extension View {
	func useYourCustomModifier() -> some View { 
		self.modifier(CustomModifier)
	}
}

```

Также пользовательские модификаторы могут менять иерархию вью 

Например: 

```swift

struct CustomHierarchyModifier: ViewModifier {

	func body(content: Content) -> some View { 
		ZStack(alignment: .bottomTrailing) { 
			Color.red
			content
				.modifier()
				.modifier()
		}
	}
}

extension View { 

	func customHierarchyModifier() -> some View { 
		self.modifier(CustomHierarchyModifier())
	}
}

```

## Кастомные контейнеры

Этим не так часто будем заниматься, но это тоже надо сделать для полноты картины. 

В файле ***GridStask*** реализация кастомного контейнера

(как видно в файле ***GridStack***  мы используем следующую конструкцию ForEach ***ForEach(0..<rows, id: \.self)*** , об этом узнаем более подробно в пятом проекте) 

Если вы попробуйте разместить в каждой ячейке ***GridStask*** два вью, то код у Вас не скомпилируется. 

Чтобы дать возможность нам размещать в ячейках более одного вью, требуется поставить модификатор ***@ViewBuilder*** перед переменной в инициализаторе, которая отвечает за кложуру

Пример

```swift

init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content)

```

Теперь контент будет иметь возможность хранить в себе более одного вью. 

(теперь все что мы разместим в нашем контейнере автоматически будет добавлен в HStack, но если вы хотите, чтобы добавляемый контент в контейнер размещался вертикально, то оберните ***content*** в VStack)

