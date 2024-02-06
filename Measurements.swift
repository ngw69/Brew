import SwiftUI

struct ConversionView: View {
    @State private var inputValue = ""
    @State private var measurementIndex = 0
    @State private var inputUnitIndex = 0
    @State private var outputUnitIndex = 0
    @State private var isKeyboardVisible = false
    
    let measurements = ["Length", "Temperature", "Mass"]
    let lengthUnits = ["Meter", "Kilometer", "Centimeter", "Millimeter"]
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let massUnits = ["Gram", "Kilogram", "Pound", "Ounce"]
    
    let inputPlaceholder = "Enter value"
    
    var convertedValue: Double {
        let input = Double(inputValue) ?? 0
        
        switch measurements[measurementIndex] {
        case "Length":
            return convertLength(value: input, inputUnitIndex: inputUnitIndex, outputUnitIndex: outputUnitIndex)
        case "Temperature":
            return convertTemperature(value: input, inputUnitIndex: inputUnitIndex, outputUnitIndex: outputUnitIndex)
        case "Mass":
            return convertMass(value: input, inputUnitIndex: inputUnitIndex, outputUnitIndex: outputUnitIndex)
        default:
            return 0
        }
    }
    
    func convertLength(value: Double, inputUnitIndex: Int, outputUnitIndex: Int) -> Double {
        let inputUnit = lengthUnits[inputUnitIndex]
        let outputUnit = lengthUnits[outputUnitIndex]
        let inputValueInMeter = convertToMeter(value: value, unit: inputUnit)
        return convertFromMeter(value: inputValueInMeter, unit: outputUnit)
    }
    
    func convertToMeter(value: Double, unit: String) -> Double {
        switch unit {
        case "Meter": return value
        case "Kilometer": return value * 1000
        case "Centimeter": return value / 100
        case "Millimeter": return value / 1000
        default: return value
        }
    }
    
    func convertFromMeter(value: Double, unit: String) -> Double {
        switch unit {
        case "Meter": return value
        case "Kilometer": return value / 1000
        case "Centimeter": return value * 100
        case "Millimeter": return value * 1000
        default: return value
        }
    }
    
    func convertTemperature(value: Double, inputUnitIndex: Int, outputUnitIndex: Int) -> Double {
        let inputUnit = temperatureUnits[inputUnitIndex]
        let outputUnit = temperatureUnits[outputUnitIndex]
        return convertTemperature(value: value, inputUnit: inputUnit, outputUnit: outputUnit)
    }
    
    func convertTemperature(value: Double, inputUnit: String, outputUnit: String) -> Double {
        switch inputUnit {
        case "Celsius":
            switch outputUnit {
            case "Celsius": return value
            case "Fahrenheit": return (value * 9/5) + 32
            case "Kelvin": return value + 273.15
            default: return value
            }
        case "Fahrenheit":
            switch outputUnit {
            case "Celsius": return (value - 32) * 5/9
            case "Fahrenheit": return value
            case "Kelvin": return (value - 32) * 5/9 + 273.15
            default: return value
            }
        case "Kelvin":
            switch outputUnit {
            case "Celsius": return value - 273.15
            case "Fahrenheit": return (value - 273.15) * 9/5 + 32
            case "Kelvin": return value
            default: return value
            }
        default:
            return value
        }
    }
    
    func convertMass(value: Double, inputUnitIndex: Int, outputUnitIndex: Int) -> Double {
        let inputUnit = massUnits[inputUnitIndex]
        let outputUnit = massUnits[outputUnitIndex]
        return convertMass(value: value, inputUnit: inputUnit, outputUnit: outputUnit)
    }
    
    func convertMass(value: Double, inputUnit: String, outputUnit: String) -> Double {
        switch inputUnit {
        case "Gram":
            switch outputUnit {
            case "Gram": return value
            case "Kilogram": return value / 1000
            case "Pound": return value * 0.00220462
            case "Ounce": return value * 0.035274
            default: return value
            }
        case "Kilogram":
            switch outputUnit {
            case "Gram": return value * 1000
            case "Kilogram": return value
            case "Pound": return value * 2.20462
            case "Ounce": return value * 35.274
            default: return value
            }
        case "Pound":
            switch outputUnit {
            case "Gram": return value * 453.592
            case "Kilogram": return value * 0.453592
            case "Pound": return value
            case "Ounce": return value * 16
            default: return value
            }
        case "Ounce":
            switch outputUnit {
            case "Gram": return value * 28.3495
            case "Kilogram": return value * 0.0283495
            case "Pound": return value * 0.0625
            case "Ounce": return value
            default: return value
            }
        default:
            return value
        }
    }
    
    func calculateConversion() {
        // Calculation logic based on the selected conversion types
        // You can fill this function with logic specific to your application
        // For example, you can use switch statements to determine the conversion based on the selected measurement, input unit, and output unit
    }
    
    var body: some View {
        VStack {
            Text("Measurements")
                .font(.title)
                .padding(.top, 10)
                .padding(.bottom, 20)
            
            Picker("Select measurement", selection: $measurementIndex) {
                ForEach(0..<measurements.count) {
                    Text(self.measurements[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            Picker("Select unit", selection: $inputUnitIndex) {
                if measurements[measurementIndex] == "Length" {
                    ForEach(0..<lengthUnits.count) {
                        Text(self.lengthUnits[$0])
                    }
                } else if measurements[measurementIndex] == "Temperature" {
                    ForEach(0..<temperatureUnits.count) {
                        Text(self.temperatureUnits[$0])
                    }
                } else if measurements[measurementIndex] == "Mass" {
                    ForEach(0..<massUnits.count) {
                        Text(self.massUnits[$0])
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            TextField(inputPlaceholder, text: $inputValue)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    self.isKeyboardVisible = true
                }
            
            Picker("Select unit", selection: $outputUnitIndex) {
                if measurements[measurementIndex] == "Length" {
                    ForEach(0..<lengthUnits.count) {
                        Text(self.lengthUnits[$0])
                    }
                } else if measurements[measurementIndex] == "Temperature" {
                    ForEach(0..<temperatureUnits.count) {
                        Text(self.temperatureUnits[$0])
                    }
                } else if measurements[measurementIndex] == "Mass" {
                    ForEach(0..<massUnits.count) {
                        Text(self.massUnits[$0])
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            Text("Converted Value: \(convertedValue)")
                .padding()
                .onAppear {
                    self.calculateConversion()
                }
                .onChange(of: inputValue) { _ in
                    self.calculateConversion()
                }
                .onChange(of: inputUnitIndex) { _ in
                    self.calculateConversion()
                }
                .onChange(of: outputUnitIndex) { _ in
                    self.calculateConversion()
                }
        }
        .padding()
        .overlay(
            Button(action: {
                self.isKeyboardVisible = false
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                Text("Done")
            }
            .padding(.trailing, 20)
            .opacity(isKeyboardVisible ? 1 : 0)
            , alignment: .bottomTrailing
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView()
    }
}