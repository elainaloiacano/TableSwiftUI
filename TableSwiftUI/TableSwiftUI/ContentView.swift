//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Loiacano, Elaina on 4/1/24.
//

import SwiftUI
import MapKit



let data = [
    Item(name: "Ballet Austin", neighborhood: "Downtown", desc: "This dance studio offers dance and fitness classes for adults and has a company ballet program for pre-professionals.", lat: 30.266623903411805, long:-97.74909539055025, imageName: "studio1"),
       Item(name: "ElectrikCITY Dance Movement", neighborhood: "Downtown", desc: "A dance studio for all ages 7 and up that offers classes that are mainly hiphop based.", lat: 30.3351078731657, long: -97.71820481753235, imageName: "studio2"),
       Item(name: "Evenground Dance Studio", neighborhood: "North", desc: "This studio is open to students 13 and older, but is more adult based and maily offers hiphop classes.", lat: 30.35187083316567, long: -97.71623304636753, imageName: "studio3"),
       Item(name: "Dance Austin", neighborhood: "North", desc: "This studio is more for adults with limited youth classes and offers a range of classes. ", lat: 30.371631404026886, long: -97.72457337705349, imageName: "studio4"),
       Item(name: "DivaDance", neighborhood: "East", desc: "This studio is only for adults and is a franchise and they host parties as well.", lat: 30.288794610885233, long: -97.70659353287763, imageName: "studio5")
]
   struct Item: Identifiable {
       let id = UUID()
       let name: String
       let neighborhood: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }


struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
               @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.35187083316567, longitude: -97.71820481753235), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.10))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.neighborhood)
                                .font(.subheadline)
                        } // end internal VStack
                    } // end HStack
                } // end navigationlink
                } // end List
                //add this code in the ContentView within the main VStack.
                        Map(coordinateRegion: $region, annotationItems: data) { item in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .overlay(
                                        Text(item.name)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: true, vertical: false)
                                            .offset(y: 25)
                                    )
                            }
                        } // end map
                        .frame(height: 300)
                        .padding(.bottom, -30)
            } // end VStack
            .listStyle(PlainListStyle())
                   .navigationTitle("Austin Dance Studios")
               } // end NavigationView
    } // end body
}


struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
         @State private var region: MKCoordinateRegion
         
         init(item: Item) {
             self.item = item
             _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
         }
    let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                Text("Neighborhood: \(item.neighborhood)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                     Map(coordinateRegion: $region, annotationItems: [item]) { item in
                       MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                           Image(systemName: "mappin.circle.fill")
                               .foregroundColor(.red)
                               .font(.title)
                               .overlay(
                                   Text(item.name)
                                       .font(.subheadline)
                                       .foregroundColor(.black)
                                       .fixedSize(horizontal: true, vertical: false)
                                       .offset(y: 25)
                               )
                       }
                   } // end Map
                       .frame(height: 300)
                       .padding(.bottom, -30)
            } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
         } // end body
      } // end DetailView
    

#Preview {
    ContentView()
}
