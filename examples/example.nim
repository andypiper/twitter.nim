import twitter, json, strtabs, httpclient

when isMainModule:
  var parsed = parseFile("credential.json")

  var consumerToken = newConsumerToken(parsed["ConsumerKey"].str,
                                       parsed["ConsumerSecret"].str)
  var twitterAPI = newTwitterAPI(consumerToken,
                                 parsed["AccessToken"].str,
                                 parsed["AccessTokenSecret"].str)

  # Simply get.
  var resp = twitterAPI.get("account/verify_credentials.json")
  echo resp.status

  # ditto, but selected by screen name.
  resp = twitterAPI.user("shitsyndrome")
  echo resp.status

  # Using proc corresponding twitter REST APIs.
  resp = twitterAPI.userTimeline()
  echo parseJson(resp.body)

  # Using `callAPI` template.
  var testStatus = {"status": "test"}.newStringTable
  resp = twitterAPI.callAPI(statusesUpdate, testStatus)
  echo parseJson(resp.body)
