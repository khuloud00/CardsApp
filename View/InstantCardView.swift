import SwiftUI

struct InstantCardView: View {
    @StateObject private var InstantCardViewModel = Viewmodel()
    @State private var navigateToAddCardsView: Bool = false
    @State private var text: String = ""
    @State private var showSplash = true // للتحكم في عرض صفحة Splash
    
    var body: some View {
        NavigationStack {
            if showSplash {
                Splash()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                if InstantCardViewModel.isActive {
                    VStack {
                        Spacer()
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                        Text("Talkie Cards")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                } else {
                    VStack {
                        HStack {
                            Text("Instant card")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.leading)
                                .padding(.top, 50)
                            Spacer()
                            Button(action: {
                                navigateToAddCardsView = true
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("CustomOrange"))
                                    .padding(.trailing)
                                    .padding(.top, 50)
                            }
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                            
                            VStack {
                                TextField("Enter Text ...", text: $text, axis: .horizontal)
                                    .padding()
                                    .font(.body)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.trailing)
                                    .environment(\.layoutDirection, .rightToLeft)
                                    .frame(height: 150)
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        InstantCardViewModel.speakText()
                                    }) {
                                        Image(systemName: "speaker.wave.3.fill")
                                            .resizable()
                                            .frame(width: 25, height: 18)
                                            .foregroundColor(Color("CustomOrange"))
                                            .padding()
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(height: 400)
                        .padding()
                        
                        Spacer()
                    }
                    .background(Color("Background1"))
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(isPresented: $navigateToAddCardsView) {
                        AddCardsView()
                    }
                }
            }
        }
    }
}

struct InstantCardView_Previews: PreviewProvider {
    static var previews: some View {
        InstantCardView()
            .environment(\.colorScheme, .light)
    }
}
