// NOTE: The contents of this file will only be executed if you uncomment its
// entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket and connect at
// the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix";

let token = $("meta[name=channel_token]").attr("content");
let socket = new Socket("/socket", {params: {token: token}});

socket.connect();

// Now that you are connected, you can join channels with a topic:
// let channel = socket.channel("voices", {});

let connectBtn = $("#connect-btn");
let connectionsSection = $("#connections>.info");

// channel.on("voice_update", payload => {
//   connectionsSection.text(payload.connections);
// });



export default socket
