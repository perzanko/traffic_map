import React from 'react';
import ReactDOM from 'react-dom';
import "phoenix_html"
import {Socket} from "phoenix"

import App from './App';

window.observationsSocket = new Socket("/socket")
window.observationsSocket.connect()
window.observationsChannel = window.observationsSocket.channel('observations', {});

ReactDOM.render(<App />, document.getElementById('app'));
