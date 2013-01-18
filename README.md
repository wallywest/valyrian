valyrian
========

Convert data to message


Input: => Mongo
Output: => Hash object

{
  _id: ObjectID in archive
  app_id:
  ip:
  user:
  ts:
  action: /created/updated/destroyed/?
  template: (client side template to render with) 
  messages: [
    { 
      type: change,
      value: Object/Hash
    },
    {
      type: subevent,
      value: Message(string)
    }
  ]

}
