import React from 'react';
import ReactDOM from 'react-dom';
import "phoenix_html"
import {Socket} from "phoenix"

import App from './App';

window.observationsSocket = new Socket("/socket")

window.observationsSocket.connect()

const channel = window.observationsSocket.channel('observations:list', {});

channel.join()
  .receive("ok", resp => { console.log("ok", resp) })
  .receive("error", resp => { console.log("error", resp) })

ReactDOM.render(<App />, document.getElementById('app'));
