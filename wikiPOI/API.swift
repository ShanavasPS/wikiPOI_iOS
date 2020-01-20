//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum Mode: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// AIRPLANE
  case airplane
  /// BICYCLE
  case bicycle
  /// BUS
  case bus
  /// CABLE_CAR
  case cableCar
  /// CAR
  case car
  /// FERRY
  case ferry
  /// FUNICULAR
  case funicular
  /// GONDOLA
  case gondola
  /// Only used internally. No use for API users.
  case legSwitch
  /// RAIL
  case rail
  /// SUBWAY
  case subway
  /// TRAM
  case tram
  /// A special transport mode, which includes all public transport.
  case transit
  /// WALK
  case walk
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "AIRPLANE": self = .airplane
      case "BICYCLE": self = .bicycle
      case "BUS": self = .bus
      case "CABLE_CAR": self = .cableCar
      case "CAR": self = .car
      case "FERRY": self = .ferry
      case "FUNICULAR": self = .funicular
      case "GONDOLA": self = .gondola
      case "LEG_SWITCH": self = .legSwitch
      case "RAIL": self = .rail
      case "SUBWAY": self = .subway
      case "TRAM": self = .tram
      case "TRANSIT": self = .transit
      case "WALK": self = .walk
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .airplane: return "AIRPLANE"
      case .bicycle: return "BICYCLE"
      case .bus: return "BUS"
      case .cableCar: return "CABLE_CAR"
      case .car: return "CAR"
      case .ferry: return "FERRY"
      case .funicular: return "FUNICULAR"
      case .gondola: return "GONDOLA"
      case .legSwitch: return "LEG_SWITCH"
      case .rail: return "RAIL"
      case .subway: return "SUBWAY"
      case .tram: return "TRAM"
      case .transit: return "TRANSIT"
      case .walk: return "WALK"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Mode, rhs: Mode) -> Bool {
    switch (lhs, rhs) {
      case (.airplane, .airplane): return true
      case (.bicycle, .bicycle): return true
      case (.bus, .bus): return true
      case (.cableCar, .cableCar): return true
      case (.car, .car): return true
      case (.ferry, .ferry): return true
      case (.funicular, .funicular): return true
      case (.gondola, .gondola): return true
      case (.legSwitch, .legSwitch): return true
      case (.rail, .rail): return true
      case (.subway, .subway): return true
      case (.tram, .tram): return true
      case (.transit, .transit): return true
      case (.walk, .walk): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Mode] {
    return [
      .airplane,
      .bicycle,
      .bus,
      .cableCar,
      .car,
      .ferry,
      .funicular,
      .gondola,
      .legSwitch,
      .rail,
      .subway,
      .tram,
      .transit,
      .walk,
    ]
  }
}

