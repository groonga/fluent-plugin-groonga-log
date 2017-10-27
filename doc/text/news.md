# News

## 0.1.2: 2017-10-27

### Improvements

  * Supported groonga-log 0.1.1. In groonga-log 0.1.1, `timestamp`
    field which represents `Time` object is introduced. It causes
    "undefined method to_msgpack" error because fluentd can't handle
    `Time` object in records directly. In this release, above problem
    is resolved. [GitHub#6]

## 0.1.0: 2017-09-26

The first release!!!
