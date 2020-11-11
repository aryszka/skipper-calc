# skipper-calc

This is a [Skipper](https://github.com/zalando/skipper) routing configuration implementing a basic non-negative
integer calculator with the inc, dec, add, sub, mul and div operations.

See the [`test.sh`](./test.sh) for how it works and what it does.

### Not cheating:

It does not use the [`lua()`](https://opensource.zalando.com/skipper/reference/filters/#lua) filter.

### Still cheating:

It uses the various regexp based [predicates](https://opensource.zalando.com/skipper/reference/predicates/) and
[filters](https://opensource.zalando.com/skipper/reference/filters/).
