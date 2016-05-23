---
title: Unit testing for async logic with Rxjs
date: 2016-05-21
tags: javascript, rxjs, frp, functional programming
---

There are a lot of approaches for writing async logic in javascript nowadays.
This article does not aim to convince you that rxjs is the only right way, it will just show
one of the features that it gives you almost for free. This feature is the possibility to mock
time in your tests. 
 
## Mock time? Something like having a time travel machine?
Not actually, there is no special magic and this feature is available due to
Schedulers (more about schedulers [here](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/schedulers.md)). Shortly speaking, it is an abstraction
on top of coordinating and executing time dependent operations such as delay, throttle,
debounce, timeout e.t.c

## Little example
Let's assume we have a stream of messages, and for some reason, we need to add delay logic.
```javascript
function getDelayedMessages(stream, scheduler) {
    return stream.delay(100, scheduler)
}
```
Rxjs allows you to test that delay logic with a simple unit test.
And the pretty part is that you don't need actually to wait for 100ms in test, you can
just mock that thing.

```javascript
const chai = require('chai');
const rxAssert = require('chai-rx-assert');
chai.use(rxAssert);
const expect = chai.expect;
const {TestScheduler, ReactiveTest: {onNext, onCompleted}} = require('rx');


describe('Test delay', () => {
    it('test getDelayedMessages', () => {
        const scheduler = new TestScheduler();

        // Create messages for input observable sequence
        // we can define time and value of onNext and
        // time for onCompleted
        const xs = scheduler.createHotObservable(
            onNext(250, 2), // at time 250 we had message with value 2
            onNext(350, 3),
            onCompleted(550)
        );
    
        // passing input messages
        const results = scheduler.startScheduler(() => {
            return getDelayedMessages(xs, scheduler);
        });
    
        const expected = [
            onNext(350, 2), // at time 350 we are expecting value 2
            onNext(450, 3),
            onCompleted(650)
        ]
        
        // asserting result.messages
        expect(results.messages).to.rxEqual(expected)
    });
});
```
> Useful helper for asserting observables - [chai-rx-assert](https://github.com/AlexMost/chai-rx-assert)

If you will follow the comments above you will see how we are setting up
incoming messages times and values and comparing them with output results. So,
all our async logic is now pure and can be covered with unit tests. It acts like a
state machine, so we can specify different sequences of inputs and compare with outputs in tests.
Our *getDelayedMessages* function from example can be a function that returns our application state stream,
and we can check how it changes depending on input messages, their order, and time when they occur.

Modern UI's are tend to be expressed as a changing state container that is binded to view (see [Cycle.js](http://cycle.js.org/),
[Redux](https://github.com/reactjs/redux), [Elm-architecture](https://github.com/evancz/elm-architecture-tutorial)).
All our application can be expressed as a stream of states. That's why the possibility to have such tests is just awesome and seems like will have a great value for
building reliable and robust asynchronous applications in future. 
