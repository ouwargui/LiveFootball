//
//  ContentView.swift
//  LiveFootball
//
//  Created by Guilherme Santos on 24/01/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject var appContext = AppContext()

  var body: some View {
    HomeView()
      .environmentObject(appContext)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
