//
//  Model.swift
//  card
//
//  Created by Asma Mohammed on 18/06/1446 AH.
//
import AVFAudio
import SwiftUI


struct model: Identifiable {
    var id = UUID()  // معرف فريد لكل عنصر
    var text: String = ""  // النص الذي سيُقرأ
    var categry: String = ""  // الفئة أو التصنيف
    let synthesizer = AVSpeechSynthesizer()  // أداة التحدث
  
   }


