import React, {Component} from 'react'

class Console extends Component {
  render() {

    const logs = this.props.log.map((log, i) => {
      return <div key={i}>{log}</div>
    })

    return(
      <div>{logs}</div>
    )
  }
}
export default Console