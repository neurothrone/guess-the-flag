//
//  FlagImageView.swift
//  GuessTheFlag
//
//  Created by Zaid Neurothrone on 2022-10-01.
//

import SwiftUI

struct FlagImageView: View {
  let image: String
  
  var body: some View {
    Image(image)
      .renderingMode(.original)
      .clipShape(Capsule())
      .shadow(radius: 5)
  }
}


struct FlagImageView_Previews: PreviewProvider {
  static var previews: some View {
    FlagImageView(image: "US")
  }
}
