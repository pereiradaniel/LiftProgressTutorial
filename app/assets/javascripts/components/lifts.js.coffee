@Lifts = React.createClass
  getInitialState: ->
    lifts: @props.data
  getDefaultProps: ->
    lifts: []
  render: ->
    React.DOM.div
      className: 'lifts'
      React.DOM.h1
        className: 'title'
        'Lifts'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Lift Name'
            React.DOM.th null, 'Weight Lifted'
            React.DOM.th null, 'Reps Performed'
            React.DOM.th null, '1 RM'
          React.DOM.tbody null,
            for lift in @state.lifts
              React.createElement Lift, key: lift.id, lift: lift