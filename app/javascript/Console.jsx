import React, {Component} from 'react'

class Console extends Component {
  render() {

    const logs = this.props.log.map((log, i) => {
      switch (log.type) {
        case 'game':
          return <div className="game-log" key={i}>{log.value}</div>
          break
        case 'user':
          return <div className="user-log" key={i}>>> {log.value}</div>
          break
        case 'system':
          return <div className="system-log" key={i}>{log.value}</div>
          break
      }
    })

    return(
      <div>{logs}</div>
    )
  }
}
export default Console