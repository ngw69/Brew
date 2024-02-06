import SwiftUI
import Foundation

struct ScientificCalculator: View {
    @State private var input = ""
    @State private var history = ""
    
    private let operations: [[String]] = [
        ["sin", "cos", "tan", "^"],
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", ".", "Clear", "+"]
    ]
    
    private func evaluate() {
        guard !input.isEmpty else { return }
        
        let expression = addClosingParentheses(input)
        print("Expression: \(expression)")
        
        do {
            if let result = try evaluateExpression(expression) {
                history = "\(input) = \(result)"
            } else {
                history = "Invalid expression"
            }
        } catch {
            print("Error evaluating expression: \(error)")
            history = "Error evaluating expression"
        }
    }
    
    private func evaluateExpression(_ expression: String) throws -> Double? {
        let cleanedExpression = expression.replacingOccurrences(of: " ", with: "")
        
        if cleanedExpression.contains("sin") {
            return try evaluateTrigonometric(cleanedExpression, trigFunc: "sin")
        } else if cleanedExpression.contains("cos") {
            return try evaluateTrigonometric(cleanedExpression, trigFunc: "cos")
        } else if cleanedExpression.contains("tan") {
            return try evaluateTrigonometric(cleanedExpression, trigFunc: "tan")
        } else {
            let result = try NSExpression(format: cleanedExpression).expressionValue(with: nil, context: nil) as? Double
            return result
        }
    }
    
    private func evaluateTrigonometric(_ expression: String, trigFunc: String) throws -> Double? {
        let cleanedExpression = expression.replacingOccurrences(of: trigFunc, with: "")
        let degrees = try NSExpression(format: cleanedExpression).expressionValue(with: nil, context: nil) as? Double
        let radians = degrees.map { $0 * Double.pi / 180 }
        
        switch trigFunc {
        case "sin":
            return radians.map { sin($0) }
        case "cos":
            return radians.map { cos($0) }
        case "tan":
            return radians.map { tan($0) }
        default:
            return nil
        }
    }
    
    private func addClosingParentheses(_ input: String) -> String {
        var result = input
        var parenthesesCount = 0
        
        for char in input {
            if char == "(" {
                parenthesesCount += 1
            } else if char == ")" {
                parenthesesCount -= 1
            }
        }
        
        if parenthesesCount > 0 {
            result.append(String(repeating: ")", count: parenthesesCount))
        }
        
        return result
    }
    
    var body: some View {
        VStack {
            Text("Scientific Calculator")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Text(history)
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            TextField("Enter expression...", text: $input, onCommit: evaluate)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                ForEach(operations, id: \.self) { row in
                    ForEach(row, id: \.self) { operation in
                        Button(action: {
                            if operation == "Clear" {
                                input = ""
                            } else if operation == "^" {
                                input.append(operation)
                            } else if ["sin", "cos", "tan"].contains(operation) {
                                input.append(operation + "(")
                            } else {
                                input.append(operation)
                            }
                        }) {
                            Text(operation)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(.systemGray5))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                
                Button(action: {
                    input.append(")")
                }) {
                    Text(")")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
            }
            
            Button(action: evaluate) {
                Text("Evaluate")
                    .font(.system(size: 24))
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

struct ScientificCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ScientificCalculator()
    }
}
