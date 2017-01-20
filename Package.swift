import PackageDescription

let package = Package(
    name: "passablewords",
    targets: [],
    dependencies: [
      .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2)
    ]
)
