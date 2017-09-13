# ProximityHash: Geohashes in Proximity

Ported from python library here: https://github.com/ashwin711/proximityhash.

Geohash is a geocoding system invented by Gustavo Niemeyer and placed into the public domain. It is a hierarchical
spatial data structure which subdivides space into buckets of grid shape, which is one of the many applications of
what is known as a Z-order curve, and generally space-filling curves.

Image from original repo to demonstrate output:

![proximityhash demo image][https://raw.github.com/ashwin711/proximityhash/master/images/proximityhash.png]
   
## Usage

```ruby
require 'proximityhash'

proximity_hash = ProximityHash.new(latitude, longitude, radius, precision_level)
proximity_hash.calculate
```

* latitude in decimal degrees
* longitude in decimal degrees
* radius in metres
* precision_level between 1 and 12

### Results

A hash of **geohash** (key) and **distance** (value) (in metres)  ordered by closest to further away.

## Build Status

[![Build Status](https://travis-ci.org/OLIOEX/proximityhash.svg)](https://travis-ci.org/OLIOEX/proximityhash)

## LICENCE

Apache 2.0
