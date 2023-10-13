//
//  ImagesResponse.swift
//
//
//  Created by James Rochabrun on 10/12/23.
//

import Foundation

/// A [response](https://platform.openai.com/docs/api-reference/images) from the images API includes either the generated image's URL or its base64-encoded JSON.
struct ImagesResponse: Decodable {
   
   /// [Represents the url or the content of an image generated by the OpenAI API.](https://platform.openai.com/docs/api-reference/images/object)
   struct ImageObject: Decodable {
      /// The URL of the generated image, if response_format is url (default).
      let url: URL?
      /// The base64-encoded JSON of the generated image, if response_format is b64_json.
      let b64Json: String?
      
      enum CodingKeys: String, CodingKey {
          case url
          case b64Json = "b64_json"
      }
   }
   
   let created: Int
   let data: [ImageObject]
}
