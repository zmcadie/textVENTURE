import React, {Component} from 'react'

class Console extends Component {
  render() {

    const logs = this.props.log.map((log) => {
      return <div>{log}</div>
    })

    return(
      <div>{logs}</div>
    )
  }
}
export default Console