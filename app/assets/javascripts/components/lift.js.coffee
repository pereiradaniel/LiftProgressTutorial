coefficients = {
  1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@Lift = React.createClass
  getInitialState: ->
    edit: false
    onerm: @props.lift.onerm
    ismetric: @props.lift.ismetric
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/lifts/#{ @props.lift.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteLift @props.lift
  handleEdit: (e) ->
    e.preventDefault()
    data =
      date: ReactDOM.findDOMNode(@refs.date).value
      liftname: ReactDOM.findDOMNode(@refs.liftname).value
      weightlifted: ReactDOM.findDOMNode(@refs.weightlifted).value
      ismetric: @state.ismetric
      repsperformed: ReactDOM.findDOMNode(@refs.repsperformed).value
      onerm: @state.onerm
    $.ajax
      method: 'PUT'
      url: "/lifts/#{ @props.lift.id }"
      dataType: 'JSON'
      data:
        lift: data
      success: (data) =>
        @setState edit: false
        @props.handleEditLift @props.lift, data
  reCalculateOneRm: ->
    @setState onerm: @getOneRm( ReactDOM.findDOMNode(@refs.weightlifted).value, ReactDOM.findDOMNode(@refs.repsperformed).value)
  getOneRm: (weight, reps) ->
    if weight and reps > 0 and reps < 11
      weight / coefficients[reps]
    else
      0
  toggleUnit: (e) ->
    e.preventDefault()
    @setState ismetric: !@state.ismetric
  liftRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.lift.date
      React.DOM.td null, @props.lift.liftname
      React.DOM.td null, @props.lift.weightlifted
      React.DOM.td null, @props.lift.repsperformed
      React.DOM.td null, @props.lift.onerm
      React.DOM.td null, @props.lift.ismetric.toString()
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleToggle
          'Edit'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  liftForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'date'
          defaultValue: @props.lift.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.lift.liftname
          ref: 'liftname'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.lift.weightlifted
          ref: 'weightlifted'
          onChange: @reCalculateOneRm
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          min: '1'
          max: '10'
          defaultValue: @props.lift.repsperformed
          ref: 'repsperformed'
          onChange: @reCalculateOneRm
      React.DOM.td null,
        @state.onerm
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @toggleUnit
          'Metric = ' + @state.ismetric.toString()
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleEdit
          'Update'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @liftForm()
    else
      @liftRow()
