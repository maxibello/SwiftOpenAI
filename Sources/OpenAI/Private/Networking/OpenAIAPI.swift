//
//  OpenAIAPI.swift
//
//
//  Created by James Rochabrun on 10/10/23.
//

import Foundation

// MARK: OpenAIAPI

enum OpenAIAPI {
   
   case assistant(AssistantCategory) // https://platform.openai.com/docs/api-reference/assistants
   case audio(AudioCategory) // https://platform.openai.com/docs/api-reference/audio
   case chat /// https://platform.openai.com/docs/api-reference/chat
   case embeddings // https://platform.openai.com/docs/api-reference/embeddings
   case file(FileCategory) // https://platform.openai.com/docs/api-reference/files
   case fineTuning(FineTuningCategory) // https://platform.openai.com/docs/api-reference/fine-tuning
   case images(ImageCategory) // https://platform.openai.com/docs/api-reference/images
   case message(MessageCategory) // https://platform.openai.com/docs/api-reference/messages
   case model(ModelCategory) // https://platform.openai.com/docs/api-reference/models
   case moderations // https://platform.openai.com/docs/api-reference/moderations
   case run(RunCategory) // https://platform.openai.com/docs/api-reference/runs
   case runStep(RunStepCategory) // https://platform.openai.com/docs/api-reference/runs/step-object
   case thread(ThreadCategory) // https://platform.openai.com/docs/api-reference/threads
   case batch(BatchCategory) // https://platform.openai.com/docs/api-reference/batch
   case vectorStore(VectorStoreCategory) // https://platform.openai.com/docs/api-reference/vector-stores
   case vectorStoreFile(VectorStoreFileCategory) // https://platform.openai.com/docs/api-reference/vector-stores-files
   case vectorStoreFileBatch(VectorStoreFileBatch) // https://platform.openai.com/docs/api-reference/vector-stores-file-batches
   
   enum AssistantCategory {
      case create
      case list
      case retrieve(assistantID: String)
      case modify(assistantID: String)
      case delete(assistantID: String)
   }
   
   enum AudioCategory: String {
      case transcriptions
      case translations
      case speech
   }
   
   enum FileCategory {
      case list
      case upload
      case delete(fileID: String)
      case retrieve(fileID: String)
      case retrieveFileContent(fileID: String)
   }
   
   enum FineTuningCategory {
      case create
      case list
      case retrieve(jobID: String)
      case cancel(jobID: String)
      case events(jobID: String)
   }
   
   enum ImageCategory: String {
      case generations
      case edits
      case variations
   }
   
   enum MessageCategory {
      case create(threadID: String)
      case retrieve(threadID: String, messageID: String)
      case modify(threadID: String, messageID: String)
      case list(threadID: String)
   }
   
   enum ModelCategory {
      case list
      case retrieve(modelID: String)
      case deleteFineTuneModel(modelID: String)
   }
   
   enum RunCategory {
      case create(threadID: String)
      case retrieve(threadID: String, runID: String)
      case modify(threadID: String, runID: String)
      case list(threadID: String)
      case cancel(threadID: String, runID: String)
      case submitToolOutput(threadID: String, runID: String)
      case createThreadAndRun
   }
   
   enum RunStepCategory {
      case retrieve(threadID: String, runID: String, stepID: String)
      case list(threadID: String, runID: String)
   }
   
   enum ThreadCategory {
      case create
      case retrieve(threadID: String)
      case modify(threadID: String)
      case delete(threadID: String)
   }
   
   enum BatchCategory {
      case create
      case retrieve(batchID: String)
      case cancel(batchID: String)
      case list
   }
   
   enum VectorStoreCategory {
      case create
      case list
      case retrieve(vectorStoreID: String)
      case modify(vectorStoreID: String)
      case delete(vectorStoreID: String)
   }
   
   enum VectorStoreFileCategory {
      case create(vectorStoreID: String)
      case list(vectorStoreID: String)
      case retrieve(vectorStoreID: String, fileID: String)
      case delete(vectorStoreID: String, fileID: String)
   }
   
   enum VectorStoreFileBatch {
      case create(vectorStoreID: String)
      case retrieve(vectorStoreID: String, batchID: String)
      case cancel(vectorStoreID: String, batchID: String)
      case list(vectorStoreID: String, batchID: String)
      
   }
}

// MARK: OpenAIAPI+Endpoint

extension OpenAIAPI: Endpoint {
   
