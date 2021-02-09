#  Day 20

## HStack/VStak/ZStack

Сегодня познакомимся с новыми элементами, которые помогут нам легко группировать элементы: ***HStack***, ***VStak***, ***ZStack***

Как можно догадаться элементы группируются определённым образом в этих контейнерах.
***HStack*** - группирует по оси X (горизонтально)
***VStak*** - группирует по оси Y (вертикально)
***ZStack*** - группирует по оси Z (в глубину/накладывает элементы друг на друга, причем первый в списке в  ***ZStack*** будет самым глубоким)

Изначально элементы идут друг за другом плотно, но можно с помощью инициализатора задать расстояние между объектами в контейнере ***HStack(spacing: )***  (это справедливо и для ***VStack*** ) так же spacing может принимать и отрицательные значения. (для ***ZStack*** spacing не играет никакой роли)

Напоминание:
- Стоит напомнить, что ограничение в не более 9 дочерних элементов никуда не пропадет (чтобы обойти это пользуйтесь ***Group***, ***Section***)

В этих контейнерах, можно легко  выравнивать текст, прописав в инициализаторе параметр ***alignment***

Как можно заметить, эти контейнеры располагают элементы предпочтительно в центр экрана, чтобы это изменить можно добавить пустое вью) ***Spacer()***, после добавления этого элемента вы сдвинете контент в противоположную сторону или раздвинете контент, если добавите  ***Spacer()*** между вьюшками

## Colors and Frames

В SwiftUI с помощью модификатора ***.background*** можно задать цвет для объекта, НО! этот модификатор принимает view, да все цвета в SwiftUI - view.

Объекты типа ***Color*** занимают все доступное им место в контейнере, в зависимости от распложения ***Color***

```
(Размещает фон *Stack)
*Stack {
    Objects....
}.background(Color.(someColor))

(Размещает фон на все свободное пространство по определенному направлению (в зависимости от контейнера))

*Stack {
Color.(someColor)
    Objects....
}

```


Замечания:
- Поскольку ***Color*** - view, мы можем задать для этого объекта ***frame***.
- Также ***Сolor*** может растягиваться на весь экран, при этом игнорировать безопасную зону ***edgesIgnoringSafeArea(.all)***

## Gradients

Градиент тоже является view, чтобы создать градиент нужно указать цвета градиента, в каком направлении будет меняться цвет, размер градиента и тип градиента

Существует три типа градиента:
- Линейный
- Круговой
- Конический

## Buttons/Images

Кнопку в SwiftUI можно создать двумя способами:


Простая кнопка:

```
Button("Title") {
    print("Button was tapped")
}

Сложная кнопка состоящая из нескольких view:

Button(action: {
    print("Button was tapped")
}) {
    VStack {
        Image(systemImage: "Book")
        Text("Сложная кнопка")
    }
}

```
В SwiftUI есть тип  Image, который позволяет работать с картинками.
Один из инициализаторов способен отключить считыватель экрана

```
Image(decorative: "pencil")

```

Как в UIKit, можно установить ***renderingMode***, чтобы использовать оригинальную картинку

## Alert

Как и другие элементы в SwiftUI алерт также работает по принципу "Вид является функцией состояния". Вместо того, чтобы просто вызывть какой - то метод "показать алерт", мы заводим переменную состояния, при изменении которой показывается алерт
(после того как пользователь закрывает алерт, состояние автоматически переходит в первоначальное состояние)

Замечение, чтобы алерт показывался, нужно прикрепить модификатор ***.alert()*** к одной из частей тела структуры, где планируется показать  алерт. Что интересно, неважно куда прикреплять модификатор, главное, чтобы он был один на оперделенном вью

```
Пример

Правильно: 
@State private var isAlertShow = false

var body: some View { 
    Button(Text("Show alert")) { 
        isAlertShow = true
    }.alert(isPresented: $isAlertShow, content: {
        Alert(title: Text("Some message"), message: Text("SomeText"), dismissButton: .default(Text("OK")))
    })
}

```