//
//  ListCrds.swift
//  card
//
//  Created by Asma Mohammed on 23/06/1446 AH.
//

import SwiftUI

struct ListCrds: View {
    @StateObject private var addCardsViewModel = Viewmodel()
    @State private var isSheetPresented: Bool = false
    @State private var selectedCards: model? = nil

    var body: some View {
        VStack {
        
            ForEach(addCardsViewModel.Cards) { entry in
                VStack(alignment: .leading) {
                    ZStack {
                        Color.white
                            .cornerRadius(12)
                        // استبدال model بـ entry لعرض التفاصيل الصحيحة
                        Text(entry.text)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                    HStack {
                        Text(entry.text)  // عرض النص
                        Text(entry.categry)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Spacer()

                        Button(action: {
                            speakText(entry.text) // تمرير النص الصحيح للدالة
                        }) {
                            Image(systemName: "speaker.wave.3.fill")
                                .resizable()
                                .frame(width: 25, height: 18)
                                .foregroundColor(Color("CustomOrange"))
                                .padding()
                        }
                    }
                    .padding()
                    .background(Rectangle().fill(Color.white))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
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
                            if let index = addCardsViewModel.Cards.firstIndex(where: { $0.id == entry.id }) {
                                addCardsViewModel.deleteJCards(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                    }
                }
            }
            .listRowBackground(
                Capsule()
                    .fill(Color(white:1, opacity: 0.8)))
            .padding(2)
        }
    }

    private func speakText(_ text: String) {
        // قم بتعريف الوظيفة التي تعالج النص لإخراجه كصوت
        print("Speaking text: \(text)") // استبدل هذا بالكود الفعلي للتحدث
    }
}

#Preview {
    ListCrds()
}
