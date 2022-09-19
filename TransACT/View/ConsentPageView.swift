//
//  ConsentPageView.swift
//  TransACT
//
//  Created by Viswa Sri Rupa Anne on 9/16/22.
//

import SwiftUI

struct ConsentPageView: View {
    var body: some View {
        VStack {
                    Text("Georgia Tech Travel Study").font(.custom("PTMono-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    HStack {
                        Image("GTLogo")
                            .resizable()
                            .frame(width: 150, height: 150)
                        Spacer().frame(width: 60)
                        Image("PeachTreeCornersLogo")
                            .resizable()
                            .frame(width: 100, height: 150)
                    }
                    Spacer().frame(height:50)
                    ScrollView {
                        Group {
                            Text("You are being asked to be a volunteer in a research study. The purpose of this study is to promote sustainable travel within the City of Peachtree Corners, GA.").padding()
                            
                            Text("Study Procedure").font(.custom("PTMono-Bold", size: 15))
                                .multilineTextAlignment(.center)
                            
                            Text("You will participate in the study for four continuous weeks, during the period of July 2022 and October 2022. In these four weeks, you will be asked to share your location data by using this mobile app. This app will automatically track and store location. You will not need to send us the data but merely ensure location data is turned on your mobile phone. In addition, you will be asked to complete a travel survey which you will find in this app. The survey includes questions about your travel habits and preferences and will take approximately 15-20 minutes to complete.").padding()
                            
                            
                            Text("Possible Future Participation").font(.custom("PTMono-Bold", size: 15))
                                .multilineTextAlignment(.center)
                            
                            Text("This study is conducted over a three-year period. Therefore, we may contact you next year (2023), and the year after that (2024), through your email address, offering you to participate in it again. You do not need to commit to any future participation now. In the second and third years, you will be asked to participate in the study for six to eight weeks each year. During this time, we will ask you to complete a travel survey (completion time will be approximately 10-15 min) and share your location data. We may also provide you with some personalized travel suggestions and offer you monetary incentives for engaging in various sustainable behaviors during future participation. For example, we may suggest a new shared bike service, unless you indicate in the survey that you cannot ride a bike or are not interested in such services.").padding()
                            
                            Text("Confidentiality").font(.custom("PTMono-Bold", size: 15))
                                .multilineTextAlignment(.center)
                            
                            Text("Data collected in this study will be used only by the research team and will not be transferred to a third party. The only identifying information that we will ask you to provide is your first name and email address. All data collected will be kept confidential.").padding()
                            
                            Text("The following procedures will be taken to protect your personal information: We will comply with any applicable laws and regulations regarding confidentiality. To protect your privacy, your records will be kept under a participant code number rather than under your name or email address. Only members of the research team will be allowed to look at your record files. Your name and email address and any other facts that might point to you will not appear when the results of this study will be presented/published. However, in the future, we may strip your data of all information that could identify you and share the de-identified information for purposes of future research without attaining additional consent from you.  ").padding()
                            
                            Text("Your participation in this study is gratefully acknowledged. It is possible that your information/data will be enormously valuable for other research purposes. Thus, your de-identified information/data may be shared by the research team with other researchers in future studies. In such a case, your identity will be completely separated from your information/data. Future researchers will not have a way to identify you. Any future research must be approved by an ethics committee before being undertaken. ").padding()
                            
                            Text("Potential Risks and Rights").font(.custom("PTMono-Bold", size: 15))
                                .multilineTextAlignment(.center)
                            
                        }
                        
                        Group {
                            
                            
                            Text("The risks involved in this study are no greater than those involved in daily activities. There are no costs to you, other than your time, for participating in this study. ").padding()
                            
                            Text("Compensation").font(.custom("PTMono-Bold", size: 15))
                                .multilineTextAlignment(.center)
                            
                            Text("After completing your participation in the first year of the study, we will send you an online Amazon gift card for the value of $25. For full compensation, you must complete the travel survey and allow us access to your location data for four weeks. If you complete only one of these requirements, you will receive partial compensation of $10 in Amazon gift card.").padding()
                            
                            Text("If you choose to participate in the study next year (2023), and/or the year after that (2024), we will send you an Amazon gift card of $20 for full compensation for each year. Partial compensation of $10 in Amazon gift card will be given if you complete only one of the study requirements. In addition, you will receive up to $20 in each study year, based on the incentives you will gain.").padding()
                            
                            Text("U.S. Tax Law requires that a 1099-misc be issued if U.S. tax residents receive $600 or more per calendar year. If non-U.S. tax residents receive more than $75, mandatory 30% withholding is required. Your address and Tax I.D. may be collected for compensation purposes only. This information will be shared only with the Georgia Tech department that issues compensation, if any, for your participation. We will comply with any applicable laws and regulations regarding confidentiality. To make sure that this research is being carried out in the proper way, the Georgia Institute of Technology IRB may review study records. The Office of Human Research Protections may also look at study records. If you have any questions about your rights as a research participant, you may contact: Ms. Melanie Clark, Georgia Institute of Technology, Office of Research Integrity Assurance, at (404) 894-6942.").padding()
                            
                            Text("If you have questions, comments, or concerns about this study, please contact Dr. Einat Tenenboim at einat.tenenboim@gatech.edu, or Rupa Anne at vanne3@gatech.edu. We thank you for participating in this study. ").padding()
                            
                            Text("Please check one of the following boxes, indicating your agreement to participate in the study. ").padding()
                            
                            HStack {
                                NavigationLink(destination: SetupView()) {
                                    Text("I do not agree")
                                        .font(.custom("PTMono-Regular", size: 18))
                                        .foregroundColor(.black)
                                }
                                
                                NavigationLink(destination: UserPermissionsView()) {
                                    Text("I agree")
                                        .font(.custom("PTMono-Regular", size: 18))
                                        .foregroundColor(.black)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
    }
}

struct ConsentPageView_Previews: PreviewProvider {
    static var previews: some View {
        ConsentPageView()
    }
}
