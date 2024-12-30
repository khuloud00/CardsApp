import SwiftUI
import AVFAudio
struct CreateCardView: View {
    @StateObject private var CreateCardViewModel = Viewmodel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    var addCard: (String, String) -> Void  // تمرير الدالة مباشرة
    @State private var selectedCategory = "middle"
    private let synthesizer = AVSpeechSynthesizer() // كائن المتحدث المستمر

    // وظيفة التحدث بالنص
    private func speakText(_ text: String) {
        guard !text.isEmpty else { return } // تأكد من أن النص غير فارغ

        // إذا كان هناك نص قيد التشغيل، قم بإيقافه
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        // تحديد اللغة بناءً على النص
        let language = containsArabicCharacters(text) ? "ar-SA" : "en-US"
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language) // اللغة المختارة
        utterance.rate = 0.5 // سرعة التحدث

        synthesizer.speak(utterance) // تشغيل الصوت
    }

    // دالة لتحديد ما إذا كان النص يحتوي على أحرف عربية
    private func containsArabicCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if scalar.value >= 0x0600 && scalar.value <= 0x06FF { // نطاق الأحرف العربية
                return true
            }
        }
        return false
    }

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))

                Spacer()

                Button("Save") {
                    if !CreateCardViewModel.inputText.isEmpty {
                        addCard(CreateCardViewModel.inputText, selectedCategory)  // استدعاء الدالة
                        dismiss()
                    }
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top, 20)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear.opacity(0.1))

                TextField("Typing...", text: $CreateCardViewModel.inputText)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 16)

            // أزرار الكاتقوريز هنا
            HStack(spacing: 30) {
                Button(action: {
                    selectedCategory = "left"
                }) {
                    Image(systemName: "basket")
                        .foregroundColor(selectedCategory == "left" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "left" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                }

                Button(action: {
                    selectedCategory = "middle"
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(selectedCategory == "middle" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "middle" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                }

                Button(action: {
                    selectedCategory = "right"
                }) {
                    Image(systemName: "tray")
                        .foregroundColor(selectedCategory == "right" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "right" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                }
            }
            .padding(.bottom, 20)

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

