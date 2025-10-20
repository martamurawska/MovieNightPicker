import SwiftUI

struct LoadingMovieView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(edges: .top)
            VStack(spacing: 24) {
                LoadingClapper()
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Finding a movie")
                        .font(.title2)
                        .foregroundStyle(Color.appPrimary)
                    AnimatedDots()
                }
            }
        }
    }
}

#Preview {
    LoadingMovieView()
}

struct LoadingClapper: View {
    @State private var bounce = false
    
    var body: some View {
        Image(systemName: "movieclapper.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.orangeAccent)
            .frame(width: 60, height: 60)
            .rotationEffect(.degrees(bounce ? -15 : 15))
            .animation(
                Animation.easeInOut(duration: 0.4)
                    .repeatForever(autoreverses: true),
                value: bounce
            )
            .onAppear {
                bounce = true
            }
    }
}

struct AnimatedDots: View {
    @State var isLoading: Bool = false
    var delays = [0, 0.2, 0.4]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(delays.indices, id: \.self) { index in
                Circle()
                    .fill(Color.appPrimary)
                    .frame(width: 5, height: 5)
                    .scaleEffect(isLoading ? 1 : 0.75)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(delays[index]), value: isLoading)
            }
        }
        .padding(5)
        .onAppear {
            isLoading = true
        }
    }
}
