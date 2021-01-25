//
//  ContentView.swift
//  UnitConversions
//
//  Created by Pogos Anesyan on 17.01.2021.
//

import SwiftUI

enum Constant {
    static let conversions: [(title: String, units: [Dimension], unitsStr: [String])] = [

        (title: "Distance",
         units: [
            UnitLength.megameters,
            UnitLength.kilometers,
            UnitLength.hectometers,
            UnitLength.decameters,
            UnitLength.meters,
            UnitLength.centimeters,
            UnitLength.decimeters,
            UnitLength.centimeters,
            UnitLength.millimeters,
            UnitLength.micrometers,
            UnitLength.nanometers,
            UnitLength.picometers,
            UnitLength.inches,
            UnitLength.feet,
            UnitLength.yards,
            UnitLength.miles,
            UnitLength.scandinavianMiles,
            UnitLength.lightyears,
            UnitLength.nauticalMiles,
            UnitLength.fathoms,
            UnitLength.furlongs,
            UnitLength.astronomicalUnits,
            UnitLength.parsecs,
         ],
         unitsStr: [
            "Megameters",
            "Kilometers",
            "Hectometers",
            "Decameters",
            "Meters",
            "Centimeters",
            "Decimeters",
            "Centimeters",
            "Millimeters",
            "Micrometers",
            "Nanometers",
            "Picometers",
            "Inches",
            "Feet",
            "Yards",
            "Miles",
            "ScandinavianMiles",
            "Lightyears",
            "NauticalMiles",
            "Fathoms",
            "Furlongs",
            "AstronomicalUnits",
            "Parsecs",
         ]
        ),

        (title: "Duration",
         units: [
            UnitDuration.hours,
            UnitDuration.minutes,
            UnitDuration.seconds,
            UnitDuration.milliseconds,
            UnitDuration.microseconds,
            UnitDuration.nanoseconds,
            UnitDuration.picoseconds
         ],
         unitsStr: [
            "Hours",
            "Minutes",
            "Seconds",
            "Milliseconds",
            "Microseconds",
            "Nanoseconds",
            "Picosecond",
         ]
        ),
    ]
}

struct ContentView: View {

    @State private var selectedMeasure = 0
    @State private var selectedFromUnit = 0
    @State private var selectedToUnit = 1
    @State private var value = "0"
    private var errorMessage = "Error: Please, enter valid value"

    var symbolFrom: String {
        let measure = Constant.conversions[selectedMeasure]
        return measure.units[selectedFromUnit].symbol
    }

    var result: (value: Double, symbol: String?) {
        let measure = Constant.conversions[selectedMeasure]
        if value.isEmpty {
            return (0, nil)
        }
        if let safeValue = Double(value) {
            let measureValue = Measurement(value: safeValue, unit: measure.units[selectedFromUnit])
            let convertedValue = measureValue.converted(to: measure.units[selectedToUnit])
            
            return (convertedValue.value, convertedValue.unit.symbol)
        }
        return (Double.infinity, nil)
    }

    var body: some View {
         NavigationView {
            Form {
                Section {
                    Picker("Choose measure", selection: $selectedMeasure) {
                        ForEach(0 ..< Constant.conversions.count, id: \.self) {
                            Text(Constant.conversions[$0].title)
                        }
                    }
                }

                Section(header: Text("Select a unit of measurement")) {
                    Picker("From:", selection: $selectedFromUnit) {
                        ForEach(0 ..< Constant.conversions[selectedMeasure].unitsStr.count, id: \.self) {
                            Text(Constant.conversions[selectedMeasure].unitsStr[$0])
                        }
                    }

                    Picker("To:", selection: $selectedToUnit) {
                        ForEach(0 ..< Constant.conversions[selectedMeasure].unitsStr.count, id: \.self) {
                            if ($0 != selectedFromUnit) {
                                Text(Constant.conversions[selectedMeasure].unitsStr[$0])
                            }
                        }
                    }
                }

                HStack {
                    Section(header: Text("Enter value")) {
                        TextField("From:", text: $value)
                            .keyboardType(.decimalPad)
                    }
                }

                Section(header: Text("Result")) {
                    if (result.value == Double.infinity) {
                        Text(errorMessage)
                            .foregroundColor(Color.red)
                    } else {
                        Text("\(result.value, specifier: result.value.truncatingRemainder(dividingBy: 1) != 0 ? "%.2f" : "%.0f") ") + Text(result.symbol ?? "")
                    }
                }
            }
            // Убрал title у NavigationView, потому что в логе появляются ошибки, которые я не хочу видеть (баш со стороны apple)
            //.navigationBarTitle(Text("Unit conversions"), displayMode: .inline)
        }
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

