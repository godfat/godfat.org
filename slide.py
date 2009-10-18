#!/usr/bin/env python

# for old slides link, redirect to new slide link

import wsgiref.handlers
from google.appengine.ext import webapp

class SlideHandler(webapp.RequestHandler):
  def get(self):
    self.redirect(self.request.path.replace('slides', 'slide'))

def slide():
  application = webapp.WSGIApplication( [(r'/slides/.*', SlideHandler)],
                                        debug = True )
  wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
  slide()
