//
//  ContentView.swift
//  BetterRest
//
//  Created by Pogos Anesyan on 01.03.2021.
//

import SwiftUI

struct ContentView: View {

    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0

    @State private var alertTitle = "Your ideal bedtime is ..."
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {

        let wakeUpBinding = Binding(
            get: {
                return wakeUp
            },
            set: {
                self.wakeUp = $0
                calculateBedTime()
            }
        )

        let sleepAmountBinding = Binding(
            get: {
                return sleepAmount
            },
            set: {
                self.sleepAmount = $0
                calculateBedTime()
            }
        )

        let coffeeAmountBinding = Binding(
            get: {
                return coffeeAmount
            },
            set: {
                self.coffeeAmount = $0
                calculateBedTime()
            }
        )

        return NavigationView {
            Form {
                Section(header: Text("When do you want to wake up ?")) {
                    DatePicker("Please entire a time",
                               selection: wakeUpBinding,
                               displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: sleepAmountBinding,
                            in: 4...13) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }

                Section(header: Text("Daily coffee intake")) {
                    Picker("Bla", selection: coffeeAmountBinding) {
                        ForEach(1..<21) { amountOfCups in
                            amountOfCups == 1 ? Text("1 cup") : Text("\(amountOfCups) cups")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(alertTitle)
                            .font(.system(size: 25.0,
                                          weight: .regular,
                                          design: .rounded))
                            .foregroundColor(Color.blue)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Text(alertMessage)
                            .foregroundColor(Color.blue)
                        Spacer()
                    }
                }
                .listRowBackground(Color.init(#colorLiteral(red: 0.959415853, green: 0.9599340558, blue: 0.9751341939, alpha: 1)))
            }
            .navigationBarTitle("BetterRest")
//             Интересный инициализатор кнопки, который позволяет пропустить создания кложуры для действия этой кнопки, но при этом позволяет вызывать существующий метод, который будет выполняться по нажатию кнопки.
//            .navigationBarItems(trailing: Button(action: calculateBedTime, label: {
//                Text("Calculate")
//            }))
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text(alertTitle),
//                      message: Text(alertMessage),
//                      dismissButton: .default(Text("OK")))
//            }
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    func calculateBedTime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter  = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is ..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
