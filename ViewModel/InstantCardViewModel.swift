//import SwiftUI
//import AVFoundation
//
//class InstantCardViewModel: ObservableObject {
//    @Published var text: String = "" // النص المُدخل
//    
//    private let synthesizer = AVSpeechSynthesizer() // أداة تحويل النص إلى كلام
//    
//    func speakText() {
//        guard !text.isEmpty else { return }
//        let utterance = AVSpeechUtterance(string: text)
//        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
//        utterance.rate = 0.5
//        
//        synthesizer.speak(utterance)
//        
//    }
//}


