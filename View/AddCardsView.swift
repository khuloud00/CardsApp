import SwiftUI
import AVFAudio
import SwiftData

struct AddCardsView: View {
    @StateObject var AddCardsViewModel = Viewmodel()
    @Query var cards: [Card]
    @State private var text: String = ""
    @State private var category: String = ""
    @State private var selectedCards: model? = nil
    @State private var isSheetPresented: Bool = false
    @State private var selectedCategory = "middle"
    private let synthesizer = AVSpeechSynthesizer()
    
    // Function to speak text
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
    
    // Function to check if text contains Arabic characters
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
                    if AddCardsViewModel.Cards.isEmpty {
                        VStack {
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
                        }
                    } else {
                        HStack(spacing: 30) {
                            categoryButton(category: "left", systemImage: "basket")
                            categoryButton(category: "middle", systemImage: "star.fill")
                            categoryButton(category: "right", systemImage: "tray")
                        }
                        
                        List {
                            ForEach(AddCardsViewModel.Cards.filter { $0.categry == selectedCategory }) { entry in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(entry.text)
                                        Text(entry.categry)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Button(action: {
                                            speakText(entry.text)
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
                        .scrollContentBackground(.hidden)
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
    
    // Helper function to create category buttons
    private func categoryButton(category: String, systemImage: String) -> some View {
        Button(action: {
            selectedCategory = category
        }) {
            Image(systemName: systemImage)
                .foregroundColor(selectedCategory == category ? .white : Color("CustomOrange"))
                .padding()
                .frame(width: 100, height: 38)
                .background(selectedCategory == category ? Color("CustomOrange") : Color.white)
                .cornerRadius(30)
                .shadow(radius: 2)
        }
    }
    
    private func addCard(text: String, category: String) {
        AddCardsViewModel.Cards.append(model(text: text, categry: category))
    }
}
