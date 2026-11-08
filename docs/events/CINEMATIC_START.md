# CINEMATIC_START

**Status:** Observed nine times in a live VO client on November 8, 2026; argument meaning unconfirmed.

**Callback arguments:** One argument, but **two types observed**:

~~~text
event=CINEMATIC_START
arguments=1
arg1 type=boolean value=false
~~~

and

~~~text
event=CINEMATIC_START
arguments=1
arg1 type=number value=4
~~~

The nine occurrences are the **combined event count** from the broad watcher; the capture does not distinguish how often each argument type occurred.

The historical `Eventtype` reference says this event is raised for in-game cinematics, including undocking and warping. We have **not** established whether the numeric value identifies a cinematic, whether the boolean controls its behavior, or which activities yielded each signature.

For now, consumers should handle both argument types and avoid assuming that a number will always be provided.

**Source:** [November 8 live event survey](2026-11-08-live-event-survey.md).
