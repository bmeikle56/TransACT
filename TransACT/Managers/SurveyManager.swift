//
//  SurveyManager.swift
//  TransACT
//
//  Created by Chengkai Yao on 4/1/22.
//

import Foundation

/**
 All of the functions for Survey display and notification are contained in this class.
 */
class SurveyManager {
    static func fetchSurveys(user: User, completion: @escaping (Result<[SurveyItem], Error>) -> Void) async {
        
        var surveys: [SurveyItem] = []
        let db = FirebaseManager.getFirestore()
        let _ = db.collection("surveys").getDocuments() { (querySnapshot, err) in
            if let err = err {
                //print("Error getting surveys: \(err)")
                completion(.failure(err))
            } else {
                db.collection("users").document(user.uid).getDocument() { (document, err) in
                    if let err = err {
                        //print("Error getting user surveys: \(err)")
                        completion(.failure(err))
                    } else {
                        let survey_finished = Set<String>((document?.data()?["survey_finished"] ?? ["nil"]) as! [String])
                        
                        for survey in querySnapshot!.documents {
                            print(survey.data())
                            if let name = survey.data()["name"] as? String, let url = survey.data()["url"] as? String {
                                surveys.append(SurveyItem(id: survey.documentID,
                                                          name: name,
                                                          url: url, finished: survey_finished.contains(survey.documentID)))
                            }
                            else {
                                print("Survey \(survey.documentID) misses as least one of the attributes: name, url")
                            }
                        }
                        completion(.success(surveys))
                    }
                }
                
            }
        }
        
    }
}

/**
 SurveyItem with important information
 */
struct SurveyItem: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var url: String
    var finished: Bool
}
