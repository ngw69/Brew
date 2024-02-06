import SwiftUI

struct Calculator: View {
    @State private var display = ""
    @State private var currentNumber = ""
    @State private var storedNumber = ""
    @State private var currentOperator = ""
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            VStack {
                Text(display)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding()
            
            HStack(spacing: 8) {
                CalculatorButton(title: "C", backgroundColor: .gray) { clearAll() }
                CalculatorButton(title: "+/-", backgroundColor: .gray) { toggleSign() }
                CalculatorButton(title: "%", backgroundColor: .gray) { percentage() }
                CalculatorButton(title: "÷", backgroundColor: .orange) { setOperator("/") }
            }
            
            HStack(spacing: 8) {
                CalculatorButton(title: "7", backgroundColor: .gray) { appendNumber("7") }
                CalculatorButton(title: "8", backgroundColor: .gray) { appendNumber("8") }
                CalculatorButton(title: "9", backgroundColor: .gray) { appendNumber("9") }
                CalculatorButton(title: "×", backgroundColor: .orange) { setOperator("*") }
            }
            
            HStack(spacing: 8) {
                CalculatorButton(title: "4", backgroundColor: .gray) { appendNumber("4") }
                CalculatorButton(title: "5", backgroundColor: .gray) { appendNumber("5") }
                CalculatorButton(title: "6", backgroundColor: .gray) { appendNumber("6") }
                CalculatorButton(title: "-", backgroundColor: .orange) { setOperator("-") }
            }
            
            HStack(spacing: 8) {
                CalculatorButton(title: "1", backgroundColor: .gray) { appendNumber("1") }
                CalculatorButton(title: "2", backgroundColor: .gray) { appendNumber("2") }
                CalculatorButton(title: "3", backgroundColor: .gray) { appendNumber("3") }
                CalculatorButton(title: "+", backgroundColor: .orange) { setOperator("+") }
            }
            
            HStack(spacing: 8) {
                CalculatorButton(title: "0", backgroundColor: .gray) { appendNumber("0") }
                CalculatorButton(title: ".", backgroundColor: .gray) { appendDecimal() }
                CalculatorButton(title: "=", backgroundColor: .orange) { calculate() }
                CalculatorButton(title: "←", backgroundColor: .orange) { deleteLastDigit() }
                CalculatorButton(title: "√", backgroundColor: .orange) { squareRoot() }
            }
        }
        .padding()
    }
    
    private func appendNumber(_ number: String) {
        currentNumber += number
        display += number
    }
    
    private func appendDecimal() {
        if !currentNumber.contains(".") {
            currentNumber += "."
            display += "."
        }
    }
    
    private func clearAll() {
        display = ""
        currentNumber = ""
        storedNumber = ""
        currentOperator = ""
    }
    
    private func toggleSign() {
        if !currentNumber.isEmpty {
            if currentNumber.starts(with: "-") {
                currentNumber.removeFirst()
                display.removeFirst()
            } else {
                currentNumber = "-" + currentNumber
                display = "-" + display
            }
        }
    }
    
    private func percentage() {
        if let number = Double(currentNumber) {
            currentNumber = String(number / 100)
            display = currentNumber
        }
    }
    
    private func setOperator(_ operatorSymbol: String) {
        if !currentNumber.isEmpty {
            storedNumber = currentNumber
            currentNumber = ""
            currentOperator = operatorSymbol
            display += operatorSymbol
        }
    }
    
    private func squareRoot() {
        if let number = Double(currentNumber), number >= 0 {
            let result = sqrt(number)
            currentNumber = String(result)
            display = "√\(currentNumber)"
        } else {
            display = "Invalid Input"
        }
    }
    
    private func deleteLastDigit() {
        if !currentNumber.isEmpty {
            currentNumber.removeLast()
            display.removeLast()
        }
    }
    
    private func calculate() {
        if !currentNumber.isEmpty && !storedNumber.isEmpty && !currentOperator.isEmpty {
            let expression = "\(storedNumber)\(currentOperator)\(currentNumber)"
            let mathExpression = NSExpression(format: expression)
            if let result = mathExpression.expressionValue(with: nil, context: nil) as? Double {
                currentNumber = String(result)
                display = expression + "=" + currentNumber
                storedNumber = ""
                currentOperator = ""
            } else {
                display = "Invalid Expression"
            }
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 60, height: 60)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
    }
}
