@description('The resource ID to apply the lock to.')
param resourceId string

@description('The name of the lock.')
param lockName string = 'DontDelete'

@allowed([
  'CanNotDelete'
  'ReadOnly'
])
@description('The lock level: CanNotDelete or ReadOnly.')
param lockLevel string = 'CanNotDelete'

@description('Notes about this lock.')
param lockNotes string = 'Prevents deletion of the resource.'

resource lockResource 'Microsoft.Authorization/locks@2020-05-01' = {
  scope: resourceId
  name: lockName
  properties: {
    level: lockLevel
    notes: lockNotes
  }
}
