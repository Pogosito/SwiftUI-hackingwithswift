# Day 26

## Stepper

С помощью ***Stepper*** Вы можете запросить пользователя ввести число  

Пример:
```
...

@State private var stepperCounter: UInt8 = 0

var body: some View { 

    Stepper(value: stepperCounter) { 
        Text("Your value is \(stepperCounter)")
    }
}
...
```

По умолчанию ***Stepper*** имеет ограничения на максимальное и минимальное значение, как у типа, который отображает сам ***Stepper***. 
В примере выше мы способны отобразить значения из диапазона ***UInt8*** (т.е 0...255)

Чтобы изменить этот диапазон можно использовать другой инициализатор: 

Пример:

```
...

var body: some View { 

    Stepper(value: $stepperCounter, in: 5...15) {
        Text("Your value is \(stepperCounter)")
    }
}
...
```

По умолчанию, когда пользователь нажимает + или - мы изменяем отображаемое значение на 1. Но значение сдвига можно изменить

Пример:

```
...

var body: some View {

    Stepper(value: $stepperCounter, in 1...10, step: 5) { 
        Text("Your value is \(stepperCounter)")
    }
}
...
``` 

## DatePicker

***DatePicker*** - отличный способ для запроса от пользователя выбора определенной даты.  В новой версии IOS14 ***DatePicker*** оформлен в виде удобного календаря. 

***DatePicker*** способен на многое, например отображать только нужные компоненты даты

Например, мы можем сделать так, чтобы пользователь вводил только время (часы + минуты):

```
@State private var date = Date() 

var body: some View { 
    DatePicker("Please enter a time", 
                selection: $wakeUp, 
                displayedComponents: .hourAndMinute)
}
```

Также как в обычном ***Picker*** мы можем задать диапазон для выбора дат

Пример:

```
    DatePicker("Date", selection: $date, in: Date()...)
```

где ***Date()...*** означает диапазон от настоящего времени до любого будущего
