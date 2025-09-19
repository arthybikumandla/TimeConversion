//
//  ContentView.swift
//  WeSplit
//
//  Created by Arthy Bikumandla on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    let units = ["Secs","Mins","Hrs","Days"]
    @State private var inputUnit = "Mins"
    @State private var outputUnit = "Hrs"
    @State private var value: Double = 0
    @FocusState private var keyb : Bool
    var output: Double{
        var totalSeconds: Double = 0

        switch inputUnit {
        case "Secs": totalSeconds = value
        case "Mins": totalSeconds = value * 60
        case "Hrs":  totalSeconds = value * 3600
        case "Days": totalSeconds = value * 86400
        default: break
        }

        switch outputUnit {
        case "Secs": return totalSeconds
        case "Mins": return totalSeconds / 60
        case "Hrs":  return totalSeconds / 3600
        case "Days": return totalSeconds / 86400
        default: return totalSeconds
        }
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("Select input unit"){
                    Picker("Pick one", selection: $inputUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select output unit"){
                    Picker("Pick one", selection: $outputUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter input value"){
                    TextField("Value", value : $value, format: .number)
                        .focused($keyb)
                }
                Section("Output"){
                    Text(output.formatted(.number.precision(.fractionLength(2))))
                        .foregroundStyle(value == 0 ? .red : .black)
                }
            }
            .navigationTitle("Time Conversion")
            .keyboardType(.decimalPad)
            .toolbar{
                if keyb {
                    Button("Done"){
                        keyb = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
