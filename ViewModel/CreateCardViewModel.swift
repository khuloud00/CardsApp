//import SwiftUI
//
//class CreateCardViewModel: ObservableObject {
//    // بيانات الإدخال
//    @Published var inputText: String = ""
//    
//    // الأزرار المحددة
//    enum SelectedButton {
//        case basket, crossCase, tray, none
//    }
//    @Published var selectedButton: SelectedButton = .none
//    
//    // وظائف للأزرار
//    func cancel() {
//        print("Cancel tapped")
//    }
//    
//    func save() {
//        print("Save tapped")
//    }
//    
//    func selectButton(_ button: SelectedButton) {
//        selectedButton = button
//    }
//}
//
