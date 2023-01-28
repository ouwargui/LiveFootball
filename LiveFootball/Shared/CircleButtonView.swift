//
//  CircleButton.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 25/01/23.
//

import SwiftUI

struct CircleButtonView: View {
  let systemImageName: String
  let color: Color
  let action: () -> Void

  var body: some View {
    Button(action: {
      withAnimation {
        action()
      }
    }, label: {
      Image(systemName: systemImageName)
        .resizable()
        .foregroundStyle(.white, color)
        .frame(width: 30, height: 30)
    })
    .frame(width: 40, height: 40)
  }
}

struct CircleButton_Previews: PreviewProvider {
  static var previews: some View {
    CircleButtonView(systemImageName: "minus.circle.fill", color: .red) {
      print("teste")
    }
  }
}
