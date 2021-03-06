@Record = React.createClass
  getInitialState: ->
    edit: false

  handleEdit: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  handleUpdate: (e) ->
    e.preventDefault()
    data =
      date: ReactDOM.findDOMNode(@refs.date).value
      title: ReactDOM.findDOMNode(@refs.title).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleUpdateRecord @props.record, data

  renderForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.amount
          ref: 'amount'
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleUpdate
          'Update'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleEdit
          'Cancel'

  renderRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, @props.record.amount
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @handleEdit
          'Edit'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  
  render: ->
    if @state.edit
      @renderForm()
    else
      @renderRow()
