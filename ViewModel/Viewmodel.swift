//
//  Viewmodel.swift
//  card
//
//  Created by Asma Mohammed on 18/06/1446 AH.
//

import Foundation
import SwiftUI
import AVFoundation

// ViewModel for Instant Card
class Viewmodel: ObservableObject {
    @Published var text: String = ""
    let synthesizer = AVSpeechSynthesizer()  
    
    @Published var Cards: [model] = []
    
    func speakText() {
        guard !text.isEmpty else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }


// ViewModel for Create Card

    // بيانات الإدخال
    @Published var inputText: String = ""
    
    // الأزرار المحددة
    enum SelectedButton {
        case basket, crossCase, tray, none
    }
    @Published var selectedButton: SelectedButton = .none
    
    // وظائف للأزرار
    func cancel() {
///
    }
    
    func saveChange() {
       let card = model(text: inputText)
        Cards.append(card)
    }
    
    func selectButton(_ button: SelectedButton) {
        selectedButton = button
    }


// ViewModel for Add Cards
    // متغيرات مرتبطة بحالة العرض
    @Published var isSheetPresented: Bool = false
    @Published var navigateToInstantCard: Bool = false
    @Published var isActive = true
    // منطق عرض الـ sheet
    func toggleSheet() {
        isSheetPresented.toggle()
    }
    
    // منطق التنقل إلى الصفحة الأخرى
    func navigateToInstantCardView() {
        navigateToInstantCard = true
    }

}
// Circular Button for UI
struct CircularButton: View {
    var iconName: String
    var isSelected: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName) // صورة الزر
                .resizable()
                .frame(width: 34, height: 29) // حجم الصورة
                .foregroundColor(isSelected ? .white : .customOrange)
        }
        .frame(width: 100, height: 38)
        .background(isSelected ? .customOrange : .white)
        .cornerRadius(15)
        .shadow(radius: 1)
        .offset(y:-1)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.customOrange)
        )
    }
}
