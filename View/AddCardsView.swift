import SwiftUI
import AVFAudio
import SwiftData

struct AddCardsView: View {
    @StateObject var AddCardsViewModel = Viewmodel()
    @Query var cards: [Card]
    @State private var text: String = ""
    @State private var category: String = ""
    @State private var isSheetPresented: Bool = false
    @State private var selectedCategory = "middle"
    private let synthesizer = AVSpeechSynthesizer()
    @Environment(\.modelContext) var modelContext

    private func speakText(_ text: String) {
        guard !text.isEmpty else { return }
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        let language = containsArabicCharacters(text) ? "ar-SA" : "en-US"
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }

    private func containsArabicCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if scalar.value >= 0x0600 && scalar.value <= 0x06FF {
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
                    if cards.isEmpty {
                        Spacer()
                        Image("LogoEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                        Text("Create")
                            .font(.title)
                            .bold()
                            .foregroundColor(.customOrange)
                            .padding(.top, 10)
                        Text("Your Own Cards")
                            .foregroundColor(.black1)
                            .font(.system(size: 24))
                        Spacer()
                    } else {
                        HStack(spacing: 30) {
                            categoryButton(category: "left", systemImage: "basket")
                            categoryButton(category: "middle", systemImage: "star.fill")
                            categoryButton(category: "right", systemImage: "tray")
                        }

                        List {
                            ForEach(cards.filter { $0.category == selectedCategory }) { entry in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(entry.text)
                                        Text(entry.category)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Button {
                                            speakText(entry.text)
                                        } label: {
                                            Image(systemName: "speaker.wave.3.fill")
                                                .resizable()
                                                .frame(width: 25, height: 18)
                                                .foregroundColor(Color("CustomOrange"))
                                                .padding()
                                        }
                                    }
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        modelContext.delete(entry)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Add cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        AddCardsViewModel.navigateToInstantCardView()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(Color("CustomOrange"))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22))
                            .foregroundColor(Color("CustomOrange"))
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $AddCardsViewModel.navigateToInstantCard) {
                InstantCardView()
            }
            .sheet(isPresented: $isSheetPresented) {
                CreateCardView()
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    private func categoryButton(category: String, systemImage: String) -> some View {
        Button {
            selectedCategory = category
        } label: {
            Image(systemName: systemImage)
                .foregroundColor(selectedCategory == category ? .white : Color("CustomOrange"))
                .padding()
                .frame(width: 100, height: 38)
                .background(selectedCategory == category ? Color("CustomOrange") : Color.white)
                .cornerRadius(30)
                .shadow(radius: 2)
        }
    }
}
