#  Day 36 

## @State с Структурами

Ранее мы работали с *простыми* состояниями нашего вью: *Int*, *String*, *Double* ..., т.е состояния, которые представляют собой одну величину, а что если усложнить состояние

Например: 

```

struct User { 
	var name: String = "Pogos"
	var secondName: String = "Anesyan"
}

struct ContentView: View {

	@State private var user = User()

	var body: some View {
		VStack { 
			Text("User: \(user.name), \(user.secondName)")
			TextField("New user name:", $user.name)
			TextField("New user second name:", $user.secondName)
		}
	}
}

```

Все здорово, мы можем теперь работать со сложными состояниями, но есть пару НО: 
- А насколько это производительно ? 
- Можем ли мы изменять один объект состояние из двух разных мест программы? 

Вам должно быть известно, когда модифицируется поле у структуры, то мы пересоздаем структуру с новыми значениями, как следствие в программе выше при вводе ***user name*** или ***second name*** наше поле user пересоздается с новыми данными. Немного расточительно, все таки мы хотим создавать производительные программы.

Вторая проблема, представим, что у нас есть вторая переменная, которая хочет тоже изменять user в ContentView, но как Вам должно быть известно, структура - value type, т.е при попытке присвоить объект структуры другой переменной мы получим копию этого объекта, но уже в другой переменной, как следствие любые изменения в этих объектах будут не согласованы

Решение: использовать вместо *struct* *class*

```

class User { 
	var name: String = "Pogos"
	var secondName: String = "Anesyan"
}

...

```

Но теперь, если пользователь введет новое имя или фамилию, то на экране ничего не поменяется.
Это связано с тем, что переменная состояние user теперь не пересоздается при новых данных, а всего лишь меняет свойства у себя.

Чтобы отслеживать изменения свойств объекта состояния и как следствие перестраивать все вью, нужно воспользоваться модификатором ***@Published*** 

## ObservedObject / ObservableObject / @Published

Чтобы теперь уведомлять все вью о изменениях, которые завязаны на свойствах класса, нужно отметить эти свойства модификаторами ***@Published***, но этого не достаточно, Нужно, чтобы объекты свойства наблюдали за уведомлениями о изменениях, для этого нужно отметить это свойство ***@ObservedObject***, а сам класс должен комфермить протокол ***ObservableObject***

Пример:

```

class User: ObservableObject { 
	@Published name: String = "Pogos"
	@Published secondName: String = "Anesyan"
}

struсt ContentView: View {

	@ObservedObject private var user = User()

	var body: some View {
		VStack { 
			Text("User: \(user.name), \(user.secondName)")
			TextField("New user name:", $user.name)
			TextField("New user second name:", $user.secondName)
		}
	}
}

```

## Как показать новое вью

В SwiftUI есть много способов показать новое вью, один из способов это использовать модификатор ***sheet***. Этот модификатор очень похож на ***alert***

Пример:

```

struct SecondView: View {

	var body: some View { 
		Text("This is a second view")
	}
}

struct ContentView: View { 

	@State private var isSecondViewShow = false

	var body: some View { 
		Button("Show second view") { 
			isSecondViewShow.toggle()
		}
		.sheet(isPresented: $isSecondViewShow) { 
			SecondView()
		}
	}	
}

```

Так же как и к для ***alert*** нам понадобилось создать переменную - состояние, по мере изменения которой будет показываться новое вью.
И воспользовались модификатором ***sheet***, в теле которого указываем вью, которое хотим отобразить. 

Второй способ скрытия: 

Пример: 

```

struct SecondView: View { 

	@Environment(\.presentationMode) var presentationMode

	var body: some View { 
		Button("Dismiss second view") { 
			presentationMode.wrappedValue.dismiss()
		}
	}
}

...

```
Новая оболочка свойства ***@Environment*** позволяет в рантайме понять в какой "среде" находится вью. Под средой тут подразумеваются условия, которые задает пользователь из вне: темная/светлая тема, время, размер шрифта, вью открыто/закрыто.  

Каждое условие имеет имя: 
Нас интересует открыто/закрыто вью *- **presentationMode*** 
В переменной `presentationMode`  у нас хранится информация открыто/закрыто ли вью, теперь мы можем эту переменную модифицировать так, как нам нужно. 

## OnDelete 

***onDelete*** - это простой способ удалять ненужные ячейки из ***List***, только надо помнить, что ***onDelete*** прикрепляется не к ***List***, а к ***ForEach***

Например: 

```

@State private var numbers: [Int] = [1, 2, 3] 

...

List {
	ForEach(numbers, id: \.self) { 
		Text("\($0)")
	}
	.onDelete(perform: { indexSet in
		numbers.remove(atOffsets: indexSet)
	})
}

```

Важно помнить, что нужно идентифицировать объекты так, чтобы они не повторялись, иначе будут проблемы с удалением объектов с одинаковыми ID

# Day 37

Использование знаний от 36 дня для создания проекта iExpense
