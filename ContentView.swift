import SwiftUI

let gradientColors: [Color] = [
    Color.blue,
    Color.pink
]

struct ContentView: View {
    var body: some View {
        TabView {
            WelcomePage()
            ConversionView()
            Calculator()
            ScientificCalculator()
            FeaturesPage()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundStyle(.white)
    }
}

struct CalculatorPage: View {
    var body: some View {
        Calculator()
    }
}
