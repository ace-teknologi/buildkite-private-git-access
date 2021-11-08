# buildkite-private-git-access

You're using buildkite and looking to make use of a private git repo, here's one way.

Things to note:

*   [Dockerfile](./Dockerfile) has a builder layer that is discarded (this way the
    SSH key in the args doesn't hang around)

*   Check [pre-command](./.buildkite/hooks/pre-command) for the expected SSH key
    location. (Happy for PR on a better option here).
