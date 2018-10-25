This repo contains an implementation of the Homa transport protocol for Linux.

- For details on the protocol, see the paper [Homa: A Receiver-Driven Low-Latency
  Transport Protocol Using Network Priorities](https://dl.acm.org/citation.cfm?id=3230564).

- The code here is a very early-stage work in progress. As of October 2018, Homa
  has barely enough functionality to transmit simple RPC requests and responses
  (see the "invoke" test in tests/homa_test.c for an example), but it is still far
  from complete. Here is a partial list of functionality that is still missing:
  - The priority mechanism is not fully implemented.
  - There are no timeouts or retransmissions when packets are lost.
  - The throttling mechanism to limit queueing in source NICs hasn't been
    implemented.
  - Big chunks of Linux plumbing are still missing (e.g., Homa doesn't yet
    connect with the select or poll mechanisms).
  - Error returns are very primitive.
  - Socket buffer memory mangement is very primitive, so large messages (hundreds
    of KB?) will cause buffer exhaustion and deadlock.
  - There has been no performance analysis or tuning.

- This code has been tested against Linux v4.16.10; it probably won't work
  for any other version of Linux without some massaging.

- To build the module, type "make all"; then type "insmod homa.ko" to install
  it, and "rmmod homa" to remove an installed module.

- The subdirectory "unit" contains unit tests, which you can run by typing
  "make" in that subdirectory.
  
- The subdirectory "tests" contains an assortment of programs that may be
  useful in exercising Homa. Compile them by typing "make" in that
  subdirectory.
