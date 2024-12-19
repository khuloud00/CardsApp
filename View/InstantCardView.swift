import SwiftUI
import Foundation
import SwiftUI
import AVFoundation

struct InstantCardView: View {
    @StateObject private var InstantCardViewModel = Viewmodel()
    @State private var navigateToAddCardsView: Bool = false
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Instant card")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        .padding(.top, 50)
                        
                    
                    Spacer()

                    // زر التنقل إلى AddCardsView
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
                            .foregroundColor(.gray)
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
            // التنقل إلى AddCardsView
            .navigationDestination(isPresented: $navigateToAddCardsView) {
                AddCardsView()
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