   var base: String {
      "https://api.openai.com"
   }
   
   var path: String {
      switch self {
      case .assistant(let category):
         switch category {
         case .create, .list: return "/v1/assistants"
         case .retrieve(let assistantID), .modify(let assistantID), .delete(let assistantID): return "/v1/assistants/\(assistantID)"
         }
      case .audio(let category): return "/v1/audio/\(category.rawValue)"
      case .batch(let category):
         switch category {
         case .create, .list: return "v1/batches"
         case .retrieve(let batchID): return "v1/batches/\(batchID)"
         case .cancel(let batchID): return "v1/batches/\(batchID)/cancel"
         }
      case .chat: return "/v1/chat/completions"
      case .embeddings: return "/v1/embeddings"
      case .file(let category):
         switch category {
         case .list, .upload: return "/v1/files"
         case .delete(let fileID), .retrieve(let fileID): return "/v1/files/\(fileID)"
         case .retrieveFileContent(let fileID): return "/v1/files/\(fileID)/content"
         }
      case .fineTuning(let category):
         switch category {
         case .create, .list: return "/v1/fine_tuning/jobs"
         case .retrieve(let jobID): return "/v1/fine_tuning/jobs/\(jobID)"
         case .cancel(let jobID): return "/v1/fine_tuning/jobs/\(jobID)/cancel"
         case .events(let jobID): return "/v1/fine_tuning/jobs/\(jobID)/events"
         }
      case .images(let category): return "/v1/images/\(category.rawValue)"
      case .message(let category):
         switch category {
         case .create(let threadID), .list(let threadID): return "/v1/threads/\(threadID)/messages"
         case .retrieve(let threadID, let messageID), .modify(let threadID, let messageID): return "/v1/threads/\(threadID)/messages/\(messageID)"
         }
      case .model(let category):
         switch category {
         case .list: return "/v1/models"
         case .retrieve(let modelID), .deleteFineTuneModel(let modelID): return "/v1/models/\(modelID)"
         }
      case .moderations: return "/v1/moderations"
      case .run(let category):
         switch category {
         case .create(let threadID), .list(let threadID): return "/v1/threads/\(threadID)/runs"
         case .retrieve(let threadID, let runID), .modify(let threadID, let runID): return "/v1/threads/\(threadID)/runs/\(runID)"
         case .cancel(let threadID, let runID): return "/v1/threads/\(threadID)/runs/\(runID)/cancel"
         case .submitToolOutput(let threadID, let runID): return "/v1/threads/\(threadID)/runs/\(runID)//submit_tool_outputs"
         case .createThreadAndRun: return "/v1/threads/runs"
         }
      case .runStep(let category):
         switch category {
         case .retrieve(let threadID, let runID, let stepID): return "/v1/threads/\(threadID)/runs/\(runID)/steps/\(stepID)"
         case .list(let threadID, let runID): return "/v1/threads/\(threadID)/runs/\(runID)/steps"
         }
      case .thread(let category):
         switch category {
         case .create: return "/v1/threads"
         case .retrieve(let threadID), .modify(let threadID), .delete(let threadID): return "/v1/threads/\(threadID)"
         }
      case .vectorStore(let category):
         switch category {
         case .create, .list: return "/v1/vector_stores"
         case .retrieve(let vectorStoreID), .modify(let vectorStoreID), .delete(let vectorStoreID): return "/v1/vector_stores/\(vectorStoreID)"
         }
      case .vectorStoreFile(let category):
         switch category {
         case .create(let vectorStoreID), .list(let vectorStoreID): return "/v1/vector_stores/\(vectorStoreID)/files"
         case .retrieve(let vectorStoreID, let fileID), .delete(let vectorStoreID, let fileID): return "/v1/vector_stores/\(vectorStoreID)/files/\(fileID)"
         }
      case .vectorStoreFileBatch(let category):
         switch category {
         case .create(let vectorStoreID): return"/v1/vector_stores/\(vectorStoreID)/file_batches"
         case .retrieve(let vectorStoreID, let batchID): return "/v1/vector_stores/\(vectorStoreID)/file_batches/\(batchID)"
         case .cancel(let vectorStoreID, let batchID): return "/v1/vector_stores/\(vectorStoreID)/file_batches/\(batchID)/cancel"
         case .list(let vectorStoreID, let batchID): return "/v1/vector_stores/\(vectorStoreID)/file_batches/\(batchID)/files"
         }
      }
   }
}

