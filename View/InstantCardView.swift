import SwiftUI
import AVFoundation

struct InstantCardView: View {
    @StateObject private var InstantCardViewModel = Viewmodel()
    @State private var navigateToAddCardsView: Bool = false
    @State private var text: String = ""
    @State private var showSplash = true // للتحكم في عرض صفحة Splash
    
    // سرعة التحدث الثابتة التي تتحكم بها
    private let speechRate: Float = 0.5
    
    var body: some View {
        NavigationStack {
            if showSplash {
                ZStack {
                    Splash()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    showSplash = false
                                }
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
                                TextField("You want to say something?", text: $text, axis: .horizontal)
                                    .padding()
                                    .font(.system(size: 24)) // تكبير الخط
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.trailing)
                                    .environment(\.layoutDirection, .rightToLeft)
                                    .frame(height: 150)
                                    
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        speakText(text) // استدعاء وظيفة التحدث
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
    
    // وظيفة التحدث بالنص
    func speakText(_ text: String) {
        guard !text.isEmpty else { return } // تأكد من أن النص غير فارغ
        
        let synthesizer = AVSpeechSynthesizer()
        
        // تحديد اللغة بناءً على النص
        let language = containsArabicCharacters(text) ? "ar-SA" : "en-US"
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language) // اللغة المختارة
        utterance.rate = speechRate // استخدام السرعة التي تتحكم بها
        
        synthesizer.speak(utterance) // تشغيل الصوت
    }
    
    // دالة لتحديد ما إذا كان النص يحتوي على أحرف عربية
    func containsArabicCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if scalar.value >= 0x0600 && scalar.value <= 0x06FF { // نطاق الأحرف العربية
                return true
            }
        }
        return false
    }
}

struct InstantCardView_Previews: PreviewProvider {
    static var previews: some View {
        InstantCardView()
            .environment(\.colorScheme, .light)
    }
}
