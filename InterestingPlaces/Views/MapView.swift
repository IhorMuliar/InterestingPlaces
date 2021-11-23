/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import MapKit

struct MapView: View {

  let location: Place
  let places: [Place]

  @State private var region: MKCoordinateRegion
  @State private var mapType: MKMapType = .standard
  @State private var showSearch = false
  @Environment(\.presentationMode) private var presentationMode

  init(location: Place, places: [Place]) {
    self.location = location
    self.places = places
    _region = State(initialValue: location.region)
  }

  var body: some View {
    ZStack {
      MapViewUI(location: location, places: places, mapViewType: mapType)
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(systemName: "xmark.circle.fill")
              .imageScale(.large)
          }
          Spacer()
          Button {
            showSearch.toggle()
          } label: {
            Image(systemName: "magnifyingglass.circle.fill")
              .imageScale(.large)
          }
        }
        .padding()
        Spacer()
        Picker("", selection: $mapType) {
          Text("Standard").tag(MKMapType.standard)
          Text("Hybrid").tag(MKMapType.hybrid)
          Text("Satellite").tag(MKMapType.satellite)
        }
        .pickerStyle(SegmentedPickerStyle())
        .offset(y: -28)
      }
    }
    .edgesIgnoringSafeArea(.all)
    .navigationBarHidden(true)
    .sheet(isPresented: $showSearch) {
      MapSearchView(region: region)
    }
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(location: MapDirectory().places[0], places: MapDirectory().places)
  }
}
