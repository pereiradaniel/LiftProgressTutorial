@Lift = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.lift.date
      React.DOM.td null, @props.lift.liftname
      React.DOM.td null, @props.lift.weightlifted
      React.DOM.td null, @props.lift.ismetric.toString()
      React.DOM.td null, @props.lift.repsperformed
      React.DOM.td null, @props.lift.onerm
