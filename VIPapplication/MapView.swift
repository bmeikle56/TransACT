//
//  MapView.swift
//  SwiftUIPractice
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import MapboxMaps

struct MapView: UIViewControllerRepresentable {
     
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
       let myResourceOptions = ResourceOptions(accessToken: "YOUR-ACCESS-TOKEN")
       let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
       
       mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
       mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       self.view.addSubview(mapView)
   }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
