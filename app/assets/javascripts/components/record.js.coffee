@Record = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, @props.record.amount
      React.DOM.td null,
        React.DOM.button
          className: 'btn btn-primary'
          'Edit'
        React.DOM.button
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
