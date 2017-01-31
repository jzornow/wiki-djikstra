# WikiDjikstra
An implementation of [Djikstra's Algorithm](https://en.wikipedia.org/wiki/Dijkstra's_algorithm) written in Ruby, engineered specifically to traverse Wikipedia page links to navigate from one topic to another.

## Batch-Based Traversal
To minimize the number of calls required to Wikipedia, this algorithm queries pages in batches. I'd never seen anyone try to build a Djikstra's engine with this constraint before, so I hacked together a mechanism that pulls page content in batches sized according to the rate limiting on Wikipedia's API.

At some point, I plan to register this bot with Wikipedia as a `HighAPILimit` user. Once that's done, the bot will be able to query in batches of 500 at a time.

## Current Shortcomings
Right now, the gateway does not know how to handle search terms that lead to disambiguation pages or search terms that point to nothing. Eventually I'd like to add error handling to make the bot a little bit more adaptable.

## My Dream
I'd like to build a pretty front-end interface for this bot that shows graph traversal in real time. I think that'd be the bees knees. If anyone out in cyberspace would like to work with me on this, or even suggest how they'd go about builing this out (D3 + React?), holler at me!
