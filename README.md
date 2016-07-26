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

Here's a link to the [design doc](https://docs.google.com/document/d/1eBGzf7_cMWRQMCNLnJ5nF65lVlKPaoOmGFziUi0kHbA/edit?usp=sharing).

The server keeps track of two things: each client's data and an aggregate of all
client data.


### Synthesizer Specifics

Here's a link to the [design doc](https://docs.google.com/document/d/1XgDZQiqny1M-P1JgaMXEWcYS4sVbwWF1VQUpQ0Jbknw/edit?usp=sharing).

### Client Specifics

Here's a link to the [design doc](https://docs.google.com/document/d/1MsDBHrfPUlvnMDBOp09t637r2mm7x4kaOHxvujnsl_I/edit?usp=sharing).
