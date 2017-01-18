#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

var routes = Routes()

server.documentRoot = "."
server.serverPort = 3000

let passwordsFile = File("\(server.documentRoot)/common-passwords.txt")

guard let passwordList = try? passwordsFile.readString() else {
  Log.terminal(message: "The passwords file doesn't exist. Add a common-passwords.txt file to the project root and start over.")
}

let passwords = Set<String>(passwordList.components(separatedBy: "\n"))

func formatBody (errorCode: String, message: String) -> [String:String] {
  return [
    "error": errorCode,
    "message": message
  ]
}

func respond (response: HTTPResponse, status: HTTPResponseStatus, errorCode: String, message: String) {
  response.status = status
  do {
    try response.setBody(json: formatBody(errorCode: errorCode, message: message))
  } catch {
    return respond(
      response: response,
      status: .internalServerError,
      errorCode: "EINTERNALSERVERERROR",
      message: "Uh oh, something went wrong on our end. Try again."
    )
  }

  response.completed()

  return
}

func searchPasswords (request: HTTPRequest, response: HTTPResponse) {
  let body = request.postBodyString

  guard let data = try? body?.jsonDecode() as? [String:String] else {
    respond(
      response: response,
      status: .badRequest,
      errorCode: "EINVALID",
      message: "The incoming data was malformed. It should be a JSON object of type \"String: String\""
    )

    return
  }

  guard let password = data!["password"] else {
    respond(
      response: response,
      status: .badRequest,
      errorCode: "EINVALID",
      message: "The incoming data was malformed. The POST body should be a JSON object with a \"password\" key set to a string"
    )

    return
  }

  if passwords.contains(password) {
    respond(
      response: response,
      status: .ok,
      errorCode: "ETOOCOMMON",
      message: "That password is too common. Choose a more unique password."
    )

    return
  }

  respond(
    response: response,
    status: .ok,
    errorCode: "",
    message: "That password unique enough."
  )
}

func notFound (request: HTTPRequest, response: HTTPResponse) {
  response.status = .notFound
  response.completed()

  return
}

routes.add(method: .post, uri: "/", handler: searchPasswords)
routes.add(uri: "/**", handler: notFound)

server.addRoutes(routes)

do {
  try server.start()
} catch PerfectError.networkError(let err, let msg) {
  print("Network error thrown: \(err) \(msg)")
}
