//
//  Model.swift
//  card
//
//  Created by Asma Mohammed on 18/06/1446 AH.
//
import AVFAudio

struct model: Identifiable {
    var id = UUID()  // معرف فريد لكل عنصر
    var text: String = ""  // النص الذي سيُقرأ
    var categry: String = ""  // الفئة أو التصنيف
    let synthesizer = AVSpeechSynthesizer()  // أداة التحدث
    
    // دالة للتحدث بالنص
//    func speakText() {
//        let utterance = AVSpeechUtterance(string: text)
//        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
//        utterance.rate = 0.5
//        synthesizer.speak(utterance)
//    }
}

