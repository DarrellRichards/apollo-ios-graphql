// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ListConfigsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query listConfigs {
      listConfigs {
        __typename
        name
        id
        enabled
      }
    }
    """

  public let operationName: String = "listConfigs"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("listConfigs", type: .list(.object(ListConfig.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(listConfigs: [ListConfig?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "listConfigs": listConfigs.flatMap { (value: [ListConfig?]) -> [ResultMap?] in value.map { (value: ListConfig?) -> ResultMap? in value.flatMap { (value: ListConfig) -> ResultMap in value.resultMap } } }])
    }

    /// Returns a list of all configs
    public var listConfigs: [ListConfig?]? {
      get {
        return (resultMap["listConfigs"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListConfig?] in value.map { (value: ResultMap?) -> ListConfig? in value.flatMap { (value: ResultMap) -> ListConfig in ListConfig(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [ListConfig?]) -> [ResultMap?] in value.map { (value: ListConfig?) -> ResultMap? in value.flatMap { (value: ListConfig) -> ResultMap in value.resultMap } } }, forKey: "listConfigs")
      }
    }

    public struct ListConfig: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Config"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(String.self)),
          GraphQLField("enabled", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, id: String? = nil, enabled: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "Config", "name": name, "id": id, "enabled": enabled])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var id: String? {
        get {
          return resultMap["id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var enabled: Bool? {
        get {
          return resultMap["enabled"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "enabled")
        }
      }
    }
  }
}
