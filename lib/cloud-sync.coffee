Storage = require('./storage-client')

module.exports =

  storage: null

  activate: (state) ->

    creds =
      provider: 'rackspace'
      username: process.env.OS_USERNAME
      apiKey: process.env.OS_PASSWORD
      region: process.env.OS_REGION_NAME

    @storage = new Storage(creds)

    getSelectedView = ->
      selectedView = atom.workspaceView.find('.tree-view .selected')?.view()

    uploadFile = =>
      view = getSelectedView()
      itemPath = view.getPath()

      if itemPath?
        fileName = view.fileName.text()

        console.log("Synergizing #{ itemPath } with the cloud")

        @storage.uploadFile(itemPath, "cloudsync", fileName)

    atom.workspaceView.command 'cloud-sync:sync', uploadFile
