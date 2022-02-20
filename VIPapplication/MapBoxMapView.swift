//
//  MapView.swift
//  SwiftUIPractice
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import MapboxMaps

struct MapBoxMapView: UIViewControllerRepresentable {
     
    func makeUIViewController(context: Context) -> MapViewController {
           return MapViewController()
       }
      
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
    }
}

class MapViewController: UIViewController {
   internal var mapView: MapView!
   override public func viewDidLoad() {
       super.viewDidLoad()
       let myResourceOptions = ResourceOptions(accessToken: "sk.eyJ1IjoiYm1laWtsZTMiLCJhIjoiY2t6bGh2cTN4NTJnaDJycDR3Zjlob3pmbiJ9.jvnZBZifWQN4zuApx979Ug")
       let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
       
       mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
       mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       self.view.addSubview(mapView)
   }
}

struct MapBoxMapView_Previews: PreviewProvider {
    static var previews: some View {
        MapBoxMapView()
            .navigationBarBackButtonHidden(true)
    }
}
