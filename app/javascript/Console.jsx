import React, {Component} from 'react'

class Console extends Component {
  render() {

    const logs = this.props.log.map((log, i) => {
      return <div className={`${log.type}-log`} key={i}>{log.value}</div>
    })

    return(
      <div>{logs}</div>
    )
  }
}
export default Console