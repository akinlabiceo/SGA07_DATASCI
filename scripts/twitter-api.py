#!/usr/bin/python
# -*- coding: utf-8 -*-

import json

# create a dictionary to store your twitter credentials

twitter_cred = dict()

# Enter your own consumer_key, consumer_secret, access_key and access_secret
# Replacing the stars ("********")

twitter_cred['CONSUMER_KEY'] = 'WKltq1f2CIdP0avTVDg3htwjG'
twitter_cred['CONSUMER_SECRET'] = '80O68mGVXdQzsIUUOzx2BDpgCX0yd5crncR2MTHXu6BUJsEybz'
twitter_cred['ACCESS_KEY'] = '889468981425430528-kPezz5Dj5rF359LSWroUXiT07Y2LY8y'
twitter_cred['ACCESS_SECRET'] = 'aiiyPGouBxZkKmAQBTUvFIaAIkqjhOrQ3honfTRkptonR'

# Save the information to a json so that it can be reused in code without exposing
# the secret info to public

with open('twitter_credentials.json', 'w') as secret_info:
    json.dump(twitter_cred, secret_info, indent=4, sort_keys=True)
