//
//  MapView.swift
//  TransACT
//
//  Created by Braeden Meikle on 9/13/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // random, copied from online, change later
    @State private var defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
        )
    
    var body: some View {
        Map(coordinateRegion: $defaultRegion)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
