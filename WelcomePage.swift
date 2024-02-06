import SwiftUI


struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.orange)
                    .frame(width: 150, height: 150)
                
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }
            
            Text("Welcome to Brew")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("Brew my mathematics")
                .font(.title2)
        }
        .padding()
    }
}