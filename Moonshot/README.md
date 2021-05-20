#  Day 39

##  GeometryReader

`GeometryReader` нужно воспринимать как контейнер для разных view, размеры, которых могут меняться от того, что меняется размер у самого контейнера, также в данном контейнере нет ограничений на то, как размещать дочерние view

(Более подробно мы познакомимся с данным view в проекте 15)

Пример: 

```swift

var body: some View { 
  GeometryReader { geo in 
    Image("Your image")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: geometry.size.width)
  }
}

```

(модификатор ***aspectRation*** очень похож на  contentMode у UIView в UIKit, только с двумя типами размещения контента )
(модификатор ***resizable*** говорит своему view менять размеры, когда размеры родителя view изменились)


## ScrollView

`ScrollView` - это тоже самое что UISScrollView из UIKit, но более удобный

Пример: 

```swift

var body: some View {
  ScrollView(.vertical) {
    VStack {
      ForEach(0..<100) {
        Text("\($0) Row")
      }
    }
    .frame(maxWidth: .infinity)
  }
}

```

Как можно заметить, мы меняем размеры не самого `ScrollView`, а у первого subview (в  данном случае у VStack)

## NavigationLink

С помощью `NavigationLink` легко создать навигацию в вашем IOS приложении. Навигация работает также как и при push в UIKit. 

Пример: 

```swift

var body: some View {
  VStack {
    NavigationLink(destination: Text("Detail label"), label: {
      Text("Next View")
    })
  }
}

```

В параметр `destination`, можно вписать любой тип view от самого простого, как у нас в примере, до целого экрана

## Day 41

## resizable

Данный модификатор позволит изменять размеры картинок напрямую 

## aspectRatio(_:contentMode:) || scaledToFit || scaledToFill

Сегодня для себя разобрался, что `aspectRatio(nil contentMode: .fit)` тоже самое что и `scaledToFit()` (так же как и `aspectRatio(nil contentMode: .fill)` и `scaledToFill()`)

Эти модификаторы сохраняют соотношение сторон view.

Если задан параметр `.fill` (или просто вызвано `scaledToFit()`), то меньшая из сторон вью заполнит родительское вью собой, а большая сторона высчитывается в зависимости от коэффициента

Если задан параметр `fit` (или просто вызвано `scaledToFill()`), то большая из сторон вью заполнит родительское вью собой, а меньшая сторона высчитывается в зависимости от коэффициента