public enum WheelchairBoarding: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// There is no accessibility information for the stop.
  case noInformation
  /// At least some vehicles at this stop can be boarded by a rider in a wheelchair.
  case possible
  /// Wheelchair boarding is not possible at this stop.
  case notPossible
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "NO_INFORMATION": self = .noInformation
      case "POSSIBLE": self = .possible
      case "NOT_POSSIBLE": self = .notPossible
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .noInformation: return "NO_INFORMATION"
      case .possible: return "POSSIBLE"
      case .notPossible: return "NOT_POSSIBLE"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: WheelchairBoarding, rhs: WheelchairBoarding) -> Bool {
    switch (lhs, rhs) {
      case (.noInformation, .noInformation): return true
      case (.possible, .possible): return true
      case (.notPossible, .notPossible): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [WheelchairBoarding] {
    return [
      .noInformation,
      .possible,
      .notPossible,
    ]
  }
}

public final class PlanQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query plan($fromlat: Float!, $fromlon: Float!, $tolat: Float!, $tolon: Float!) {
      plan(from: {lat: $fromlat, lon: $fromlon}, to: {lat: $tolat, lon: $tolon}) {
        __typename
        itineraries {
          __typename
          startTime
          endTime
          walkDistance
          duration
          legs {
            __typename
            mode
            duration
            startTime
            endTime
            legGeometry {
              __typename
              length
              points
            }
            intermediateStops {
              __typename
              name
            }
            from {
              __typename
              lat
              lon
              name
              stop {
                __typename
                code
                name
                gtfsId
              }
            }
            to {
              __typename
              lat
              lon
              name
            }
            trip {
              __typename
              tripHeadsign
              routeShortName
              tripGeometry {
                __typename
                length
                points
              }
            }
          }
        }
      }
    }
    """

  public let operationName = "plan"

  public var fromlat: Double
  public var fromlon: Double
  public var tolat: Double
  public var tolon: Double

  public init(fromlat: Double, fromlon: Double, tolat: Double, tolon: Double) {
    self.fromlat = fromlat
    self.fromlon = fromlon
    self.tolat = tolat
    self.tolon = tolon
  }

  public var variables: GraphQLMap? {
    return ["fromlat": fromlat, "fromlon": fromlon, "tolat": tolat, "tolon": tolon]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("plan", arguments: ["from": ["lat": GraphQLVariable("fromlat"), "lon": GraphQLVariable("fromlon")], "to": ["lat": GraphQLVariable("tolat"), "lon": GraphQLVariable("tolon")]], type: .object(Plan.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(plan: Plan? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "plan": plan.flatMap { (value: Plan) -> ResultMap in value.resultMap }])
    }

    /// Plans an itinerary from point A to point B based on the given arguments
    public var plan: Plan? {
      get {
        return (resultMap["plan"] as? ResultMap).flatMap { Plan(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "plan")
      }
    }

    public struct Plan: GraphQLSelectionSet {
      public static let possibleTypes = ["Plan"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("itineraries", type: .nonNull(.list(.object(Itinerary.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(itineraries: [Itinerary?]) {
        self.init(unsafeResultMap: ["__typename": "Plan", "itineraries": itineraries.map { (value: Itinerary?) -> ResultMap? in value.flatMap { (value: Itinerary) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of possible itineraries
      public var itineraries: [Itinerary?] {
        get {
          return (resultMap["itineraries"] as! [ResultMap?]).map { (value: ResultMap?) -> Itinerary? in value.flatMap { (value: ResultMap) -> Itinerary in Itinerary(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Itinerary?) -> ResultMap? in value.flatMap { (value: Itinerary) -> ResultMap in value.resultMap } }, forKey: "itineraries")
        }
      }

      public struct Itinerary: GraphQLSelectionSet {
        public static let possibleTypes = ["Itinerary"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("startTime", type: .scalar(String.self)),
          GraphQLField("endTime", type: .scalar(String.self)),
          GraphQLField("walkDistance", type: .scalar(Double.self)),
          GraphQLField("duration", type: .scalar(String.self)),
          GraphQLField("legs", type: .nonNull(.list(.object(Leg.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(startTime: String? = nil, endTime: String? = nil, walkDistance: Double? = nil, duration: String? = nil, legs: [Leg?]) {
          self.init(unsafeResultMap: ["__typename": "Itinerary", "startTime": startTime, "endTime": endTime, "walkDistance": walkDistance, "duration": duration, "legs": legs.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Time when the user leaves from the origin. Format: Unix timestamp in milliseconds.
        public var startTime: String? {
          get {
            return resultMap["startTime"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "startTime")
          }
        }

        /// Time when the user arrives to the destination.. Format: Unix timestamp in milliseconds.
        public var endTime: String? {
          get {
            return resultMap["endTime"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endTime")
          }
        }

        /// How far the user has to walk, in meters.
        public var walkDistance: Double? {
          get {
            return resultMap["walkDistance"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "walkDistance")
          }
        }

        /// Duration of the trip on this itinerary, in seconds.
        public var duration: String? {
          get {
            return resultMap["duration"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "duration")
          }
        }

        /// A list of Legs. Each Leg is either a walking (cycling, car) portion of the
        /// itinerary, or a transit leg on a particular vehicle. So a itinerary where the
        /// user walks to the Q train, transfers to the 6, then walks to their
        /// destination, has four legs.
        public var legs: [Leg?] {
          get {
            return (resultMap["legs"] as! [ResultMap?]).map { (value: ResultMap?) -> Leg? in value.flatMap { (value: ResultMap) -> Leg in Leg(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Leg?) -> ResultMap? in value.flatMap { (value: Leg) -> ResultMap in value.resultMap } }, forKey: "legs")
          }
        }

        public struct Leg: GraphQLSelectionSet {
          public static let possibleTypes = ["Leg"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("mode", type: .scalar(Mode.self)),
            GraphQLField("duration", type: .scalar(Double.self)),
            GraphQLField("startTime", type: .scalar(String.self)),
            GraphQLField("endTime", type: .scalar(String.self)),
            GraphQLField("legGeometry", type: .object(LegGeometry.selections)),
            GraphQLField("intermediateStops", type: .list(.object(IntermediateStop.selections))),
            GraphQLField("from", type: .nonNull(.object(From.selections))),
            GraphQLField("to", type: .nonNull(.object(To.selections))),
            GraphQLField("trip", type: .object(Trip.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(mode: Mode? = nil, duration: Double? = nil, startTime: String? = nil, endTime: String? = nil, legGeometry: LegGeometry? = nil, intermediateStops: [IntermediateStop?]? = nil, from: From, to: To, trip: Trip? = nil) {
            self.init(unsafeResultMap: ["__typename": "Leg", "mode": mode, "duration": duration, "startTime": startTime, "endTime": endTime, "legGeometry": legGeometry.flatMap { (value: LegGeometry) -> ResultMap in value.resultMap }, "intermediateStops": intermediateStops.flatMap { (value: [IntermediateStop?]) -> [ResultMap?] in value.map { (value: IntermediateStop?) -> ResultMap? in value.flatMap { (value: IntermediateStop) -> ResultMap in value.resultMap } } }, "from": from.resultMap, "to": to.resultMap, "trip": trip.flatMap { (value: Trip) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The mode (e.g. `WALK`) used when traversing this leg.
          public var mode: Mode? {
            get {
              return resultMap["mode"] as? Mode
            }
            set {
              resultMap.updateValue(newValue, forKey: "mode")
            }
          }

          /// The leg's duration in seconds
          public var duration: Double? {
            get {
              return resultMap["duration"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "duration")
            }
          }

          /// The date and time when this leg begins. Format: Unix timestamp in milliseconds.
          public var startTime: String? {
            get {
              return resultMap["startTime"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "startTime")
            }
          }

          /// The date and time when this leg ends. Format: Unix timestamp in milliseconds.
          public var endTime: String? {
            get {
              return resultMap["endTime"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endTime")
            }
          }

          /// The leg's geometry.
          public var legGeometry: LegGeometry? {
            get {
              return (resultMap["legGeometry"] as? ResultMap).flatMap { LegGeometry(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "legGeometry")
            }
          }

          /// For transit legs, intermediate stops between the Place where the leg
          /// originates and the Place where the leg ends. For non-transit legs, null.
          public var intermediateStops: [IntermediateStop?]? {
            get {
              return (resultMap["intermediateStops"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [IntermediateStop?] in value.map { (value: ResultMap?) -> IntermediateStop? in value.flatMap { (value: ResultMap) -> IntermediateStop in IntermediateStop(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [IntermediateStop?]) -> [ResultMap?] in value.map { (value: IntermediateStop?) -> ResultMap? in value.flatMap { (value: IntermediateStop) -> ResultMap in value.resultMap } } }, forKey: "intermediateStops")
            }
          }

          /// The Place where the leg originates.
          public var from: From {
            get {
              return From(unsafeResultMap: resultMap["from"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "from")
            }
          }

          /// The Place where the leg ends.
          public var to: To {
            get {
              return To(unsafeResultMap: resultMap["to"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "to")
            }
          }

          /// For transit legs, the trip that is used for traversing the leg. For non-transit legs, `null`.
          public var trip: Trip? {
            get {
              return (resultMap["trip"] as? ResultMap).flatMap { Trip(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "trip")
            }
          }

          public struct LegGeometry: GraphQLSelectionSet {
            public static let possibleTypes = ["Geometry"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("length", type: .scalar(Int.self)),
              GraphQLField("points", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(length: Int? = nil, points: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Geometry", "length": length, "points": points])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The number of points in the string
            public var length: Int? {
              get {
                return resultMap["length"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "length")
              }
            }

            /// List of coordinates of in a Google encoded polyline format (see
            /// https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
            public var points: String? {
              get {
                return resultMap["points"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "points")
              }
            }
          }

          public struct IntermediateStop: GraphQLSelectionSet {
            public static let possibleTypes = ["Stop"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Stop", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Name of the stop, e.g. Pasilan asema
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct From: GraphQLSelectionSet {
            public static let possibleTypes = ["Place"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
              GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("stop", type: .object(Stop.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(lat: Double, lon: Double, name: String? = nil, stop: Stop? = nil) {
              self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name, "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Latitude of the place (WGS 84)
            public var lat: Double {
              get {
                return resultMap["lat"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lat")
              }
            }

            /// Longitude of the place (WGS 84)
            public var lon: Double {
              get {
                return resultMap["lon"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lon")
              }
            }

            /// For transit stops, the name of the stop. For points of interest, the name of the POI.
            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The stop related to the place.
            public var stop: Stop? {
              get {
                return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "stop")
              }
            }

            public struct Stop: GraphQLSelectionSet {
              public static let possibleTypes = ["Stop"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .scalar(String.self)),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("gtfsId", type: .nonNull(.scalar(String.self))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(code: String? = nil, name: String, gtfsId: String) {
                self.init(unsafeResultMap: ["__typename": "Stop", "code": code, "name": name, "gtfsId": gtfsId])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Stop code which is visible at the stop
              public var code: String? {
                get {
                  return resultMap["code"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "code")
                }
              }

              /// Name of the stop, e.g. Pasilan asema
              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              /// ÌD of the stop in format `FeedId:StopId`
              public var gtfsId: String {
                get {
                  return resultMap["gtfsId"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "gtfsId")
                }
              }
            }
          }

          public struct To: GraphQLSelectionSet {
            public static let possibleTypes = ["Place"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
              GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
              GraphQLField("name", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(lat: Double, lon: Double, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Place", "lat": lat, "lon": lon, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Latitude of the place (WGS 84)
            public var lat: Double {
              get {
                return resultMap["lat"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lat")
              }
            }

            /// Longitude of the place (WGS 84)
            public var lon: Double {
              get {
                return resultMap["lon"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lon")
              }
            }

            /// For transit stops, the name of the stop. For points of interest, the name of the POI.
            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct Trip: GraphQLSelectionSet {
            public static let possibleTypes = ["Trip"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("tripHeadsign", type: .scalar(String.self)),
              GraphQLField("routeShortName", type: .scalar(String.self)),
              GraphQLField("tripGeometry", type: .object(TripGeometry.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(tripHeadsign: String? = nil, routeShortName: String? = nil, tripGeometry: TripGeometry? = nil) {
              self.init(unsafeResultMap: ["__typename": "Trip", "tripHeadsign": tripHeadsign, "routeShortName": routeShortName, "tripGeometry": tripGeometry.flatMap { (value: TripGeometry) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Headsign of the vehicle when running on this trip
            public var tripHeadsign: String? {
              get {
                return resultMap["tripHeadsign"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "tripHeadsign")
              }
            }

            /// Short name of the route this trip is running. See field `shortName` of Route.
            public var routeShortName: String? {
              get {
                return resultMap["routeShortName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "routeShortName")
              }
            }

            /// Coordinates of the route of this trip in Google polyline encoded format
            public var tripGeometry: TripGeometry? {
              get {
                return (resultMap["tripGeometry"] as? ResultMap).flatMap { TripGeometry(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "tripGeometry")
              }
            }

            public struct TripGeometry: GraphQLSelectionSet {
              public static let possibleTypes = ["Geometry"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("length", type: .scalar(Int.self)),
                GraphQLField("points", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(length: Int? = nil, points: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Geometry", "length": length, "points": points])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The number of points in the string
              public var length: Int? {
                get {
                  return resultMap["length"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "length")
                }
              }

              /// List of coordinates of in a Google encoded polyline format (see
              /// https://developers.google.com/maps/documentation/utilities/polylinealgorithm)
              public var points: String? {
                get {
                  return resultMap["points"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "points")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class StopQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query stop($id: String!) {
      stop(id: $id) {
        __typename
        name
        lat
        lon
        wheelchairBoarding
      }
    }
    """

  public let operationName = "stop"

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("stop", arguments: ["id": GraphQLVariable("id")], type: .object(Stop.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(stop: Stop? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }])
    }

    /// Get a single stop based on its ID, i.e. value of field `gtfsId` (ID format is `FeedId:StopId`)
    public var stop: Stop? {
      get {
        return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "stop")
      }
    }

    public struct Stop: GraphQLSelectionSet {
      public static let possibleTypes = ["Stop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("lat", type: .scalar(Double.self)),
        GraphQLField("lon", type: .scalar(Double.self)),
        GraphQLField("wheelchairBoarding", type: .scalar(WheelchairBoarding.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, lat: Double? = nil, lon: Double? = nil, wheelchairBoarding: WheelchairBoarding? = nil) {
        self.init(unsafeResultMap: ["__typename": "Stop", "name": name, "lat": lat, "lon": lon, "wheelchairBoarding": wheelchairBoarding])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Name of the stop, e.g. Pasilan asema
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Latitude of the stop (WGS 84)
      public var lat: Double? {
        get {
          return resultMap["lat"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      /// Longitude of the stop (WGS 84)
      public var lon: Double? {
        get {
          return resultMap["lon"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lon")
        }
      }

      /// Whether wheelchair boarding is possible for at least some of vehicles on this stop
      public var wheelchairBoarding: WheelchairBoarding? {
        get {
          return resultMap["wheelchairBoarding"] as? WheelchairBoarding
        }
        set {
          resultMap.updateValue(newValue, forKey: "wheelchairBoarding")
        }
      }
    }
  }
}
