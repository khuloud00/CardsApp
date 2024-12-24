import SwiftUI
import AVFAudio
struct AddCardsView: View {
    @StateObject private var AddCardsViewModel = Viewmodel()
    
    @State private var text: String = ""
    @State private var category: String = ""
    @State private var selectedCards: model? = nil
    @State private var isSheetPresented: Bool = false
    @State private var selectedCategory = "middle"
    

    // وظيفة التحدث بالنص
    private func speakText(_ text: String) {
        guard !text.isEmpty else { return } // تأكد من أن النص غير فارغ

        // تحديد اللغة بناءً على النص
        let language = containsArabicCharacters(text) ? "ar-SA" : "en-US"
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language) // اللغة المختارة
        utterance.rate = 0.5 // سرعة التحدث
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
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
        NavigationStack {
            ZStack {
                Color(.background1)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    if AddCardsViewModel.Cards.isEmpty {
                        // حالة الصفحة الفارغة
                        VStack {
                            Spacer()
                            Image("LogoEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                            Text("Create Your Own Spoken Card")
                                .font(.title)
                                .foregroundColor(.customOrange)
                                .padding(.top, 20)
                            Spacer()
                        }
                    } else {
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
                                Image(systemName: "case")
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
                        .padding()

                        // قائمة العناصر
                        List {
                            ForEach(AddCardsViewModel.Cards) { entry in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(entry.text)
                                        Text(entry.categry)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            speakText(entry.text) // تشغيل الصوت عند الضغط على الزر
                                        }) {
                                            Image(systemName: "speaker.wave.3.fill")
                                                .resizable()
                                                .frame(width: 25, height: 18)
                                                .foregroundColor(Color("CustomOrange"))
                                                .padding()
                                        }
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button(action: {
                                        selectedCards = entry
                                        isSheetPresented = true
                                    }) {
                                        Image(systemName: "pencil")
                                        Text("Edit")
                                    }
                                    .tint(.blue)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive, action: {
                                        if let index = AddCardsViewModel.Cards.firstIndex(where: { $0.id == entry.id }) {
                                            AddCardsViewModel.deleteJCards(at: index)
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                        Text("Delete")
                                    }
                                }
                            }
                        }
                        .scrollContentBackground(.hidden) // إخفاء خلفية List
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            AddCardsViewModel.navigateToInstantCardView()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Add cards")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            AddCardsViewModel.toggleSheet()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $AddCardsViewModel.navigateToInstantCard) {
                InstantCardView()
            }
            .sheet(isPresented: $AddCardsViewModel.isSheetPresented) {
                CreateCardView(addCard: addCard)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    private func addCard(text: String) {
        AddCardsViewModel.Cards.append(model(text: text))
    }
}
