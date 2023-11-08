//
//  URLImageView.swift
//  SwiftOpenAIExample
//
//  Created by James Rochabrun on 11/4/23.
//

import SwiftUI

struct URLImageView: View {
   
   let url: URL
   
   var body: some View {
      AsyncImage(
         url: url,
         transaction: Transaction(animation: .easeInOut)
      ) { phase in
         switch phase {
         case .empty:
            ProgressView()
         case .success(let image):
            image
               .resizable()
               .aspectRatio(contentMode: .fit)
               .transition(.opacity)
         case .failure:
            Image(systemName: "wifi.slash")
         @unknown default:
            EmptyView()
         }
      }
      .frame(width: 120, height: 120)
      .background(Color.gray)
      .clipShape(RoundedRectangle(cornerRadius: 10))
   }
}