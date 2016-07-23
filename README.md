![logo](logo/logo1.png "Choir logo")
# Choir 
__Ambient music synthesis, globally grown__

## Overview

Choir is a website that synthesizes ambient and drone music on the fly based on
attributes of everyone that's connected to the website at that time. It operates
on the idea that everyone is different, comes from different places, and likes
music. By taking advantage of everyone's diversity and the turnaround in
connected users, Choir's music should be constantly changing.

## Technical Stuff

### Quick System Design

Choir is written in [Elixir](http://elixir-lang.org/) and uses the [Phoenix
Framework](http://www.phoenixframework.org/) to take advantage of sockets and
channels. Every client that visits the site opens a channel to the server and
sends an object that contains data about that client (such as temperature,
browser, weather, location, etc.). Then the server adds the client's data to a
struct that tracks aggregate client data (number of total connections, average
temperature of all clients, etc.) and sends a message to all clients with this
updated aggregate data.

When a data change occurs, each client receives a message containing the new
data (aggregate client data) to use to render music. The browser's [Web Audio
API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) is used to
generate new music based on different qualities of the aggregate data.

### Server Specifics

The server keeps track of two things: each client's data and an aggregate of all
client data.
