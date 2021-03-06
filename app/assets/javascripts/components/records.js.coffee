@Records = React.createClass
  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  addRecord: (record) ->
    records = @state.records.slice()
    records.push record
    @setState records: records
    ###
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records
    ###

  updateRecord: (record, data) ->
    records = @state.records.slice()
    index = records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @setState records: records

  deleteRecord: (record) ->
    records = @state.records.slice()
    index = records.indexOf record
    records.splice index, 1
    @replaceState records: records
    ###
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @setState records: records
    ###
  
  credits: ->
    credits = @state.records.filter (val) ->
      val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  
  debits: ->
    debits = @state.records.filter (val) ->
      val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  balance: ->
    @credits() + @debits()

  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
      React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
      React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
      React.DOM.hr null
      React.createElement RecordForm, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Amount'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleUpdateRecord: @updateRecord
