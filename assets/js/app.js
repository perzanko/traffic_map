import "phoenix_html"
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {}})

socket.connect()

const channel = socket.channel('observations', {});

channel.connect()
  .receive("ok", resp => { console.log("ok", resp) })
  .receive("error", resp => { console.log("error", resp) })

