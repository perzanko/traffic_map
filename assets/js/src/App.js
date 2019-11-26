import React from 'react';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      routes: [],
      observations: [],
      newObservation: null,
    }
  }

  componentDidMount() {
    window.observationsChannel.join()
      .receive("ok", () => {
        window.observationsChannel.push("load_observations", {});
        window.observationsChannel.push("load_routes", {});
      })
      .receive("error", resp => {
        console.log("error", resp)
      })

    window.observationsChannel.on('loaded_observations', ({data: observations}) => {
      this.setState({observations})
    })

    window.observationsChannel.on('new_observation', ({data: newObservation}) => {
      const {observations} = this.state;
      observations.push(newObservation)
      this.setState({newObservation, observations})
    })

    window.observationsChannel.on('loaded_routes', ({data: routes}) => {
      this.setState({routes})
    })
  }

  render() {
    const {routes, observations} = this.state;
    const groupedObservations = observations.reduce((acc, observation) => {
      const {action, controller} = observation.application;
      const {method} = observation.request;
      acc[`${controller}:${action}:${method}`] = [...acc[`${controller}:${action}:${method}`] || [], observation];
      return acc;
    }, {})

    console.log(groupedObservations)
    return (
      <>
        routes: {routes.length} <br/>
        observations: {observations.length} <br/>
        <hr/>
        {Object.entries(groupedObservations).map(([_key, observationsArray]) =>
          <div>id: {observationsArray[0].id}</div>
        )}
        <hr/>
        {observations.map(({id, application, request, issuer, created_at, response}) =>
          <div>
            <b>id:</b> {id},{' '}
            <b>controller:</b> {application.controller},{' '}
            <b>action:</b> {application.action},{' '}
            <b>pid:</b> {application.pid},{' '}
            <b>path:</b> {request.path},{' '}
            <b>method:</b> {request.method},{' '}
            <b>status:</b> {response.status},{' '}
            <b>ms:</b> {request.time / 1000},{' '}
          </div>
        )}
      </>
    )
  }
}

export default App;
