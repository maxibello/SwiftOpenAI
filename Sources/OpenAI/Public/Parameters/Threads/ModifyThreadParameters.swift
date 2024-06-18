//
//  ModifyThreadParameters.swift
//
//
//  Created by James Rochabrun on 11/25/23.
//

import Foundation

/// Modifies a [Thread](https://platform.openai.com/docs/api-reference/threads/modifyThread)

public struct ModifyThreadParameters: Encodable {
    
    /// A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the code_interpreter tool requires a list of file IDs, while the file_search tool requires a list of vector store IDs.
    public var toolResources: ToolResources?
    /// Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maxium of 512 characters long.
    public var metadata: [String: String]?
    
    enum CodingKeys: String, CodingKey {
       case toolResources = "tool_resources"
       case metadata
    }
    
    public init(
        toolResources: ToolResources? = nil,
        metadata: [String : String]? = nil)
    {
        self.toolResources = toolResources
        self.metadata = metadata
    }
}
