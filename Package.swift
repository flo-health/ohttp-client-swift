// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "OHTTPSwift",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "OHTTPEncapsulation", targets: ["OHTTPEncapsulation"]),
        .library(name: "OHTTPSwift", targets: ["OHTTPSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/flohealth/bhttp-swift.git", from: "0.1.0")
    ],
    targets: [
        .binaryTarget(
            name: "LibAppRelay",
            url: "https://github.com/cloudflare/privacy-gateway-client-library/releases/download/v0.0.7/LibAppRelay.xcframework.zip",
            checksum: "8b4ab526eec38cb60288b58bf13fce635a38777bfc719debcbb54db756f20048"
        ),
        
        .target(
            name: "OHTTPEncapsulation",
            dependencies: ["AppRelayObjc"]
        ),
        
        .target(
            name: "AppRelayObjc",
            dependencies: ["LibAppRelay"],
            publicHeadersPath: "."
        ),
        
        .target(
            name: "OHTTPSwift",
            dependencies: [
                "OHTTPEncapsulation",
                .product(name: "BinaryHTTP", package: "bhttp-swift")
            ]
        ),
        
        .testTarget(
            name: "OHTTPSwiftTests",
            dependencies: ["OHTTPSwift"]
        )
    ]
)
