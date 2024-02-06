import SwiftUI


struct FeaturesPage: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 10)
            
            FeatureCard(iconName: "1.circle",
                        description: "First ever mathematics helper made entirely on an iPhone")
            
            FeatureCard(iconName: "ellipsis.circle", description: "Has all and more features than the apple's stock calculator")
            

           FeatureCard(iconName: "bolt.horizontal.circle", description: "App includes conversions of measurements, normal and scientific calculators")


           FeatureCard(iconName: "antenna.radiowaves.left.and.right", description: "Made by NGW, purely on SwiftUI")
            Spacer()
        }
        .padding()
    }
}