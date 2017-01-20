# passablewords

> Is your password unique enough? Check against the million most common passwords

In a world filled with data breaches and IoT botnets, it's important to make sure you're adequately protecting yourself.

While not perfect, making sure you have a unique password helps against dictionary attacks. `passablewords` checks your (or your user's) passwords against one million of the most common passwords.

- [API](#api)
- [Self hosting](#self-hosting)
- [Running locally](#running-locally)

# API

This is a public api, free for you to use in your projects. Nothing is logged on the server, and only HTTPS is allowed. The project is build with Swift, and is available as a docker image. For more info on self-hosting, visit the Github readme.
Making a request

## Making a request

To use, make a `POST` request to `https://passablewords.now.sh/` with a JSON body similar to the one below.

```json
{
  "password": "test1234"
}
```

Unless something went wrong server-side, you can expect a response with a 200 status and a JSON body. The body will contain an error key if one occured, and a message key explaining the response.

```json
{
  "message": "That password is not one of the most common million passwords. Nice."
}
```

```json
{
  "error": "ETOOCOMMON",
  "message": "That password is too common. Choose a more unique password."
}
```

## Error handling

There are 3 possible error codes that can be returned

### `EINTERNALSERVERERROR`
Something went wrong when processing the request that wasn't anticipated

### `EINVALID`
The request body sent over didn't match what was expected. See the message for more detail.

### `ETOOCOMMON`
The password that was checked was found in the list. It's too common and shouldn't be allowed.

# Self hosting

As this project is open source, you're free to host this yourself if you feel like it or don't want to hit a public api. The recommended way of doing this is via a docker image pulled down from the [docker hub](https://hub.docker.com/r/beardfury/passablewords).

```sh
# pull down the docker container
docker pull beardfury/passablewords

# run the docker container as a daemon
docker run -d passablewords
```

# Running locally

As this is a swift project, local development is only supported on macOS and Ubuntu. To install Swift on your computer, read the [Getting Started](https://swift.org/getting-started/) section of the swift website.

This project uses the Swift Package Manager, so after you have the project downloaded and Swift installed, install the dependencies and build the project.

```sh
# download the packages
swift package fetch

# build the debug target
swift build
```

After the build finishes, you can now run the server locally!

```sh
# run the server on port 3000
.build/debug/passablewords
```

# [LICENSE](LICENSE.md)

# [Code of Conduct](CODE_OF_CONDUCT.md)
