//
//  FoodRecognition.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/17/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import NIO
import NIOHPACK
import GRPC

// MARK: Properties
class FoodRecognition {
    
    private(set) var client: Clarifai_Api_V2Client
    
    public init() {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let channel = ClientConnection.secure(group: group).connect(host: "api.clarifai.com", port: 443)
        let authHeaders: HPACKHeaders = ["Authorization": "Key \(Bundle.main.object(forInfoDictionaryKey: "ClarifaiAPIKEY") as! String)"]
        
        client = Clarifai_Api_V2Client(channel: channel, defaultCallOptions: CallOptions(customMetadata: authHeaders))
    }
    
    public struct Response {
        var predictions: [Prediction]
        
        public struct Prediction {
            var name: String
            var probability: Float
        }
    }
}

// MARK: Methods
extension FoodRecognition {
    public func recognize(for food: UIImage, completion: @escaping (Response) -> Void) {
        do {
            let response = try client.postModelOutputs(
                Clarifai_Api_PostModelOutputsRequest.with {
                    $0.modelID = "bd367be194cf45149e75f01d59f77ba7";
                    $0.inputs = [
                        Clarifai_Api_Input.with {
                            $0.data = Clarifai_Api_Data.with {
                                $0.image = Clarifai_Api_Image.with {
                                    $0.base64 = food.pngData()!
                                }
                            }
                        }
                    ]
                }
            ).response.wait()

            if response.status.code != Clarifai_Api_Status_StatusCode.success {
                print("Request failed, response: \(response)")
                completion(Response(predictions: [Response.Prediction(name: "No Data", probability: 0.0)]))
            } else {
                var predictions = Response(predictions: [])
                response.outputs[0].data.concepts.forEach({ (concept) in
                    if concept.value > 0.8 {
                        predictions.predictions.append(Response.Prediction(name: concept.name, probability: concept.value))
                    }
                })
                completion(predictions)
            }
        } catch {
            print(error.localizedDescription)
            completion(Response(predictions: [Response.Prediction(name: "No Data", probability: 0.0)]))
        }
    }
}
